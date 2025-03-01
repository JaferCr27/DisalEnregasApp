import 'package:disal_entregas/models/documento.dart';
import 'package:disal_entregas/screens/devolucion_completa_screen.dart';
import 'package:flutter/material.dart';

class DocumentoDetalleScreen extends StatefulWidget {
  final Documento documento;

  const DocumentoDetalleScreen({super.key, required this.documento});

  @override
  State<DocumentoDetalleScreen> createState() => _DocumentoDetalleScreenState();
}

class _DocumentoDetalleScreenState extends State<DocumentoDetalleScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    
    List<Widget> screens = [
      DevolucionCompletaScreen(documento: widget.documento),
      Text("Entrega parcial"),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,

      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        items: const [
        BottomNavigationBarItem(icon: Icon(Icons.fact_check), label: "Entrega completa", backgroundColor: Color.fromRGBO(52, 75, 115, 1) ),
        BottomNavigationBarItem(icon: Icon(Icons.inventory), label: "Entrega parcial", backgroundColor:  Color.fromRGBO(218, 86, 48, 1),)

      ]),
    );
  }
}