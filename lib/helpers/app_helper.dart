import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:disal_entregas/models/evento.dart';
import 'package:disal_entregas/models/registro_evento.dart';
import 'package:disal_entregas/models/response.dart';
import 'package:disal_entregas/services/data_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppHelper {
  static Future<Response> insertarRegistroEvento (String event,double longitud,double latitud, int idMotivo, String cliente, int idDocumento, int idDespacho, String idRelacion,int idRechazo) async{
  final dbHelper = DataServices();
    try {
      List<RegistroEvento> eventos = [];
      Evento evento = await dbHelper.getEvento(event);
      DateTime now = DateTime.now();
      String fechaHora = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
      eventos.add(
        RegistroEvento(
                  //opcion : "CS",
                  //usuario : App.Usuario.UserName,
                  idRegistroEvento: 0,
                  idEvento : evento.idEvento,
                  idDespacho : idDespacho,
                  idDocumento : idDocumento,
                  idMotivo : idMotivo,
                  cliente : cliente,
                  evento : evento.evento,
                  fechaHora : fechaHora,
                  observacion : 'Fecha App Local: $fechaHora',
                  transmitido: 0,
                  estado : "P",
                  longitud : longitud,
                  latitud : latitud,
                  //creadoMovil : true,
                  //idRecurso : App.Usuario.IdRecurso,
                  //idRelacion : idRelacion,
                  idRechazo : idRechazo
              )
        );

        // dbHelper.insertar(eventos
        //   .map<RegistroEvento>((item) => RegistroEvento.fromJson(item))
        //   .toList(), 'RegistroEventoModel');

        dbHelper.insertar(eventos, 'RegistroEventoModel');
        return Response(isSuccess: true, message: event =='INVI'? 'Visita iniciada!':'Visita Finalizada!');
      } catch (e) {
        return Response(isSuccess: false, message: e.toString());
      }
  }
  static alerta( String type, String message, BuildContext context) async {

    return showAlertDialog(
        context: context,
        title: type, 
        message: message,
        actions: 
          <AlertDialogAction>[
            AlertDialogAction(label: 'Aceptar', key: null),
          ]);
  }
}

