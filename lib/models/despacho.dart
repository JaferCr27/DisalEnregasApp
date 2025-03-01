import 'package:flutter/material.dart';

class Despacho {
  int idDespacho = 0;
  String consecutivo = "";
  String? fecha;
  String fechaEntrega = "";
  String? fechaEntregaOrdenar;
  int idCamion = 0;
  int idFurgon = 0;
  String horaSalida = "";
  String bodega = "";
  String observacion = "";
  int idRecurso = 0;
  int? rutaTerminada;
  String fechaHoraRutaTerminada = "";
  int? cantidadDocs;

  Despacho({
     required this.idDespacho,
     required this.consecutivo,
     required this.fechaEntrega,
     this.fecha,
     // this.idCamion,
     //required this.idFurgon,
     //required this.horaSalida,
     //required this.bodega,
     //required this.observacion,
     //required this.idRecurso,
     required this.rutaTerminada,
     //required this.fechaHoraRutaTerminada, 
     this.cantidadDocs
  });

  // Propiedad calculada para el color de fondo
   String get estado => rutaTerminada == 0 ? "Pediente" : "Finalizado";
   Icon get iconDes => rutaTerminada == 0 ? 
   Icon(Icons.warning_amber_rounded,color:Color.fromRGBO(218, 86, 48, 1) ,size: 25,) 
   : Icon(Icons.check_circle_outline,size: 25,color: Colors.green,);
   

  Despacho.fromJson(Map<String, dynamic> json) {
    idDespacho = json['IdDespacho'];
    consecutivo = json['Consecutivo'];
    fecha = json['Fecha'];
    fechaEntrega = json['FechaEntrega'];
    fechaEntregaOrdenar = json['FechaEntregaOrdenar'];
    idCamion = json['IdCamion'];
    idFurgon = json['IdFurgon'];
    horaSalida = json['HoraSalida'];
    bodega = json['Bodega'];
    observacion = json['Observacion'];
    idRecurso = json['IdRecurso'];
    rutaTerminada = json['RutaTerminada'] == true ? 1 : 0;
    fechaHoraRutaTerminada = json['FechaHoraRutaTerminada'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['IdDespacho'] = idDespacho;
    data['Consecutivo'] = consecutivo;
    data['Fecha'] = fecha;
    data['FechaEntrega'] = fechaEntrega;
    data['FechaEntregaOrdenar'] = fechaEntregaOrdenar;
    data['IdCamion'] = idCamion;
    data['IdFurgon'] = idFurgon;
    data['HoraSalida'] = horaSalida;
    data['Bodega'] = bodega;
    data['Observacion'] = observacion;
    data['IdRecurso'] = idRecurso;
    data['RutaTerminada'] = rutaTerminada;
    data['FechaHoraRutaTerminada'] = fechaHoraRutaTerminada;
    return data;
  }
}
