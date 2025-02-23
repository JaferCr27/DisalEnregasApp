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
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 16.0),
              child: IconButton(
                  icon: Icon(Icons.refresh_rounded),
                  onPressed: () {},
            ),
            ),
          ],
      ),
      body: Center(
        child: _showLoader ? LoaderComponent(text: '...Cargando...'): getContent(),
      ),
    );
  }

  Future<void> _getDespachos() async {
    setState(() => _showLoader = true);
    _despachos = await _dbHelper.getAllDespachos();
    setState(() => _showLoader = false);
  }
  Widget getContent() {
    return _despachos.isEmpty
    ? _noContent()
    : _getListView();
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

  Widget _getListView() {
    return 
      RefreshIndicator(
        onRefresh: () => _getDespachos(),
        child: 
        ListView(
          children: _despachos.map((e){
          return 
          Card(
            child: 
              InkWell(
                onTap:(){
                  Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => ClientesDespacho(token: widget.token, despacho: e)
                        )
                      );
                },
                splashColor: Colors.blue.withAlpha(30),
                child: 
              Container(
                margin: EdgeInsets.all(1),
                child: Column(
                  children: [
                     ListTile(
                          //leading: Icon(Icons.warning_amber_rounded,color: Colors.orangeAccent,size: 25,),
                          title:  
                           Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                      Text(e.consecutivo,style:
                                      TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                      ),
                                      ),
                                      Chip(
                                        avatar: CircleAvatar(
                                          backgroundColor: Colors.red,
                                          //child: const Text('AB'),
                                        ),
                                        label: Text("Pendiente"),
                                      )
                                  ],
                                ),
                              ],
                            ),
                          subtitle: Text('Fecha: ${e.fechaEntrega}',),
                      ),
                      ListTile(
                        subtitle: Text('Pendientes: 10 Finalizados: 1',),
                        trailing: Icon(Icons.keyboard_double_arrow_right),
                        dense: true,
        
                      )
                  ],
                ),
              ) ,
            ),
          );
        }).toList(),
            ),
      );
  }
}