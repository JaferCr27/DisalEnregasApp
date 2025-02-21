class Despacho {
  int idDespacho = 0;
  String consecutivo = "";
  String fecha = "";
  String fechaEntrega = "";
  String fechaEntregaOrdenar = "";
  int idCamion = 0;
  int idFurgon = 0;
  String horaSalida = "";
  String bodega = "";
  String observacion = "";
  int idRecurso = 0;
  bool rutaTerminada = false;
  String fechaHoraRutaTerminada = "";

  Despacho({
     required this.idDespacho,
     required this.consecutivo,
     required this.fecha,
     required this.fechaEntrega,
     required this.fechaEntregaOrdenar,
     required this.idCamion,
     required this.idFurgon,
     required this.horaSalida,
     required this.bodega,
     required this.observacion,
     required this.idRecurso,
     required this.rutaTerminada,
     required this.fechaHoraRutaTerminada
  });

  // Propiedad calculada para el color de fondo
  // String get backGroundColor => rutaTerminada ? "#46C771" : "#FF602E";

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
    //rutaTerminada = json['RutaTerminada'];
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
    //data['RutaTerminada'] = rutaTerminada ? 1 : 0;
    data['FechaHoraRutaTerminada'] = fechaHoraRutaTerminada;
    return data;
  }
}
