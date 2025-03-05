import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:disal_entregas/components/loader_component.dart';
import 'package:disal_entregas/models/documento.dart';
import 'package:disal_entregas/models/documento_linea.dart';
import 'package:disal_entregas/services/data_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DevolucionCompletaScreen extends StatefulWidget {
  final Documento documento;
  const DevolucionCompletaScreen({super.key, required this.documento});

  @override
  State<DevolucionCompletaScreen> createState() => _DevolucionCompletaScreenState();
}

class _DevolucionCompletaScreenState extends State<DevolucionCompletaScreen> {
  final _dbHelper = DataServices();
  bool _showLoader = false;
  List<DocumentoLinea> _lineas = [];
  List<DocumentoLinea> _lineasFiltro = [];
  @override
  void initState() {
    super.initState();
    _getDocumentoLinea();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.documento.tipoDocDesc.toString(),style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
            padding: EdgeInsets.all(1),
            onPressed: ()=> _entregaCompleta(), 
            icon: Icon(Icons.verified, color: Colors.green[900],)
          ),
          IconButton(
            padding: EdgeInsets.all(1),
              onPressed: ()=> _entregaNula(), 
              icon: Icon(Icons.cancel, color: Colors.red[900],)
            ),
            IconButton(
              padding: EdgeInsets.all(1),
              onPressed: ()=> _imprimirFact(), 
              icon: Icon(Icons.print)
            )
        ],
      ),
      body: 
        Container(
          padding: const EdgeInsets.all(8.0),
          child: _showLoader ? LoaderComponent(text: '...Cargando...') : _getContent(),
        ),
    );
  }
  Widget _buscar() {
    return
     TextField(
      decoration: InputDecoration(
        isDense: true,
        labelText: 'Buscar',
        suffixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        )
      ),
      onChanged: (value) => filterSearch(value),
    );
  }
  Widget _getContent() {
    return _lineas.isEmpty
    ? _noContent()
    : _getBody();
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
  Widget _getBody() {
    return 
      Column(
        children: [
          Container(
            margin: EdgeInsets.all(4.0),
            child: Column(
              spacing: 2,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Factura: ',style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(widget.documento.documento.toString()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Fecha Entrega: ',style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(widget.documento.fechaEntrega.toString()),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Monto: ',style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(NumberFormat.currency(symbol: '₡').format(widget.documento.totalDocumento))
                    ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Ruta: ',style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(widget.documento.ruta.toString()),
                    ],
                ),
              ],
            ),
          ),
          _buscar(),
          Expanded(
            child: 
              CustomScrollView(
                slivers: [
                  SliverList(delegate: SliverChildBuilderDelegate((context,index){
                    return _buildCard(_lineasFiltro[index]);
                  },
                  childCount: _lineasFiltro.length
                ),),
              ],
            ),
          ),
        ],
      );
  }
  Widget _buildCard(DocumentoLinea linea) {
    return 
      Card(
        elevation: 4,
        child: InkWell(
          onTap: () {},
          splashColor: Colors.blue.withAlpha(30),
          child: ListTile(
            title: Text('(${linea.articulo}) - ${linea.descripcion}'),
            subtitle: Text('Cajas: ${linea.cajas} - Unds:${linea.unidades}'),
            dense: true,
            trailing: 
              CircleAvatar(
                radius: 15.0,
                backgroundColor:  Color.fromRGBO(218, 86, 48, 1),
                child: 
                  Text(
                    linea.linea.toString(),
                    style: 
                      TextStyle( 
                        color: Colors.white,
                        fontWeight: FontWeight.bold,fontSize: 12
                        )
                      ),
                ),
          )
          ,
        ),
      );
  }
  Future <void> _getDocumentoLinea() async {
    setState(() => _showLoader = true);
    _lineas = await _dbHelper.getDocumentoLinea(widget.documento.idDocumento);
    _lineasFiltro = _lineas;
    setState(() => _showLoader = false);
  }
  void filterSearch(String value) {
      List<DocumentoLinea> results = []; 
      if (value.isEmpty) {
        results = _lineas;
      }else{
        results = _lineas
          .where(
            (item) => item.descripcion!.toLowerCase().contains(value.toLowerCase()) 
                   || item.articulo!.toLowerCase().contains(value.toLowerCase())
          ).toList();
      }
      setState(() {
        _lineasFiltro = results;
      });
    }
    
  void _entregaCompleta() async {
    var response =  await showAlertDialog(
                context: context,
                title: 'Entrega completa', 
                message: '¿Está seguro de marcar el documento como entrega completa?',
                actions: <AlertDialogAction>[
                    AlertDialogAction(key: 'no', label: 'Cancelar'),
                    AlertDialogAction(key: 'yes', label: 'Aceptar'),
                ]);    
              return;
  }
  void _entregaNula() async {
    var response =  await showAlertDialog(
                context: context,
                title: 'Entrega nula', 
                message: '¿Está seguro de marcar el documento como entrega nula?',
                actions: <AlertDialogAction>[
                    AlertDialogAction(key: 'no', label: 'Cancelar'),
                    AlertDialogAction(key: 'yes', label: 'Aceptar'),
                ]);    
              return;
  }
  void _imprimirFact() async {
     var response =  await showAlertDialog(
                context: context,
                title: 'Impresion', 
                message: '¡Immpresión exitosa!',
                actions: <AlertDialogAction>[
                    AlertDialogAction(key: null, label: 'Aceptar'),
                ]);    
              return;
  }
}