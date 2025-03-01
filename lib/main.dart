import 'dart:convert';

import 'package:disal_entregas/models/token.dart';
import 'package:disal_entregas/screens/home_screen.dart';
import 'package:disal_entregas/screens/login_screen.dart';
import 'package:disal_entregas/screens/wait_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;
  bool _showLoginPage = true;
  late Token _token;

  @override
  void initState() {
    super.initState();
    _getHome();
  } 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Disal Etregas',
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // cardColor: Color.fromRGBO(230, 232, 237, 1),
        // scaffoldBackgroundColor: Color.fromRGBO(230, 232, 237, 1),
        // focusColor: Color.fromRGBO(52, 75, 115, 1)
        //brightness: Brightness.dark
      ),
      home: _isLoading 
        ? WaitScreen() 
        : _showLoginPage 
          ? LoginScreen() 
          : HomeScreen(token: _token),
    );
  }
  
  void _getHome() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool isRemenber = pref.getBool('isRemembered') ?? false ;
    if (isRemenber) {
      String? userBody = pref.getString('userBody');
      if (userBody != null) {
        var decodedJson = jsonDecode(userBody);
        _token = Token.fromJson(decodedJson);
        if (DateTime.parse(_token.expiresIn.toString()).isAfter(DateTime.now())) {
          _showLoginPage = false;
        }
      }
    }
    _isLoading = false;
    setState(() {});
  }
}