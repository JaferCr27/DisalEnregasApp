class Cliente {
  String? cliente;
  String? nombre;
  String? alias;
  String? contribuyente;
  String? direccion;
  String? telefono;
  String? contacto;
  String? nivelPrecio;
  String? condicionPago;
  double? latitud;
  double? longitud;
  String? ventanaAtencion1;
  String? ventanaAtencion2;
  String? categoriaCliente;
  String? email;
  String? ruta;
  int? secuencia;
  int? idRecurso;
  String? horaLlegada;
  int? diasCredito;
  String? vendedor;

  Cliente({
    this.cliente,
    this.nombre,
    this.alias,
    this.contribuyente,
    this.direccion,
    this.telefono,
    this.contacto,
    this.nivelPrecio,
    this.condicionPago,
    this.latitud,
    this.longitud,
    this.ventanaAtencion1,
    this.ventanaAtencion2,
    this.categoriaCliente,
    this.email,
    this.ruta,
    this.secuencia,
    this.idRecurso,
    this.horaLlegada,
    this.diasCredito,
    this.vendedor
  });
  String get condicionPagoDesc => condicionPago =="0" ? "Contado" : "Crédito";


  
  Cliente.fromJson(Map<String, dynamic> json) {
    cliente = json['Cliente'];
    nombre = json['Nombre'];
    alias = json['Alias'];
    contribuyente = json['Contribuyente'];
    direccion = json['Direccion'];
    telefono = json['Telefono'];
    contacto = json['Contacto'];
    nivelPrecio = json['NivelPrecio'];
    condicionPago = json['CondicionPago'];
    latitud = double.tryParse(json['Latitud'].toString());
    longitud = double.tryParse(json['Longitud'].toString());
    ventanaAtencion1 = json['VentanaAtencion1'];
    ventanaAtencion2 = json['VentanaAtencion2'];
    categoriaCliente = json['CategoriaCliente'];
    email = json['Email'];
    ruta = json['Ruta'];
    secuencia = json['Secuencia'];
    idRecurso = json['IdRecurso'];
    horaLlegada = json['HoraLlegada'];
    diasCredito = json['DiasCredito'];
    vendedor = json['Vendedor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Cliente'] = cliente;
    data['Nombre'] = nombre;
    data['Alias'] = alias;
    data['Contribuyente'] = contribuyente;
    data['Direccion'] = direccion;
    data['Telefono'] = telefono;
    data['Contacto'] = contacto;
    data['NivelPrecio'] = nivelPrecio;
    data['CondicionPago'] = condicionPago;
    data['Latitud'] = latitud;
    data['Longitud'] = longitud;
    data['VentanaAtencion1'] = ventanaAtencion1;
    data['VentanaAtencion2'] = ventanaAtencion2;
    data['CategoriaCliente'] = categoriaCliente;
    data['Email'] = email;
    data['Ruta'] = ruta;
    data['Secuencia'] = secuencia;
    data['IdRecurso'] = idRecurso;
    data['HoraLlegada'] = horaLlegada;
    data['DiasCredito'] = diasCredito;
    data['Vendedor'] = vendedor;
    return data;
  }
}