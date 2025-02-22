class Documento {
  int? idDocumento;
  String? documento;
  String? fechaDocumento;
  String? fechaEntrega;
  String? cliente;
  double? totalDocumento;
  double? impuesto;
  double? descuento;
  double? descuentoVolumen;
  String? moneda;
  String? ordenCompra;
  String? pedido;
  String? tipoDocumento;
  String? nivelPrecio;
  int? version;
  int? condicionPago;
  String? ruta;
  bool? condicionada;
  String? bodega;
  String? estado;
  int? idRechazo;
  String? naturaleza;
  int? idMotivo;
  String? estadoERP;
  int? idRecurso;
  bool? entregaNula;
  int? idDespacho;
  String? marchamo;

  Documento({
      this.idDocumento,
      this.documento,
      this.fechaDocumento,
      this.fechaEntrega,
      this.cliente,
      this.totalDocumento,
      this.impuesto,
      this.descuento,
      this.descuentoVolumen,
      this.moneda,
      this.ordenCompra,
      this.pedido,
      this.tipoDocumento,
      this.nivelPrecio,
      this.version,
      this.condicionPago,
      this.ruta,
      this.condicionada,
      this.bodega,
      this.estado,
      this.idRechazo,
      this.naturaleza,
      this.idMotivo,
      this.estadoERP,
      this.idRecurso,
      this.entregaNula,
      this.idDespacho,
      this.marchamo
    });

    factory Documento.fromJson(Map<String, dynamic> json){
      return Documento(
        idDocumento : json['IdDocumento'],
        documento : json['Documento'],
        fechaDocumento : json['FechaDocumento'],
        fechaEntrega : json['FechaEntrega'],
        cliente : json['Cliente'],
        totalDocumento : json['TotalDocumento'],
        impuesto : json['Impuesto'],
        descuento : json['Descuento'],
        descuentoVolumen : json['DescuentoVolumen'],
        moneda : json['Moneda'],
        ordenCompra : json['OrdenCompra'],
        pedido : json['Pedido'],
        tipoDocumento : json['TipoDocumento'],
        nivelPrecio : json['NivelPrecio'],
        version : json['Version'],
        condicionPago : json['CondicionPago'],
        ruta : json['Ruta'],
        condicionada :  bool.tryParse(json['Condicionada'].toString()),
        bodega : json['Bodega'],
        estado : json['Estado'],
        idRechazo : json['IdRechazo'],
        naturaleza : json['Naturaleza'],
        idMotivo : json['IdMotivo'],
        estadoERP : json['EstadoERP'],
        idRecurso : json['IdRecurso'],
        entregaNula : bool.tryParse(json['EntregaNula'].toString()) ,
        idDespacho : json['IdDespacho'],
        marchamo : json['Marchamo'],
      );
    }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdDocumento'] = this.idDocumento;
    data['Documento'] = this.documento;
    data['FechaDocumento'] = this.fechaDocumento;
    data['FechaEntrega'] = this.fechaEntrega;
    data['Cliente'] = this.cliente;
    data['TotalDocumento'] = this.totalDocumento;
    data['Impuesto'] = this.impuesto;
    data['Descuento'] = this.descuento;
    data['DescuentoVolumen'] = this.descuentoVolumen;
    data['Moneda'] = this.moneda;
    data['OrdenCompra'] = this.ordenCompra;
    data['Pedido'] = this.pedido;
    data['TipoDocumento'] = this.tipoDocumento;
    data['NivelPrecio'] = this.nivelPrecio;
    data['Version'] = this.version;
    data['CondicionPago'] = this.condicionPago;
    data['Ruta'] = this.ruta;
    data['Condicionada'] = this.condicionada;
    data['Bodega'] = this.bodega;
    data['Estado'] = this.estado;
    data['IdRechazo'] = this.idRechazo;
    data['Naturaleza'] = this.naturaleza;
    data['IdMotivo'] = this.idMotivo;
    data['EstadoERP'] = this.estadoERP;
    data['IdRecurso'] = this.idRecurso;
    data['EntregaNula'] = this.entregaNula;
    data['IdDespacho'] = this.idDespacho;
    data['Marchamo'] = this.marchamo;
    return data;
  }
}