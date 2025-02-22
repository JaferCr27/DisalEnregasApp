import 'dart:async';
import 'package:disal_entregas/models/cliente.dart';
import 'package:disal_entregas/models/despacho.dart';
import 'package:disal_entregas/models/despacho_documento.dart';
import 'package:disal_entregas/models/documento.dart';
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
    await db.delete('DespachoDocumento'); 
    await db.delete('Despacho'); 
    await db.delete('ClienteModel'); 
    await db.delete('DocumentoModel'); 
  }

  // Inserts
  // `noResult: true` mejora el rendimiento
  Future<void> insertarClientes(List<Cliente> clientes) async {
    final db = await getDatabase();
    final batch = db.batch();
    for (var cliente in clientes) {
      batch.insert('ClienteModel', cliente.toJson());
    }
    await batch.commit(noResult: true); 
  }
  Future<void> insertDespachoDocs(List<DespachoDocumento> despachoDocumentos) async {
    final db = await getDatabase();
    final batch = db.batch();
    for (var despachoDocs in despachoDocumentos) {
      batch.insert('DespachoDocumento', despachoDocs.toJson());
    }
    await batch.commit(noResult: true);
  }
  Future<void> insertarDocumentos(List<Documento> documentos) async {
    final db = await getDatabase();
    final batch = db.batch();
    for (var despachoDocs in documentos) {
      batch.insert('DocumentoModel', despachoDocs.toJson());
    }
    await batch.commit(noResult: true);
  }  



  // Selects 
  Future<List<DespachoDocumento>> getAllDespachoDocumento() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('DespachoDocumento');
    return List.generate(maps.length, (i) {
      return DespachoDocumento.fromJson(maps[i]);
    });
  }
  Future<List<Despacho>> getAllDespachos() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('Despacho');
    return List.generate(maps.length, (i) {
      return Despacho.fromJson(maps[i]);
    });
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
        SELECT c.Cliente, c.Nombre, c.Alias,c.Direccion,c.VentanaAtencion1,c.VentanaAtencion2,c.Vendedor,c.HoraLlegada,c.Secuencia,
        c.CondicionPago
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
      );
    }).toList();
  }



  Future<int> insertDespacho(Despacho despacho) async {
    final db = await getDatabase();
    return await db.insert('Despacho', despacho.toJson());  
  }

}



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
