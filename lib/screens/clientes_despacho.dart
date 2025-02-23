import 'package:disal_entregas/components/loader_component.dart';
import 'package:disal_entregas/models/cliente.dart';
import 'package:disal_entregas/models/despacho.dart';
import 'package:disal_entregas/models/token.dart';
import 'package:disal_entregas/screens/documentos_screen.dart';
import 'package:disal_entregas/services/data_services.dart';
import 'package:flutter/material.dart';

class ClientesDespacho extends StatefulWidget {
  final Token token;
  final Despacho despacho;

  const ClientesDespacho({super.key, required this.token, required this.despacho });
  @override
  State<ClientesDespacho> createState() => _ClientesDespachoState();
}

class _ClientesDespachoState extends State<ClientesDespacho> {
  
  final _dbHelper = DataServices();
  List<Cliente> _clientes = [];
  List<Cliente> _clientesFiltro = [];
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
        title: Text(widget.despacho.consecutivo),
      ),
      body: 
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _showLoader ? LoaderComponent(text: '...Cargando...'): getContent(),
        )
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
                itemCount: _clientesFiltro.length,
                itemBuilder: (context, index) => buildCard(_clientesFiltro[index]),
              ),
            ),
          ],
        );
  }
  Widget buildCard(Cliente client) {
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 0,),
                      Text(client.condicionPagoDesc.toString(),),
                      SizedBox(width: 90,),
                      PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Text("Ver documentos"),
                            onTap: () {
                              Navigator.push(
                                context, 
                                MaterialPageRoute(
                                  builder: (context) => DocumentosScreen(
                                    cliente: client.cliente.toString(),
                                    idDespacho : widget.despacho.idDespacho
                                    )
                                  )
                                );
                            },
                            ),
                          PopupMenuItem(
                            child: Text("Detalle Cliente")
                            ),
                          PopupMenuItem(
                            child: Text("Sincronizar")
                            )
                        ],
                      )
                    ],
                  ),
                  Text(client.horaLlegada.toString(),style: TextStyle( color: Colors.deepOrange, fontWeight: FontWeight.bold)),
                ],
              ),
          ),
      );
  }
  void filterSearch(String value) {
      List<Cliente> results = []; 
      if (value.isEmpty) {
        results = _clientes;
      }else{
        results = _clientes
          .where((item) => item.alias!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      }
      setState(() {
        _clientesFiltro = results;
      });
    }
  Future<void> _getClientes() async {
    setState(() => _showLoader = true);
    _clientes = await _dbHelper.getClientesDespacho(widget.despacho.idDespacho);
    _clientesFiltro = _clientes;
    setState(() => _showLoader = false);
  }
}