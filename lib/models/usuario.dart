class Usuario {
  final String userName;
  final String password;
  final String chofer;
  final String nombreChofer;
  final int idRecurso;
  final bool isRemenber;

   Usuario({
    required this.userName,
    required this.password,
    required this.nombreChofer,
    required this.chofer,
    required this.isRemenber,
    required this.idRecurso,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      userName: json['UserName'] ?? '',
      password: json['Password'] ?? '',
      nombreChofer: json['NombreChofer'] ?? '',
      chofer: json['Chofer'] ?? '',
      isRemenber: json['IsRemenber'] ?? false,
      idRecurso: json['IdRecurso'] ?? 0,
    );
  }
}