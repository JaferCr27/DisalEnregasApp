class Usuario {
  final String userName;
  final String password;
  final String nombreChofer;
  final String chofer;
  final String empresa;
  final bool isRemenber;
  final int idRecurso;

   Usuario({
    required this.userName,
    required this.password,
    required this.nombreChofer,
    required this.chofer,
    required this.empresa,
    required this.isRemenber,
    required this.idRecurso,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      userName: json['UserName'] ?? '',
      password: json['Password'] ?? '',
      nombreChofer: json['NombreChofer'] ?? '',
      chofer: json['Chofer'] ?? '',
      empresa: json['Empresa'] ?? '',
      isRemenber: json['IsRemenber'] ?? false,
      idRecurso: json['IdRecurso'] ?? 0,
    );
  }
}