import 'dart:async';
import 'package:disal_entregas/models/cliente.dart';
import 'package:disal_entregas/models/despacho.dart';
import 'package:disal_entregas/models/despacho_documento.dart';
import 'package:disal_entregas/models/documento.dart';
import 'package:disal_entregas/models/documento_linea.dart';
import 'package:disal_entregas/models/usuario.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataServices {

  static final DataServices _instance = DataServices._internal();
  factory DataServices() => _instance;
  static Database? _database;
  DataServices._internal();

  static Future<Database> getDatabase() async {
    if (_database == null || !_database!.isOpen) {
      _database = await _initDB();
    }
    return _database!;
  }
  static Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'DisalEtregas.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await _createTables(db);
      },
    );
  }
  static Future<void> _createTables(Database db) async {
    db.execute(
          '''
          CREATE TABLE DespachoDocumento (
              IdDespacho integer,
              IdDocumento integer,
              Estado varchar
          )       
          '''
    );
    db.execute(
          '''
          CREATE TABLE Despacho (
              IdDespacho integer primary key not null ,
              IdCamion integer , 
              IdFurgon integer , 
              IdRecurso integer , 
              CantidadFinalizados integer , 
              CantidadPendientes integer , 
              RutaTerminada integer , 
              FinInventario integer , 
              Consecutivo varchar , 
              FechaHoraRutaTerminada varchar , 
              FechaEntregaOrdenar varchar , 
              FechaEntregaMostrar varchar , 
              Fecha varchar , 
              FechaEntrega varchar , 
              HoraSalida varchar , 
              Bodega varchar , 
              Observacion varchar 
          )       
          '''
      );
    db.execute(
          '''
          CREATE TABLE ClienteModel ( 
            Cliente varchar primary key not null , 
            Nombre varchar , 
            Alias varchar , 
            Contribuyente varchar , 
            Direccion varchar , 
            Telefono varchar , 
            Contacto varchar , 
            NivelPrecio varchar , 
            CondicionPago varchar,
            Latitud varchar , 
            Longitud varchar , 
            VentanaAtencion1 varchar , 
            VentanaAtencion2 varchar ,
            CategoriaCliente varchar,
            Email varchar, 
            Ruta varchar , 
            Secuencia integer , 
            IdRecurso integer , 
            HoraLlegada varchar , 
            DiasCredito integer , 
            Vendedor varchar 
          )
          '''
      );
    db.execute(
      '''
          CREATE TABLE DocumentoModel (
              IdDocumento integer,
              Documento varchar,
              FechaDocumento varchar,
              FechaEntrega varchar,
              Cliente varchar,
              TotalDocumento float,
              Impuesto float,
              Descuento float,
              DescuentoVolumen float,
              Moneda varchar,
              OrdenCompra varchar,
              Pedido varchar,
              TipoDocumento varchar,
              NivelPrecio varchar,
              Version integer,
              CondicionPago integer,
              Ruta varchar,
              Condicionada integer,
              Bodega varchar,
              Estado varchar,
              IdRechazo integer,
              Naturaleza varchar,
              IdMotivo integer,
              EstadoERP varchar,
              IdRecurso integer,
              EntregaNula integer,
              IdDespacho integer,
              Marchamo varchar
          )       
          '''
    );
    db.execute(
      '''
          CREATE TABLE DocumentoLineaModel (
              IdDocumento integer,
              Linea integer,
              Articulo varchar,
              Cantidad float,
              Cajas integer,
              Unidades integer,
              PorcImpuesto integer,
              Tipo varchar,
              PorcDescuento integer,
              MontoImp float,
              MontoDescuento float,
              TotalLinea float,
              IdMotivo integer,
              DescuentoVolumen integer,
              PrecioUnitario float,
              PrecioBulto float,
              LineaOrigen integer,
              TieneLineaOrigen integer
          )       
          '''
    );
    db.execute(
          '''
          CREATE TABLE VendedorModel (
              Vendedor varchar,
              Descripcion varchar,
              Supervisor varchar,
              Email varchar,
              Tipo varchar,
              Telefono varchar
          )       
          '''
    );
    db.execute(
          '''
          CREATE TABLE EventoModel (
              IdEvento integer primary key not null,
              Evento varchar,
              Descripcion varchar
          )       
          '''
    );
    db.execute(
          '''
          CREATE TABLE RegistroEventoModel (
            IdRegistroEvento integer,
            IdEvento integer,
            IdDespacho integer,
            IdRecurso integer,
            IdMotivo integer,
            IdDocumento integer,
            IdRechazo integer,
            Cliente varchar,
            Usuario varchar,
            Longitud float,
            Latitud float,
            Observacion varchar,
            Estado varchar,
            FechaCreacionMovil varchar,
            FechaHora varchar,
            Transmitido integer,
            Evento varchar
          )       
          '''
    );
    db.execute(
          '''
          CREATE TABLE ArticuloModel (
            Articulo varchar,
            Descripcion varchar,
            DescripcionCorta varchar,
            FactorEmpaque integer,
            Ean13 varchar,
            Dun14 varchar,
            Impuesto varchar,
            PesoBruto float,
            PesoNeto float,
            CabyS varchar,
            Costo float,
            Tipo varchar,
            EsArroz integer
          )       
          '''
    );
    db.execute(
          '''
          CREATE TABLE UsuarioModel (
            Chofer varchar,
            NombreChofer varchar,
            IdRecurso int
          )       
          '''
    );
/**
 * Estos campos no se si se usan en la tabla cliente
 * ItemCount integer , 
            CantidadDocumentos integer , 
            IdDespacho integer , 
            OrdenVisita integer , 
            VentaMinima float , 
            LimiteCredito float , 
            TieneNoCompra integer , 
            TieneVisita integer , 
            DebeSerVisitado integer , 
            Sincronizado integer , 
            ClienteNoVisitado integer , 
            SolicitudInactivacion integer , 
            InicioVisita integer , 
            FinVisita integer , 
            RegistroNoVisita integer , 
            ClienteReabierto integer , 
            TieneEntregaNula integer , 
            RegistroClienteReabierto integer , 
            NombreCliente varchar , 
            Detalle1 varchar , 
            Detalle2 varchar , 
            ContribuyenteCliente varchar , 
            Activo varchar , 
            Icon varchar , 
            Opciones varchar , 
            Provincia varchar , 
            Fecha varchar , 
            BackgroundColor varchar 
 * 
 */
  }
  // Método para cerrar la base de datos
  Future<void> closeDB() async {
    final db = await getDatabase();
    db.close();
  }
  // Método para borrar todos los registros antes de insertar
  Future<void> deleteAll() async {
    final db = await getDatabase();
    await db.delete('DocumentoLineaModel'); 
    await db.delete('DocumentoModel'); 
    await db.delete('DespachoDocumento'); 
    await db.delete('ClienteModel'); 
    await db.delete('VendedorModel'); 
    await db.delete('EventoModel'); 
    await db.delete('RegistroEventoModel');    
    await db.delete('Despacho'); 
    await db.delete('ArticuloModel'); 
    await db.delete('UsuarioModel'); 
  }
  // Inserts
  Future<void> insertar(List<dynamic> lista, String modelo) async {
    final db = await getDatabase();
    final batch = db.batch();
    for (var value in lista) {
      batch.insert(modelo, value.toJson());
    }
    await batch.commit(noResult: true); 
  }
  // Selects 
  Future<List<Despacho>> getDespachos() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> despachos = await db.rawQuery(
      '''
        SELECT d.IdDespacho, d.Consecutivo,d.FechaEntrega,d.RutaTerminada, count(distinct doc.Cliente) CantidadDocs
        FROM Despacho d 
        INNER JOIN DespachoDocumento dd ON d.IdDespacho = dd.IdDespacho
        INNER JOIN DocumentoModel doc ON dd.IdDocumento = doc.IdDocumento
        group by d.IdDespacho, d.Consecutivo,d.FechaEntrega,d.RutaTerminada
        order by d.RutaTerminada asc
      '''); 
      return despachos.map((map) {
      return Despacho (
        idDespacho:  map['IdDespacho'],
        consecutivo: map['Consecutivo'],
        fechaEntrega: map['FechaEntrega'],
        cantidadDocs: map['CantidadDocs'],
        rutaTerminada: map['RutaTerminada']
      );
    }).toList();
  }
  Future<List<Cliente>> getClientes() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('ClienteModel');
    return List.generate(maps.length, (i) {
      return Cliente.fromJson(maps[i]);
    });
  }
  Future<List<Cliente>> getClientesDespacho(int idDespacho) async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> clientes = await db.rawQuery(
      '''
        SELECT 
          c.Cliente, c.Nombre, c.Alias,c.Direccion,c.VentanaAtencion1,c.VentanaAtencion2,c.Vendedor,c.HoraLlegada,c.Secuencia,
          c.CondicionPago,
          c.Contacto,
          c.Telefono
        FROM Despacho d 
        INNER JOIN DespachoDocumento dd ON d.IdDespacho = dd.IdDespacho
        INNER JOIN DocumentoModel doc ON dd.IdDocumento = doc.IdDocumento
        INNER JOIN ClienteModel c on doc.Cliente = c.Cliente
        WHERE d.IdDespacho = ?  
        group by c.Cliente,c.Nombre, c.Alias,c.Direccion,c.VentanaAtencion1,c.VentanaAtencion2,c.Vendedor,c.HoraLlegada,c.Secuencia,
        c.CondicionPago
      ''', [idDespacho]); 
    
    return clientes.map((map) {
      return Cliente(
        cliente: map['Cliente'],
        nombre: map['Nombre'],
        alias: map['Alias'],
        direccion: map['Direccion'],
        ventanaAtencion1: map['VentanaAtencion1'],
        ventanaAtencion2: map['VentanaAtencion2'],
        vendedor: map['Vendedor'],
        horaLlegada: map['HoraLlegada'],
        secuencia: map['Secuencia'],
        condicionPago: map['CondicionPago'],
        contacto: map['Contacto'],
        telefono: map['Telefono'],
      );
    }).toList();
  }
  Future<List<Documento>> getDocumentosClienteDespacho(String cliente, int idDespacho) async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> documentos = await db.rawQuery(
      '''
        SELECT 
               doc.IdDocumento,
               doc.Documento,
               doc.TipoDocumento,
               doc.TotalDocumento, 
               doc.FechaEntrega,
               doc.Estado,
               doc.Ruta,
               doc.Marchamo, 
               doc.CondicionPago,
               doc.CondicionPago
        FROM Despacho d 
        INNER JOIN DespachoDocumento dd ON d.IdDespacho = dd.IdDespacho
        INNER JOIN DocumentoModel doc ON dd.IdDocumento = doc.IdDocumento
        WHERE d.IdDespacho = ? and doc.Cliente = ?  
      ''', [idDespacho, cliente]
      ); 
      return documentos.map((map) {
      return Documento(
        idDocumento: map['IdDocumento'],
        documento: map['Documento'],
        tipoDocumento: map['TipoDocumento'],
        totalDocumento: map['TotalDocumento'],
        fechaEntrega: map['FechaEntrega'],
        estado: map['Estado'],
        ruta: map['Ruta'],
        marchamo: map['Marchamo'],
        condicionPago: map['CondicionPago'],
      );
    }).toList();
  }
  Future<List<DocumentoLinea>> getDocumentoLinea(int idDocumento) async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> lineas = await db.rawQuery(
      '''
        SELECT 
               dl.IdDocumento,
               dl.Articulo,
               dl.Cajas,
               dl.Unidades,
               dl.Linea,
               ifnull(a.DescripcionCorta,a.Descripcion) Descripcion
        FROM DocumentoModel d 
        INNER JOIN DocumentoLineaModel dl ON d.IdDocumento = dl.IdDocumento
        INNER JOIN ArticuloModel a ON dl.Articulo = a.Articulo
        WHERE d.IdDocumento = ? 
        order by a.Descripcion
      ''', [idDocumento]
      ); 
      return lineas.map((map) {
      return DocumentoLinea(
        idDocumento: map['IdDocumento'],
        articulo: map['Articulo'],
        cajas: map['Cajas'],
        unidades: map['Unidades'],
        linea: map['Linea'],
        descripcion:map['Descripcion'],
      );
    }).toList();
  }



 Future<Usuario> getUsuario() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> usuarios = await db.query('UsuarioModel');
    return Usuario.fromJson(usuarios.first);
  }
}


  // Future<void> insertarClientes(List<Cliente> clientes) async {
  //   final db = await getDatabase();
  //   final batch = db.batch();
  //   for (var cliente in clientes) {
  //     batch.insert('ClienteModel', cliente.toJson());
  //   }
  //   await batch.commit(noResult: true); 
  // }
  // Future<void> insertDespachoDocs(List<DespachoDocumento> despachoDocumentos) async {
  //   final db = await getDatabase();
  //   final batch = db.batch();
  //   for (var despachoDocs in despachoDocumentos) {
  //     batch.insert('DespachoDocumento', despachoDocs.toJson());
  //   }
  //   await batch.commit(noResult: true);
  // }
  // Future<void> insertarDocumentos(List<Documento> documentos) async {
  //   final db = await getDatabase();
  //   final batch = db.batch();
  //   for (var despachoDocs in documentos) {
  //     batch.insert('DocumentoModel', despachoDocs.toJson());
  //   }
  //   await batch.commit(noResult: true);
  // }  
  // Método para eliminar la base de datos
  // Future<void> deleteDB() async {
  //   final path = await getDatabasesPath();
  //   final dbPath = join(path, 'DisalEtregas.db');
  //   await deleteDatabase(dbPath);
  // }

  // Future<void> dropAllTables() async {
  //   final db = await getDatabase();
  //   await db.execute(DROP TABLE IF EXISTS DespachoDocumento);
  //   await db.execute(DROP TABLE IF EXISTS Despacho);
  // }
