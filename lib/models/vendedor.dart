class Vendedor {
  String? vendedor;
  String? descripcion;
  String? supervisor;
  String? email;
  String? tipo;
  String? telefono;

  Vendedor(
      {this.vendedor,
      this.descripcion,
      this.supervisor,
      this.email,
      this.tipo,
      this.telefono});

  Vendedor.fromJson(Map<String, dynamic> json) {
    vendedor = json['Vendedor'];
    descripcion = json['Descripcion'];
    supervisor = json['Supervisor'];
    email = json['Email'];
    tipo = json['Tipo'];
    telefono = json['Telefono'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Vendedor'] = vendedor;
    data['Descripcion'] = descripcion;
    data['Supervisor'] = supervisor;
    data['Email'] = email;
    data['Tipo'] = tipo;
    data['Telefono'] = telefono;
    return data;
  }
}