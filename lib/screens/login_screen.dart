import 'dart:convert';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:disal_entregas/components/loader_component.dart';
import 'package:disal_entregas/helpers/apiHelper.dart';
import 'package:disal_entregas/models/token.dart';
import 'package:disal_entregas/models/usuario.dart';
import 'package:disal_entregas/screens/home_screen.dart';
import 'package:disal_entregas/services/data_services.dart';
import 'package:flutter/material.dart';
import 'package:disal_entregas/helpers/constans.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {  
  
  final _dbHelper = DataServices();

  String _email = 'E10';
  String _emailError = '';
  bool _emailShowError = false;
  String _passWord = '123456789';
  String _passWordError = '';
  bool _passWordShowError = false;
  bool _remenberMe = true;
  bool _showPass = false;
  bool _showLoader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children :<Widget> [
                const SizedBox(height: 40,),
                _showLogo(),
                _showText(),
                const SizedBox(height: 20,),
                _showEmail(),
                _showPassword(),
                _showRemenberme(),
                _showButton(),
                _showFooterText()
              ],
            ),
          ),
          _showLoader ? LoaderComponent(text: 'Por favor espere',): Container()
        ],
      ),
    );
  }
  Widget _showLogo() {
    return Image(
      image: AssetImage("assets/Logo_Disal_2023.png"),
      width: 300,
      );
  }
  Widget _showEmail() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        autofocus: true,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: "Ingresa tu usuario...",
          labelText: "Usuario",
          errorText: _emailShowError ? _emailError: null,
          suffixIcon: Icon(Icons.email),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
          )
        ),
        onChanged: (value) {
          _email = value;
        },
        ),
    );
  }
  Widget _showPassword() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        obscureText: !_showPass,
        decoration: InputDecoration(
          hintText: "Ingresa tu contraseña...",
          labelText: "Contraseña",
          errorText: _passWordShowError ? _passWordError: null,
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: _showPass ? Icon(Icons.visibility): Icon(Icons.visibility_off),
            onPressed: () {
              setState(() {
              _showPass = !_showPass;
              });
            }, 
            ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
          )
        ),
        onChanged: (value) {
          _passWord = value;
        },
        ),
    );
  }
  Widget _showText() {
    return Column(
      children: [
        Text(
          "Entregas",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.fade,
          ),   
          ),
          SizedBox(height: 20,),
          Text(
            "Utilice sus credenciales para iniciar sesión",
            style: TextStyle(
              fontSize: 15
              ),
          )
      ],
    );
   }
  Widget _showFooterText() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
              "${DateTime.now().year} - TECNOLOGÍAS DE INFORMACIÓN GRUPO PELÓN",
              style:
              TextStyle (
                fontSize: 12,
              ),   
            ),
            Text(
              "Version 21.0.11",
              style: TextStyle(
                fontSize: 12
                ),
            )
        ],
      ),
    );
   }
  Widget _showRemenberme() {
    return CheckboxListTile(
      title: Text("Recordarme"),
      value: _remenberMe,
      onChanged: (value) {
        setState(() {
          _remenberMe = value!;
        });
      }
    );
  }
  Widget _showButton() {
    return Container(
      padding: EdgeInsets.all(10),
      child: 
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                elevation: 20,
                minimumSize: const Size.fromHeight(60),
                backgroundColor: Color.fromRGBO(52, 75, 115, 1)
              ),
              onPressed: () => _login(),
              child: 
                Text(
                  "Iniciar sesión",
                  style:
                  TextStyle (
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),   
                )
              ),
    );
  }
  void _login() async {
    setState(()=>_showPass = false);
    if (!_validateFields()){
      return;
    }
    setState(()=>_showLoader = true);

    var conectivityResult = await Connectivity().checkConnectivity();
    if (conectivityResult == ConnectivityResult.none) {
      setState(() {
      _showLoader = false;
      });
      await showAlertDialog(
        context: context,
        title: 'Error', 
        message: 'Verifica que estes conectado a internet.',
        actions: <AlertDialogAction>[
            AlertDialogAction(key: null, label: 'Aceptar'),
        ]
      );    
      return;
    }
    var url = Uri.parse("${Constans.apiUrlTest}/token");
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'grant_type': 'password',
        'username': '$_email;DISTRIBU',
        'password': Uri.encodeComponent(_passWord),
      },
    );
    if(response.statusCode >= 400){
      setState(() {
        _passWordShowError = true;
        _passWordError = response.body;        
      });
      return;
    }
    var decode = jsonDecode(response.body);
    var token = Token.fromJson(decode);



    var usuario = await Apihelper.post('CNC', token.accessToken);
    if (!usuario.isSuccess) {
       setState(() {
        _passWordShowError = true;
        _passWordError = usuario.message;        
      });
      return;
    }
    var user = usuario.result
        .map<Usuario>((json) => Usuario.fromJson(json))
        .toList();
    _dbHelper.insertar(user, 'UsuarioModel');

    _storeUser(response.body, user.first );


    setState(() => _showLoader = false);
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
        builder: (context) => HomeScreen(token: token, usuario: user.first,)
        )
      );
  }
  bool _validateFields() {
    bool isValid = true;
    if(_email.isEmpty){
      isValid = false;
      _emailShowError = true;
      _emailError = "Debes ingresar un usuario";
    } 
    else{
      _emailShowError = false;
    }
    if(_passWord.isEmpty){
        isValid = false;
        _passWordShowError = true;
        _passWordError = "Debes ingresar una contraseña";
      } 
      else{
        _passWordShowError = false;
        _showPass = false;
      }
      setState(() {});
      return isValid;
    }
  void _storeUser(String body, Usuario usuario) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('isRemembered', true) ;
    await pref.setString('userBody', body) ;
    await pref.setString('nombreChofer', usuario.nombreChofer) ;

  }
}