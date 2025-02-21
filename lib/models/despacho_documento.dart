class DespachoDocumento {
  int idDespacho;
  int idDocumento;
  String estado;

  DespachoDocumento({
    required this.idDespacho,
    required this.idDocumento,
    required this.estado,
  });

  // Método para convertir un JSON a un objeto de Dart
  factory DespachoDocumento.fromJson(Map<String, dynamic> json) {
    return DespachoDocumento(
      idDespacho: json['IdDespacho'],
      idDocumento: json['IdDocumento'],
      estado: json['Estado'],
    );
  }

  // Método para convertir un objeto de Dart a JSON
  Map<String, dynamic> toJson() {
    return {
      'idDespacho': idDespacho,
      'idDocumento': idDocumento,
      'estado': estado,
    };
  }
}