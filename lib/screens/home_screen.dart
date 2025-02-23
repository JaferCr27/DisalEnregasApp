import 'package:disal_entregas/models/token.dart';
import 'package:disal_entregas/models/usuario.dart';
import 'package:disal_entregas/screens/despachos_screen.dart';
import 'package:disal_entregas/screens/login_screen.dart';
import 'package:disal_entregas/screens/sincView_screen.dart';
import 'package:disal_entregas/screens/user_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final Token token;
  final Usuario usuario;
  const HomeScreen({super.key, required this.token,required this.usuario});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                          builder: (context) => UserScreen(usuario: widget.usuario)
                          )
                        );
                    },
                    child: Icon(Icons.account_circle),
                  ) 
                )
            ),
          ],
        ),
        body: _getBody(),
        drawer: _getMenu(),
    );
  }
  
  Widget _getBody() {
    return Column(
      children: [
        Text('Bienvenido ${widget.usuario.nombreChofer}',style: TextStyle(fontWeight: FontWeight.bold),),
        SizedBox(
          height: 240,
          child: 
          CarouselView(
            itemExtent: MediaQuery.sizeOf(context).width-32, 
            itemSnapping: true,
            elevation: 4,
            padding: const EdgeInsets.all(8),
            children: List.generate(5, (int index) {
            return Container(
              color: Colors.grey,
              child: Image.network(
                'https://picsum.photos/400?random=$index',
                fit: BoxFit.cover,
                ),
            );
          })
          )
        ),
        Expanded(
          child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  mainAxisSpacing: 10,
                  children: <Widget>[
                    Card(
                      //color: Color(0xffECEFFD),
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
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
                                color: Color(0xff2354C7), 
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
                      color: Color(0xffFAEDE7),
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
                                color: Color(0xff806C2A), 
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
                      color: Color(0xffFAEDE7),
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
                                color: Color(0xffA44D2A), 
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
                      color: Color(0xffE5F4E0),
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
                                color: Color(0xff417345), 
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
                      color: Colors.blue[50],
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
                                color: Colors.blue[900], 
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
                      color: Colors.blueGrey[100],
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
                                color: Colors.black54, 
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
          Center(child: Text('${widget.usuario.chofer} - ${widget.usuario.nombreChofer}')),
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
            onTap: (){
              Navigator.pushReplacement(
              context, 
              MaterialPageRoute(
                builder: (context) => LoginScreen()
                )
              );
            },
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
}