import 'package:disal_entregas/components/loader_component.dart';
import 'package:disal_entregas/models/despacho.dart';
import 'package:disal_entregas/models/token.dart';
import 'package:disal_entregas/screens/clientes_despacho.dart';
import 'package:disal_entregas/services/data_services.dart';
import 'package:flutter/material.dart';

class DespachosScreen extends StatefulWidget {
  final Token token;

  const DespachosScreen({super.key, required this.token});

  @override
  State<DespachosScreen> createState() => _DespachosScreenState();
}

class _DespachosScreenState extends State<DespachosScreen> {

  final _dbHelper = DataServices();
  bool _showLoader = false;
  List<Despacho> _despachos = [];
  @override
  void initState() {
    super.initState();
    _getDespachos();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disal Entregas',style: TextStyle(fontSize: 15),),
        actions: [
            IconButton(
                  icon: Icon(Icons.sync_rounded),
                  onPressed: () => _getDespachos(),
              )
          ],
      ),
      body: 
      Container(
        padding: const EdgeInsets.all(8.0),
        child: _showLoader ? LoaderComponent(text: '...Cargando...'): getContent(),
      ),
    );
  }
  Future<void> _getDespachos() async {
    setState(() => _showLoader = true);
    _despachos = await _dbHelper.getDespachos() ;
    setState(() => _showLoader = false);
  }
  Widget getContent() {
    return _despachos.isEmpty
    ? _noContent()
    : _getBody();
  }
  Widget _noContent() {
    return Container(
      margin: EdgeInsets.all(20),
      child: Center(
        child: Text(
          "No se encontraron despachos disponibles, intente sincronizar de nuevo",
          style: TextStyle(fontWeight: FontWeight.bold),
          ),
      ),
    );
  }
  Widget buildCard (Despacho despacho){
    return Container(
      padding: EdgeInsets.all(2),
      child: 
      Card(
        elevation: 4,
              child: 
                InkWell(
                  onTap:(){
                    Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => ClientesDespacho(token: widget.token, despacho: despacho)
                          )
                        );
                  },
                  splashColor: Colors.blue.withAlpha(30),
                  child: 
                    Column(
                      children: [
                        ListTile(
                              leading: despacho.iconDes,
                              title: 
                              Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                          Text(despacho.consecutivo,style:
                                          TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold
                                          ),
                                          ),
                                          // Chip(
                                          //   avatar: CircleAvatar(
                                          //     backgroundColor: despacho.rutaTerminada == 0 ? Colors.red : Colors.green,
                                          //   ),
                                          //   label: Text(despacho.estado),
                                          // )
                                      ],
                                    ),
                                  ],
                                ),
                              subtitle: Text('Fecha: ${despacho.fechaEntrega} \nClientes: ${despacho.cantidadDocs}',),
                              dense: true,
                          ),
                      ],
                    ) ,
              ),
            ),
    ); 
  }
  Widget _getBody() {
    return 
      // RefreshIndicator(
      //   onRefresh: () => _getDespachos(),
      //   child:
      //     ListView.builder(
      //       primary: false,
      //       itemCount: _despachos.length,
      //       itemBuilder: (context,index) => buildCard(_despachos[index]),
      //     )
      // );


      Column(
        children: [
          Expanded(
            child:  
              CustomScrollView(
                slivers: [
                  SliverList(delegate: SliverChildBuilderDelegate((context,index){
                    return buildCard(_despachos[index]);
                  },
                  childCount: _despachos.length
                  ),),
                ],
              )
            )
        ],

      );
  }
}