class DocumentoLinea {
  int? idDocumento;
  int? linea;
  String? articulo;
  double? cantidad;
  int? cajas;
  int? unidades;
  int? porcImpuesto;
  String? tipo;
  int? porcDescuento;
  double? montoImp;
  double? montoDescuento;
  double? totalLinea;
  int? idMotivo;
  double? descuentoVolumen;
  double? precioUnitario;
  double? precioBulto;
  int? lineaOrigen;
  int? tieneLineaOrigen;
  String? descripcion;

  DocumentoLinea(
      {this.idDocumento,
      this.linea,
      this.articulo,
      this.cantidad,
      this.cajas,
      this.unidades,
      this.porcImpuesto,
      this.tipo,
      this.porcDescuento,
      this.montoImp,
      this.montoDescuento,
      this.totalLinea,
      this.idMotivo,
      this.descuentoVolumen,
      this.precioUnitario,
      this.precioBulto,
      this.lineaOrigen,
      this.tieneLineaOrigen,
      this.descripcion
      });

  DocumentoLinea.fromJson(Map<String, dynamic> json) {
    idDocumento = json['IdDocumento'];
    linea = json['Linea'];
    articulo = json['Articulo'];
    cantidad = json['Cantidad'];
    cajas = json['Cajas'];
    unidades = json['Unidades'];
    porcImpuesto = int.tryParse(json['PorcImpuesto'].toString()) ;
    tipo = json['Tipo'];
    porcDescuento = int.tryParse(json['PorcDescuento'].toString());
    montoImp = json['MontoImp'];
    montoDescuento = json['MontoDescuento'];
    totalLinea = json['TotalLinea'];
    idMotivo = json['IdMotivo'];
    descuentoVolumen = json['DescuentoVolumen'];
    precioUnitario = json['PrecioUnitario'];
    precioBulto = json['PrecioBulto'];
    lineaOrigen = json['LineaOrigen'];
    tieneLineaOrigen = json['TieneLineaOrigen'] == true ? 1 : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['IdDocumento'] = idDocumento;
    data['Linea'] = linea;
    data['Articulo'] = articulo;
    data['Cantidad'] = cantidad;
    data['Cajas'] = cajas;
    data['Unidades'] = unidades;
    data['PorcImpuesto'] = porcImpuesto;
    data['Tipo'] = tipo;
    data['PorcDescuento'] = porcDescuento;
    data['MontoImp'] = montoImp;
    data['MontoDescuento'] = montoDescuento;
    data['TotalLinea'] = totalLinea;
    data['IdMotivo'] = idMotivo;
    data['DescuentoVolumen'] = descuentoVolumen;
    data['PrecioUnitario'] = precioUnitario;
    data['PrecioBulto'] = precioBulto;
    data['LineaOrigen'] = lineaOrigen;
    data['TieneLineaOrigen'] = tieneLineaOrigen;
    return data;
  }
}
