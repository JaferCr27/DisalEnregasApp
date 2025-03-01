class Usuario {
  String? userName;
  String? password;
  String? chofer;
  String nombreChofer;
  int? idRecurso;
  bool? isRemenber;

   Usuario({
    this.userName,
    this.password,
    required this.nombreChofer,
    this.chofer,
    this.isRemenber,
    this.idRecurso,
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
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    //data['UserName'] = userName;
    //data['Password'] = password;
    data['Chofer'] = chofer;
    data['NombreChofer'] = nombreChofer;
    data['IdRecurso'] = idRecurso;

   //data['IsRemenber'] = isRemenber;
    return data;
  }
}