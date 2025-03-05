import 'package:disal_entregas/components/loader_component.dart';
import 'package:disal_entregas/helpers/apiHelper.dart';
import 'package:disal_entregas/models/articulo.dart';
import 'package:disal_entregas/models/cliente.dart';
import 'package:disal_entregas/models/despacho.dart';
import 'package:disal_entregas/models/despacho_documento.dart';
import 'package:disal_entregas/models/documento.dart';
import 'package:disal_entregas/models/documento_linea.dart';
import 'package:disal_entregas/models/evento.dart';
import 'package:disal_entregas/models/registro_evento.dart';
import 'package:disal_entregas/models/vendedor.dart';
import 'package:disal_entregas/services/data_services.dart';
import 'package:flutter/material.dart';
import 'package:disal_entregas/models/token.dart';
import 'package:disal_entregas/helpers/constans.dart';

class SincviewScreen extends StatefulWidget {
  final Token token;
  const SincviewScreen({super.key, required this.token});

  @override
  State<SincviewScreen> createState() => _SincviewScreenState();
}

class _SincviewScreenState extends State<SincviewScreen> {
  final url = Uri.parse("${Constans.apiUrlTest}/api/Sync/Consultas");
  final _dbHelper = DataServices();
  List<Documento> documentos = []; 
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
                color: Color.fromRGBO(218, 86, 48, 1),
                indent: 40,
                endIndent: 40,
            ),
            SizedBox(height: 150,),
            Center(
              child: _showLoader ? LoaderComponent(text: '...Cargando...') : Text(_errorMessage,style: TextStyle( fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
  void _sincronizarInicio() async {
    await _dbHelper.deleteAll();
    setState(() {
      _showLoader = true;
      _errorMessage = "...Sincronizando Despachos...";
      });
    var despachos = await Apihelper.post("CDESP",widget.token.accessToken);
    if (!despachos.isSuccess) {
      setState(() {_showLoader = false;_errorMessage = despachos.message;});
      return;
    }
    _dbHelper.insertar(despachos.result
          .map<Despacho>((item) => Despacho.fromJson(item))
          .toList(), 'Despacho');

    setState((){_errorMessage = "...Sincronizando Clientes...";});
    var clientes = await Apihelper.post("CCL",widget.token.accessToken);
    if (!clientes.isSuccess) {
      setState(() {_showLoader = false;_errorMessage = clientes.message;});
      return;
    }
    _dbHelper.insertar(clientes.result
        .map<Cliente>((item) => Cliente.fromJson(item))
        .toList(), 'ClienteModel');

    setState((){_errorMessage = "...Sincronizando Documentos...";});

    var despachoDocs = await Apihelper.post("CDD",widget.token.accessToken);
    if (!despachoDocs.isSuccess) {
       setState(() {
      _showLoader = false;
      _errorMessage = despachoDocs.message;
      });
    }
      _dbHelper.insertar(despachoDocs.result
                .map<DespachoDocumento>((item) => DespachoDocumento.fromJson(item))
                .toList(), 'DespachoDocumento');
    
    var documentos = await Apihelper.post("CD",widget.token.accessToken);
    if (!documentos.isSuccess) {
      setState(() {_showLoader = false;_errorMessage = documentos.message;});
      return;
    }
    _dbHelper.insertar(documentos.result
        .map<Documento>((item) => Documento.fromJson(item))
        .toList(), 'DocumentoModel');

    var documentoDetalle = await Apihelper.post("CDL",widget.token.accessToken);
    if (!documentoDetalle.isSuccess) {
      setState(() {_showLoader = false;_errorMessage = documentoDetalle.message;});
      return;
    }
    _dbHelper.insertar(documentoDetalle.result
        .map<DocumentoLinea>((item) => DocumentoLinea.fromJson(item))
        .toList(), 'DocumentoLineaModel');
    
    setState((){_errorMessage = "...Sincronizando Articulos...";});
    var articulos = await Apihelper.post("CA",widget.token.accessToken);
    if (!articulos.isSuccess) {
      setState(() {_showLoader = false;_errorMessage = articulos.message;});
      return;
    }
    _dbHelper.insertar(articulos.result
        .map<Articulo>((item) => Articulo.fromJson(item))
        .toList(), 'ArticuloModel');


    var vendedores = await Apihelper.post("CVEND",widget.token.accessToken);
    if (!vendedores.isSuccess) {
      setState(() {_showLoader = false;_errorMessage = vendedores.message;});
      return;
    }
    _dbHelper.insertar(vendedores.result
        .map<Vendedor>((item) => Vendedor.fromJson(item))
        .toList(), 'VendedorModel');
    
    var eventos = await Apihelper.post("CEV",widget.token.accessToken);
    if (!eventos.isSuccess) {
      setState(() {_showLoader = false;_errorMessage = eventos.message;});
      return;
    }
    _dbHelper.insertar(eventos.result
        .map<Evento>((item) => Evento.fromJson(item))
        .toList(), 'EventoModel');

    var registroEventos = await Apihelper.post("CREV",widget.token.accessToken);
    if (!registroEventos.isSuccess) {
      setState(() {_showLoader = false;_errorMessage = registroEventos.message;});
      return;
    }
    _dbHelper.insertar(registroEventos.result
        .map<RegistroEvento>((item) => RegistroEvento.fromJson(item))
        .toList(), 'RegistroEventoModel');
    
    setState(() {
      _showLoader = false;
      _errorMessage = "¡Sincronización exitosa!";
      });
    return;
  }
}