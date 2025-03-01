import 'package:flutter/material.dart';

class LoaderComponent extends StatelessWidget {
  final String text;
  const LoaderComponent({super.key, this.text = ''});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(
        width: 200,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20,),
            Text(text, style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}