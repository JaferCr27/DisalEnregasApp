class Evento {
  int? idEvento;
  String? evento;
  String? descripcion;

  Evento({this.idEvento, this.evento, this.descripcion});

  Evento.fromJson(Map<String, dynamic> json) {
    idEvento = json['IdEvento'];
    evento = json['Evento'];
    descripcion = json['Descripcion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['IdEvento'] = idEvento;
    data['Evento'] = evento;
    data['Descripcion'] = descripcion;
    return data;
  }
}