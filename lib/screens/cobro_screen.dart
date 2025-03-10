import 'package:flutter/material.dart';

class CobroScreen extends StatefulWidget {
  final String cliente;
  final int idDespacho;
  const CobroScreen({super.key, required this.cliente, required this.idDespacho});

  @override
  State<CobroScreen> createState() => _CobroScreenState();
}

class _CobroScreenState extends State<CobroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Cobro'),
      ),
    );
  }
}