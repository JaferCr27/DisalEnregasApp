import 'package:disal_entregas/components/loader_component.dart';
import 'package:disal_entregas/models/cliente.dart';
import 'package:disal_entregas/models/token.dart';
import 'package:disal_entregas/services/data_services.dart';
import 'package:flutter/material.dart';

class ClientesDespacho extends StatefulWidget {
  final Token token;

  const ClientesDespacho({super.key, required this.token});
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
      body: Center(
        child: _showLoader ? LoaderComponent(text: '...Cargando...'): getContent(),
      ),
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
    return ListView(
      children: _clientes.map((e){
        return Column(
          children: [
            ListTile(
              leading: Icon(Icons.storefront),
              title: Text('(${e.cliente}) - ${e.nombre}',style: TextStyle( fontWeight: FontWeight.bold),),
              subtitle: Text(e.direccion.toString()),
              trailing: Icon(Icons.keyboard_double_arrow_right),
              isThreeLine: true,
              dense: true,
            ),
            Divider(
              height: 20,
            )
          ],
        );
      }).toList(),
    );
  }

  Future<void> _getClientes() async {
    setState(() => _showLoader = true);
    _clientes = await _dbHelper.getClientes();
    setState(() => _showLoader = false);
  }
}