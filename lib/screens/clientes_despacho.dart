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
        actions: [
           IconButton(
            padding: EdgeInsets.all(1),
            onPressed: ()=> _getClientes(), 
            icon: Icon(Icons.sync)
          ),
        ],
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
              child: 
              CustomScrollView(
                slivers: [
                  SliverList(delegate: SliverChildBuilderDelegate((context,index){
                    return _buildCard(_clientesFiltro[index]);
                  },
                  childCount: _clientesFiltro.length
                  ),),
                ],
              )
            ),
          ],
        );
  }
  Widget _listTiles (Cliente client){
    return ListTile(
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
      leading: Icon(Icons.storefront, color: const Color.fromRGBO(100, 132, 188, 1),),
      title: Text('(${client.cliente}) - ${client.alias}',style: TextStyle( fontWeight: FontWeight.bold),),
      subtitle: Text(client.direccion.toString().trim()),
      trailing: 
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
        ),
      isThreeLine: true,
      dense: true,
    );
  }
  Widget _buildCard(Cliente client) {
    return 
      Card(
        elevation: 4,
        child: 
          InkWell(
            onTap: () {
              
            },
            splashColor: Colors.blue.withAlpha(30),
            child: 
              Padding(
                padding: const EdgeInsets.all(2),
                child: 
                 Column(
                  children:<Widget>[
                     _listTiles(client),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     SizedBox(width: 55,),
                    //     Icon(Icons.schedule),
                    //     Text(' ${client.ventanaAtencion1}'),
                    //     Text(" - "),
                    //     Text(client.ventanaAtencion1.toString(),)
                    //   ],
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     SizedBox(width: 55,),
                    //     Icon(Icons.person),
                    //     Text(' ${client.contacto}'),
                    //   ],
                    // ),
                    // Row(
                    //   children: [
                    //     SizedBox(width: 55,),
                    //     Icon(Icons.call),
                    //     Text(' ${client.telefono}'),
                    //   ],
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     CircleAvatar(
                    //       radius: 15.0,
                    //       backgroundColor:  Color.fromRGBO(52, 75, 115, 1),
                    //       child: Text(
                    //         client.secuencia.toString(),
                    //         style: 
                    //           TextStyle( 
                    //             color: Colors.white,
                    //             fontWeight: FontWeight.bold,fontSize: 14
                    //             )
                    //           ),
                    //     ),
                    //     SizedBox(width: 16,),
                    //   ],
                    // ),
                    Chip(
                      padding: EdgeInsets.all(4.0),
                      backgroundColor: Color.fromRGBO(218, 86, 48, 1),
                      label: Text(client.horaLlegada.toString(),style: TextStyle( color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
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