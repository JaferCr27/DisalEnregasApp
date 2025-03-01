import 'package:disal_entregas/models/usuario.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  final Usuario usuario;
  final double coverHeigth = 200;
  final double profileHeigth = 144;
  const UserScreen({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
        appBar: AppBar(
          title: Text("Perfil") ,
        ),
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            buildTop(),
            builContent()
          ],
        )
      );
  }
  
  Widget buildCoverImage() => Container(
    color: Colors.grey,
    child:
      Image(
        image: AssetImage("assets/slider.jpg"),
        height: coverHeigth,
        width: double.infinity,
        fit: BoxFit.cover,
      )

  );
  
  Widget buildProfileImage() => CircleAvatar(
    radius: profileHeigth / 2,
    backgroundColor: Colors.grey.shade800,
    //child: Icon(Icons.account_circle, size: 100,),
    backgroundImage: NetworkImage("https://res.cloudinary.com/dxysgrrnt/image/upload/v1572383313/fuwnqbnid41lovsar1zs.png"),

  );
  
  Widget buildTop(){
    final bottom = profileHeigth / 2;
    final top = coverHeigth - profileHeigth / 2;
    return 
      Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children:[
          Container(
            margin: EdgeInsets.only(bottom: bottom),
            child: buildCoverImage()
          ),
          Positioned(
            top: top,
            child: buildProfileImage()
            )
        ] 
      );
  }
  
  Widget builContent() => Column(
    children: [
      const SizedBox(height: 8,),
      Text(
        usuario.nombreChofer,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
        const SizedBox(height: 8,),
      Text(
        "Agente distribución II GAM / DISAL",
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
      const SizedBox(height: 16,),
      Divider(),
      const SizedBox(height: 16,),
      buildAbout()
    ],
      

  );
  
  Widget buildAbout()=> Container(
    padding: EdgeInsets.symmetric(horizontal: 28),
    child: 
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "About",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14,),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean sagittis, enim at ultricies ornare, risus risus blandit quam, quis suscipit urna justo eget mass,Sed et condimentum arcu. In hac habitasse platea dictumst. Quisque consectetur libero nisi, at posuere eros suscipit sed. Quisque in aliquam erat. Mauris eget elit et diam ornare hendrerit.",
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
      ),
  );
}
