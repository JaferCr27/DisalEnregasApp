import 'package:disal_entregas/components/loader_component.dart';
import 'package:disal_entregas/models/cliente.dart';
import 'package:disal_entregas/models/token.dart';
import 'package:disal_entregas/services/data_services.dart';
import 'package:flutter/material.dart';

class ClientesDespacho extends StatefulWidget {
  final Token token;
  final int idDespacho;

  const ClientesDespacho({super.key, required this.token, required this.idDespacho});
  @override
  State<ClientesDespacho> createState() => _ClientesDespachoState();
}

class _ClientesDespachoState extends State<ClientesDespacho> {
  
  final _dbHelper = DataServices();
  List<Cliente> _clientes = [];
  bool _showLoader = false;

  @override
  void initState() {
    super.initState();
    _getClientes();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clientes"),
      ),
      body: _showLoader ? LoaderComponent(text: '...Cargando...'): getContent()
      // Center(
      //   child: ,
      // ),
    );
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
  
  Widget getContent() {
    return _clientes.isEmpty
    ? _noContent()
    : _getListView();
  }  
  Widget _getListView() {
    return 
      Container(
        margin: EdgeInsets.all(5),
        child:
          ListView.builder(
            primary: false,
            itemCount: _clientes.length,
            itemBuilder: (context, index) => buildCard(_clientes[index]),
          )
      );
  }

  Future<void> _getClientes() async {
    setState(() => _showLoader = true);
    _clientes = await _dbHelper.getClientesDespacho(widget.idDespacho);
    setState(() => _showLoader = false);
  }
  
  Widget buildCard(Cliente client) {
    return 
      Card(
        child: 
          InkWell(
            onTap: () {
          
            },
            splashColor: Colors.blue.withAlpha(30),
            child: 
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.storefront, color: Colors.green[900],),
                    title: Text('(${client.cliente}) - ${client.alias}',style: TextStyle( fontWeight: FontWeight.bold),),
                    subtitle: Text(client.direccion.toString().trim()),
                    trailing: Text(client.secuencia.toString(),style: TextStyle( color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold,fontSize: 14)),
                    isThreeLine: true,
                    dense: true,
                  ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 55,),
                      Text(client.ventanaAtencion1.toString()),
                      Text(" - "),
                      Text(client.ventanaAtencion1.toString(),)
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 55,),
                      Text(client.condicionPagoDesc.toString(),)
                    ],
                  ),
                  Text(client.horaLlegada.toString(),style: TextStyle( color: Colors.deepOrange, fontWeight: FontWeight.bold)),
                ],
              ),
          ),
      );
  }
}