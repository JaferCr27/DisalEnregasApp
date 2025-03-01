import 'package:disal_entregas/components/loader_component.dart';
import 'package:disal_entregas/models/token.dart';
import 'package:disal_entregas/models/usuario.dart';
import 'package:disal_entregas/screens/despachos_screen.dart';
import 'package:disal_entregas/screens/login_screen.dart';
import 'package:disal_entregas/screens/sincView_screen.dart';
import 'package:disal_entregas/screens/user_screen.dart';
import 'package:disal_entregas/services/data_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final Token token;
  
  const HomeScreen({super.key, required this.token});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showLoader = false;
  Usuario _usuario  = Usuario(nombreChofer: '');
  final _dbHelper = DataServices();

  @override
  void initState() {
    _getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disal Entregas',style: TextStyle(fontSize: 15),),
        actions: 
          [
            Padding(
              padding: EdgeInsetsDirectional.only(end: 16.0),
              child: CircleAvatar(
                child: 
                  InkWell(
                    onTap:() {
                       Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => UserScreen(usuario: _usuario)
                          )
                        );
                    },
                    child: Icon(Icons.account_circle),
                  ) 
                )
            ),
          ],
        ),
        body: _showLoader ? LoaderComponent(text: '...Cargando...',) : _getBody(),
        drawer: _showLoader ? LoaderComponent(text: '...Cargando...',) : _getMenu(),
    );
  }
  Widget _getBody() {
    return 
    Column(
      children: [
        Text('Bienvenido ${_usuario.nombreChofer}',style: TextStyle(fontWeight: FontWeight.bold),),
        SizedBox(
          height: 240,
          child: 
          CarouselView(
            itemExtent: MediaQuery.sizeOf(context).width-32, 
            itemSnapping: true,
            elevation: 4,
            padding: const EdgeInsets.all(8),
            children: List.generate(3, (int index) {
            return Container(
              color: Colors.grey,
              child: Image.network(
                // ignore: prefer_interpolation_to_compose_strings
                 'https://picsum.photos/400?random=$index',
                fit: BoxFit.cover,
                ),
            );
          })
          )
        ),
        Expanded(
          child: 
            GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              padding: const EdgeInsets.all(20),
              mainAxisSpacing: 10,
              children: <Widget>[
                    Card(
                      elevation: 4,
                      clipBehavior: Clip.hardEdge,
                      child: 
                      InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => DespachosScreen(token: widget.token)
                            )
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Icon(
                                Icons.local_shipping, 
                                color: Color.fromRGBO(52, 75, 115, 1), 
                                size: 35
                              ), 
                              Text(
                                'Ruta',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                          ],
                        )
                        )
                    ),
                    Card(
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          debugPrint('Card tapped.');
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Icon(
                                Icons.inventory, 
                                color: Color.fromRGBO(218, 86, 48, 1), 
                                size: 35
                              ), 
                              Text(
                                'Inventario',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                          ],
                        )
                        )
                    ),
                    Card(
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          debugPrint('Card tapped.');
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Icon(
                                Icons.settings, 
                                color: Color.fromRGBO(230, 232, 237, 1), 
                                size: 35
                              ), 
                              Text(
                                'Admin',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                          ],
                        )
                        )
                    ),
                    Card(
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          debugPrint('Card tapped.');
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Icon(
                                Icons.support_agent_outlined, 
                                color: Color.fromRGBO(100, 132, 188, 1), 
                                size: 35
                              ), 
                              Text(
                                'Soporte',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                          ],
                        )
                        )
                    ),
                    Card(
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          debugPrint('Card tapped.');
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Icon(
                                Icons.cloud_download, 
                                color: Color.fromRGBO(120, 129, 155, 1), 
                                size: 35
                              ), 
                              Text(
                                'Sincronizar',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                          ],
                        )
                        )
                    ),
                    Card(
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(50),
                        onTap: () {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (context) => SincviewScreen(token: widget.token)
                              )
                            );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Icon(
                                Icons.sync, 
                                color: Color.fromRGBO(99, 130, 175, 1), 
                                size: 35
                              ), 
                              Text(
                                'Sinc.Inicio',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                          ],
                        )
                        )
                    ),
                  ],
                ),
        ),
      ],
    );
  }
  Widget _getMenu() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:<Widget> [
          DrawerHeader(child: Image(
            image: AssetImage("assets/Logo_Disal_2023.png")
            )
          ),
          Center(child: Text('${_usuario.chofer} - ${_usuario.nombreChofer}')),
          ListTile(
            leading: Icon(Icons.local_shipping),
            title: Text("Ruta"),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Administración"),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("Sobre la App"),
            onTap: (){},
          ),
          Divider(
            color: Colors.black,
            height: 2,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Cerrar sesión"),
            onTap: () => _logOut(),
          ),
          ListTile(
            leading: Icon(Icons.close),
            title: Text("Salir"),
            onTap: (){},
          ),
        ],

      ),
    );
  }
  Future<void> _getUser() async {
    setState(() => _showLoader = true);
    _usuario = await _dbHelper.getUsuario();
    setState(() => _showLoader = false);

  }
  void _logOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('isRemembered', false) ;
    await pref.setString('userBody', '');
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
        builder: (context) => LoginScreen()
        )
      );
  }
}