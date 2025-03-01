class RegistroEvento {
  int? idRegistroEvento;
  int? idEvento;
  String? cliente;
  int? idDespacho;
  int? idRecurso;
  String? usuario;
  double? longitud;
  double? latitud;
  int? idRechazo;
  String? observacion;
  String? estado;
  int? idMotivo;
  String? fechaCreacionMovil;
  String? fechaHora;
  bool? transmitido;
  int? idDocumento;
  String? evento;

  RegistroEvento(
      {this.idRegistroEvento,
      this.idEvento,
      this.cliente,
      this.idDespacho,
      this.idRecurso,
      this.usuario,
      this.longitud,
      this.latitud,
      this.idRechazo,
      this.observacion,
      this.estado,
      this.idMotivo,
      this.fechaCreacionMovil,
      this.fechaHora,
      this.transmitido,
      this.idDocumento,
      this.evento});

  RegistroEvento.fromJson(Map<String, dynamic> json) {
    idRegistroEvento = json['IdRegistroEvento'];
    idEvento = json['IdEvento'];
    cliente = json['Cliente'];
    idDespacho = json['IdDespacho'];
    idRecurso = json['IdRecurso'];
    usuario = json['Usuario'];
    longitud = json['Longitud'];
    latitud = json['Latitud'];
    idRechazo = json['IdRechazo'];
    observacion = json['Observacion'];
    estado = json['Estado'];
    idMotivo = json['IdMotivo'];
    fechaCreacionMovil = json['FechaCreacionMovil'];
    fechaHora = json['FechaHora'];
    transmitido = json['Transmitido'];
    idDocumento = json['IdDocumento'];
    evento = json['Evento'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['IdRegistroEvento'] = idRegistroEvento;
    data['IdEvento'] = idEvento;
    data['Cliente'] = cliente;
    data['IdDespacho'] = idDespacho;
    data['IdRecurso'] = idRecurso;
    data['Usuario'] = usuario;
    data['Longitud'] = longitud;
    data['Latitud'] = latitud;
    data['IdRechazo'] = idRechazo;
    data['Observacion'] = observacion;
    data['Estado'] = estado;
    data['IdMotivo'] = idMotivo;
    data['FechaCreacionMovil'] = fechaCreacionMovil;
    data['FechaHora'] = fechaHora;
    data['Transmitido'] = transmitido;
    data['IdDocumento'] = idDocumento;
    data['Evento'] = evento;
    return data;
  }
}