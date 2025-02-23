import 'package:disal_entregas/components/loader_component.dart';
import 'package:disal_entregas/models/documento.dart';
import 'package:disal_entregas/services/data_services.dart';
import 'package:flutter/material.dart';

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
            const SizedBox(height: 20,),
            TextField(
              decoration: InputDecoration(
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
              // Navigator.push(
              //   context, 
              //   MaterialPageRoute(
              //     builder: (context) => DocumentosScreen(
              //       cliente: client.cliente.toString(),
              //       idDespacho : widget.despacho.idDespacho
              //       )
              //     )
              //   );
            },
            splashColor: Colors.blue.withAlpha(30),
            child: 
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: documento.IconDoc ,
                    title: Text('${documento.documento} - ${documento.tipoDocDesc}',style: TextStyle( fontWeight: FontWeight.bold),),
                    subtitle: Text('Monto: ${documento.totalDocumento.toString().trim()}'),
                    trailing: Icon(Icons.keyboard_double_arrow_right, color: Colors.deepPurple,),
                    //isThreeLine: true,
                    //dense: true,
                  ),
                  Row(
                    children: [
                      SizedBox(width: 55,),
                      Text('Fecha Entrega: ${documento.fechaEntrega}'),
                    ],
                  ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 55,),
                      Text('Estado: ${documento.estadoDesc}'),
                      Text(" - "),
                      Text('Ruta: ${documento.ruta}',)
                    ],
                  ),
                  Row(
                  children: [
                    SizedBox(width: 55,),
                    Text('Marchamo: ${documento.marchamo}')
                  ],
                  )
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
}