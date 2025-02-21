import 'dart:convert';
import 'package:disal_entregas/components/loader_component.dart';
import 'package:disal_entregas/models/cliente.dart';
import 'package:disal_entregas/models/despacho.dart';
import 'package:disal_entregas/models/despacho_documento.dart';
import 'package:disal_entregas/models/response.dart';
import 'package:disal_entregas/services/data_services.dart';
import 'package:flutter/material.dart';
import 'package:disal_entregas/models/token.dart';
import 'package:disal_entregas/helpers/constans.dart';
import 'package:http/http.dart' as http;

class SincviewScreen extends StatefulWidget {
  final Token token;
  const SincviewScreen({super.key, required this.token});

  @override
  State<SincviewScreen> createState() => _SincviewScreenState();
}

class _SincviewScreenState extends State<SincviewScreen> {
 
  final _dbHelper = DataServices();
  List<Cliente> clientes = []; 
  String _errorMessage = "";
  bool _showLoader = false;
 
 @override
  void initState() {
    super.initState();
    _sincronizarInicio();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disal Entregas',style: TextStyle(fontSize: 15),),
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            Text(_errorMessage,style: TextStyle( fontWeight: FontWeight.bold, fontSize: 18),),
             Divider(
                height: 20,
                thickness: 1,
                color: Colors.deepPurple,
                indent: 40,
                endIndent: 40,
            ),
            SizedBox(height: 150,),
            Center(
              child: _showLoader ? LoaderComponent(text: '...Cargando...') : Text("Datos de inicio sincronizados con éxito",style: TextStyle( fontWeight: FontWeight.bold, fontSize: 16)),
            ),
           
            
          ],
        ),
      ),
    );
  }
 
  Future<Response> _getDespachos() async {
    final url = Uri.parse("${Constans.apiUrlTest}/api/Sync/Consultas");
    final headers = {
      'Authorization': '${widget.token.tokenType} ${widget.token.accessToken}',
      'Content-Type': 'application/json',
    };
    try {
      // var despachoDocumentoResponse = await http.post(
      //     url,
      //     headers: headers,
      //     body: jsonEncode({'Opcion':'CDD'}),
      // );
      // var despachoDocumentoDecode = jsonDecode(despachoDocumentoResponse.body);
      // if (despachoDocumentoDecode != null) {
      //   for (var item in despachoDocumentoDecode) {
      //    // _despachoDocumento.add(DespachoDocumento.fromJson(item));
      //     _dbHelper.insertDocumento(DespachoDocumento.fromJson(item));
      //   }
      // }
      var despachosResponse = await http.post(
          url,
          headers: headers,
          body: jsonEncode({'Opcion':'CDESP'}),
      );
      var despachosDecode = jsonDecode(despachosResponse.body);
      
      if (despachosDecode != null) {
        for (var item in despachosDecode) {
          //_despacho.add(Despacho.fromJson(item));
          _dbHelper.insertDespacho(Despacho.fromJson(item));
        }
      } 
      return Response(
        isSuccess: true, 
        message: 'Se sincronizó con exito los despachos'
      );
    } catch (e) {
        return Response(
          isSuccess: false, 
          message: e.toString()
        );
      }
  }
  Future<Response> _getClientes() async {
    final url = Uri.parse("${Constans.apiUrlTest}/api/Sync/Consultas");
    final headers = {
      'Authorization': '${widget.token.tokenType} ${widget.token.accessToken}',
      'Content-Type': 'application/json',
    };
    try {
      var clienteResponse = await http.post(
            url,
            headers: headers,
            body: jsonEncode({'Opcion':'CCL'}),
        );
      var clientesJson = jsonDecode(clienteResponse.body);
      if (clientesJson != null) {
        for (var cliente in clientesJson) {
          clientes.add(Cliente.fromJson(cliente));
        }
          _dbHelper.insertarClientes(clientes);
        }
      return Response(
        isSuccess: true, 
        message: 'Se sincronizó con exito los clientes'
      );
      } catch (e) {
          return Response(isSuccess: false, message: e.toString());
      }
  }

  void _sincronizarInicio() async {
    setState(() {
      _showLoader = true;
      _errorMessage = "...Sincronizando despachos...";
      });
    await _dbHelper.deleteAll();
    var despachos = await _getDespachos();
    if (!despachos.isSuccess) {
      setState(() {
      _showLoader = false;
      _errorMessage = despachos.message;
      });
      return;
    }
    setState(() {
      _errorMessage = "...Sincronizando clientes...";
    });
    var clientes = await _getClientes();
    if (!clientes.isSuccess) {
      setState(() {
      _showLoader = false;
      _errorMessage = despachos.message;
      });
      return;
    }
    setState(() {
      _showLoader = false;
      _errorMessage = "Éxito!";
      });
    return;
  }
}