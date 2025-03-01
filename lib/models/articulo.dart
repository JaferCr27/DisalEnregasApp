class Articulo {
  String? articulo;
  String? descripcion;
  String? descripcionCorta;
  int? factorEmpaque;
  String? ean13;
  String? dun14;
  String? impuesto;
  double? pesoBruto;
  double? pesoNeto;
  String? cabyS;
  double? costo;
  String? tipo;
  bool? esArroz;

  Articulo(
      {this.articulo,
      this.descripcion,
      this.descripcionCorta,
      this.factorEmpaque,
      this.ean13,
      this.dun14,
      this.impuesto,
      this.pesoBruto,
      this.pesoNeto,
      this.cabyS,
      this.costo,
      this.tipo,
      this.esArroz});

  Articulo.fromJson(Map<String, dynamic> json) {
    articulo = json['Articulo'];
    descripcion = json['Descripcion'];
    descripcionCorta = json['DescripcionCorta'];
    factorEmpaque = json['FactorEmpaque'];
    ean13 = json['Ean13'];
    dun14 = json['Dun14'];
    impuesto = json['Impuesto'];
    pesoBruto = json['PesoBruto'];
    pesoNeto = json['PesoNeto'];
    cabyS = json['CabyS'];
    costo = json['Costo'];
    tipo = json['Tipo'];
    esArroz = json['EsArroz'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Articulo'] = articulo;
    data['Descripcion'] = descripcion;
    data['DescripcionCorta'] = descripcionCorta;
    data['FactorEmpaque'] = factorEmpaque;
    data['Ean13'] = ean13;
    data['Dun14'] = dun14;
    data['Impuesto'] = impuesto;
    data['PesoBruto'] = pesoBruto;
    data['PesoNeto'] = pesoNeto;
    data['CabyS'] = cabyS;
    data['Costo'] = costo;
    data['Tipo'] = tipo;
    data['EsArroz'] = esArroz;
    return data;
  }
}