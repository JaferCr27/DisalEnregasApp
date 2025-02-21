import 'dart:async';
import 'package:disal_entregas/models/cliente.dart';
import 'package:disal_entregas/models/despacho.dart';
import 'package:disal_entregas/models/despacho_documento.dart';
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
          ''',
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
          ''',
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
          ''',

/**
 * Estos campos no se si se usan en la DB
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
          
      );
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


  // Inserts
  Future<int> insertDocumento(DespachoDocumento documento) async {
    final db = await getDatabase();
    return await db.insert('DespachoDocumento', documento.toJson());
  }

  Future<int> insertCliente(Cliente cliente) async {
    final db = await getDatabase();
    return await db.insert('ClienteModel', cliente.toJson());
  }

  Future<void> insertarClientes(List<Cliente> clientes) async {
    final db = await getDatabase();
    final batch = db.batch();
    for (var cliente in clientes) {
      batch.insert('ClienteModel', cliente.toJson());
    }
    await batch.commit(noResult: true); // `noResult: true` mejora el rendimiento
  }



  Future<int> insertDespacho(Despacho despacho) async {
    final db = await getDatabase();
    return await db.insert('Despacho', despacho.toJson());  
  }
  // Obtener todos los documentos
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
  
}