import 'package:disal_entregas/components/loader_component.dart';
import 'package:disal_entregas/helpers/locationHelper.dart';
import 'package:disal_entregas/models/documento.dart';
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
      ),
      body: Center(
        child: 
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _showLoader ? LoaderComponent(text: '...Cargando...'): getContent(),
        )
      ),
    );
  }
  
  Future<void> _getDocumentos() async {
    setState(() => _showLoader = true);
    _documentos = await _dbHelper.getDocumentosClienteDespacho(widget.cliente, widget.idDespacho);
    _documentosFiltro = _documentos;
    setState(() => _showLoader = false);
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
              onChanged: (value) => filterSearch(value),
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
                ElevatedButton(
                  onPressed: _iniciarVisita(), 
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
                    documento : documento
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
                    leading: documento.IconDoc ,
                    title: Text('${documento.documento} - ${documento.tipoDocDesc}',style: TextStyle( fontWeight: FontWeight.bold),),
                    subtitle: Text('Monto: ${NumberFormat.currency(symbol: '₡').format(documento.totalDocumento)}'),
                    trailing: Icon(Icons.keyboard_double_arrow_right, color: Color.fromRGBO(52, 75, 115, 1)),
                    //isThreeLine: true,
                    //dense: true,
                  ),
                  // Row(
                  //   children: [
                  //     SizedBox(width: 55,),
                  //     Text('Fecha Entrega: ${documento.fechaEntrega}'),
                  //   ],
                  // ),
                  // Row(
                  //   //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     SizedBox(width: 55,),
                  //     Text('Estado: ${documento.estadoDesc}'),
                  //     Text(" - "),
                  //     Text('Ruta: ${documento.ruta}',)
                  //   ],
                  // ),
                  // Row(
                  // children: [
                  //   SizedBox(width: 55,),
                  //   Text('Marchamo: ${documento.marchamo}')
                  // ],
                  // )
                  //Text(client.horaLlegada.toString(),style: TextStyle( color: Colors.deepOrange, fontWeight: FontWeight.bold)),
                ],
              ),
          ),
      );
  }
  void filterSearch(String value) {
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
    
   _iniciarVisita() async {

    Position? position = await LocationHelper.getCurrentLocation();
    if (position != null) {
        print ("Latitud: ${position.latitude}, Longitud: ${position.longitude}");

    } else {
        print("No se pudo obtener la ubicación.");
    }
  }
}