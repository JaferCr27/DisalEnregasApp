import 'package:flutter/material.dart';

class Documento {
  int idDocumento;
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
      required this.idDocumento,
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
    String get tipoDocDesc {
      const Map<String, String> tipos = {
        "FACT": "Factura",
        "CAMV": "Cambios Vendedor",
      };
      return tipos[tipoDocumento ?? ""] ?? "";
    }

    String get estadoDesc {
      if (estado == "PEND") {
        return "Pendiente";
      }
      return "";
    }
    Icon get IconDoc {
      if (tipoDocumento == "FACT") {
        return const Icon(Icons.receipt_long, color: Color.fromRGBO(218, 86, 48, 1),);
      }
      return const Icon(Icons.inventory_2, color: Color.fromRGBO(52, 75, 115, 1),);
    }



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
    data['IdDocumento'] = idDocumento;
    data['Documento'] = documento;
    data['FechaDocumento'] = fechaDocumento;
    data['FechaEntrega'] = fechaEntrega;
    data['Cliente'] = cliente;
    data['TotalDocumento'] = totalDocumento;
    data['Impuesto'] = impuesto;
    data['Descuento'] = descuento;
    data['DescuentoVolumen'] = descuentoVolumen;
    data['Moneda'] = moneda;
    data['OrdenCompra'] = ordenCompra;
    data['Pedido'] = pedido;
    data['TipoDocumento'] = tipoDocumento;
    data['NivelPrecio'] = nivelPrecio;
    data['Version'] = version;
    data['CondicionPago'] = condicionPago;
    data['Ruta'] = ruta;
    data['Condicionada'] = condicionada;
    data['Bodega'] = bodega;
    data['Estado'] = estado;
    data['IdRechazo'] = idRechazo;
    data['Naturaleza'] = naturaleza;
    data['IdMotivo'] = idMotivo;
    data['EstadoERP'] = estadoERP;
    data['IdRecurso'] = idRecurso;
    data['EntregaNula'] = entregaNula;
    data['IdDespacho'] = idDespacho;
    data['Marchamo'] = marchamo;
    return data;
  }
}