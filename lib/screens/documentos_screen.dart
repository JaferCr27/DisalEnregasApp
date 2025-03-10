import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:disal_entregas/components/loader_component.dart';
import 'package:disal_entregas/helpers/app_helper.dart';
import 'package:disal_entregas/helpers/location_helper.dart';
import 'package:disal_entregas/models/documento.dart';
import 'package:disal_entregas/screens/cobro_screen.dart';
import 'package:disal_entregas/screens/documento_detalle_screen.dart';
import 'package:disal_entregas/services/data_services.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class DocumentosScreen extends StatefulWidget {
  final String cliente;
  final int idDespacho;
  const DocumentosScreen({super.key, required this.cliente, required this.idDespacho});
  @override
  State<DocumentosScreen> createState() => _DocumentosScreenState();
}

class _DocumentosScreenState extends State<DocumentosScreen> {
  final _dbHelper = DataServices();
  bool _showLoader = false;
  bool _tieneInicio = false;
  bool _tieneFin = false;
  bool _btnFin = false;
  bool _btnInicio = true;
  List<Documento> _documentos = [];
  List<Documento> _documentosFiltro = [];
  @override
  void initState() {
    super.initState();
    _getDocumentos();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cliente: ${widget.cliente}"),
         actions: [
           IconButton(
            padding: EdgeInsets.all(8.0),
            onPressed: ()=> _getDocumentos(), 
            icon: Icon(Icons.sync)
          ),
          IconButton(
            padding: EdgeInsets.all(8.0),
            onPressed: (){
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => CobroScreen(
                    cliente : widget.cliente,
                    idDespacho: widget.idDespacho,
                    )
                  )
                );
            }, 
            icon: Icon(Icons.paid, color: Colors.green[900],)
          ),
        ],
      ),
      body: 
        Container(
          padding: const EdgeInsets.all(8.0),
          child: _showLoader ? LoaderComponent(text: '...Cargando...'): getContent(),
          ),
    );
  }
  Widget getContent() {
    return _documentos.isEmpty
    ? _noContent()
    : _getListView();
  }
  Widget _noContent() {
    return Container(
      margin: EdgeInsets.all(20),
      child: Center(
        child: Text(
          "Ha ocurrido un error en la cosulta",
          style: TextStyle(fontWeight: FontWeight.bold),
          ),
      ),
    );
  }
  Widget _getListView() {
    return 
        Column(
          children: [
            TextField(
              decoration: InputDecoration(
                isDense: true,
                labelText: 'Buscar',suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                )
                
              ),
              onChanged: (value) => _filterSearch(value),
            ),
            const SizedBox(height: 20,),
            Expanded(
              child: ListView.builder(
                primary: false,
                itemCount: _documentosFiltro.length,
                itemBuilder: (context, index) => buildCard(_documentosFiltro[index]),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              child: 
                Column(
                  children: [
                    Visibility(
                      visible: _btnInicio,
                      child: ElevatedButton(
                        onPressed: ()=> _iniciarVisita(), 
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          elevation: 20,
                          minimumSize: Size.fromHeight(60),
                          shadowColor: Theme.of(context).primaryColor,
                          backgroundColor: Color.fromRGBO(52, 75, 115, 1)
                        ),
                        child:  
                          Text(
                            "Iniciar visita",
                            style:
                            TextStyle (
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),   
                          ),
                      ),
                    ),
                    Visibility(
                      visible: _btnFin,
                      child: ElevatedButton(
                        onPressed: ()=> _finVisita()
                        , 
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          elevation: 20,
                          minimumSize: Size.fromHeight(60),
                          shadowColor: Theme.of(context).primaryColor,
                          backgroundColor: Color.fromRGBO(218, 86, 48, 1)
                        ),
                        child:  
                          Text(
                            "Finalizar visita",
                            style:
                            TextStyle (
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),   
                          ),
                      ),
                    )
                  ],
                ),
                
              )
          ],
          
        );
  }
  Widget buildCard(Documento documento) {
    return 
      Card(
        elevation: 4,
        child: 
          InkWell(
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => DocumentoDetalleScreen(
                    documento : documento,
                    idDespacho: widget.idDespacho,
                    )
                  )
                );
            },
            splashColor: Colors.blue.withAlpha(30),
            child: 
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: documento.iconDoc ,
                    title: Text('${documento.documento} - ${documento.tipoDocDesc}',style: TextStyle( fontWeight: FontWeight.bold),),
                    subtitle: Text('Monto: ${NumberFormat.currency(symbol: '₡').format(documento.totalDocumento)} \nEstado: ${documento.estadoDesc}'),
                    trailing: Icon(Icons.keyboard_double_arrow_right, color: Color.fromRGBO(52, 75, 115, 1)),
                    dense: true,
                  ),
                ],
              ),
          ),
      );
  }
  void _filterSearch(String value) {
      List<Documento> results = []; 
      if (value.isEmpty) {
        results = _documentos;
      }else{
        results = _documentos
          .where((item) => item.documento!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      }
      setState(() {
        _documentosFiltro = results;
      });
    }
  Future<void> _iniciarVisita() async {
    _consultaInicioFin('INVI');
  }
  Future<void> _finVisita() async{
    List<Documento> documentos = await _dbHelper.getDocumentosClienteDespacho(widget.cliente, widget.idDespacho);
    bool tienePediente = documentos.where((e)=>e.estado == 'PEND').isNotEmpty;
    if (tienePediente) {
      return showAlertDialog(
        context: context,
        title: 'Fin de visita', 
        message: 'Para finalizar Visita primero debe entregar todos los documentos',
        actions: <AlertDialogAction>[
                    AlertDialogAction(label: 'Aceptar', key: null),
                  ]);  
    }
    _consultaInicioFin('FNVI');
  }
  Future<void> _consultaInicioFin (String accion) async {
    String evento = accion == 'INVI' ? 'Iniciar Visita':  'Finalizar visita';
    var response = await showAlertDialog(
                    context: context,
                    title: evento, 
                    message: '¿Está seguro que quiere $evento?',
                    actions: <AlertDialogAction>[
                                AlertDialogAction(key: 'no', label: 'Cancelar'),
                                AlertDialogAction(key: 'yes', label: 'Aceptar'),
                              ]);
    if (response == 'no') {
      return;
    }    
    setState(() => (_showLoader = true) );
    Position? position = await LocationHelper.getCurrentLocation();
    setState(() => (_showLoader = false) );
    if (position != null) {
      var result = await AppHelper.insertarRegistroEvento(accion, 
                                      position.longitude, 
                                      position.latitude, 
                                      0, 
                                      widget.cliente, 
                                      0, 
                                      widget.idDespacho, 
                                      '0',0
                                      );
      _getDocumentos();
      return AppHelper.alerta(evento,result.message,context);
    } else {
       return AppHelper.alerta('Error','No se pudo obtener la ubicación',context);
    }
  }
  Future<void> _getDocumentos() async {
    setState(() => _showLoader = true);
    _documentos = await _dbHelper.getDocumentosClienteDespacho(widget.cliente, widget.idDespacho);
    _tieneInicio = await _dbHelper.getInicioFin(widget.cliente, widget.idDespacho, 'INVI');
    _tieneFin = await _dbHelper.getInicioFin(widget.cliente, widget.idDespacho,'FNVI');
    // ya termino
    if (_tieneFin) {
      _btnInicio = false;      
      _btnFin = false;      
    } // solo tiene inicio
    else if (_tieneInicio && !_tieneFin) {
      _btnInicio = false;      
      _btnFin = true;      
    }
    
    _documentosFiltro = _documentos;
    setState(() => _showLoader = false);
  }
}