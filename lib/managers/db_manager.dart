import 'dart:io';

import 'package:pokedex/models/pokemon.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final String tableName = 'pokemon';

class DBHelper {

  DBHelper._();

  static final DBHelper _db = DBHelper._();
  factory DBHelper() => _db;

  // 해당 변수에 데이터 베이스 정보를 담을 것이다
  static Database? _database;

  // 생성된 데이터베이스가 있다면 _database를 리턴하고
  // 없다면 데이터베이스를 생성하여 리턴한다.
  Future<Database> get database async =>
    _database ??= await initDB();

  // 데이터베이스 초기화 함수
  Future<Database> initDB() async {
    Directory documentsDirectory = await
        getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'pokemon.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE $tableName(
          id TEXT PRIMARY KEY,
          name TEXT,
          img_url TEXT,
          type TEXT,
          desc TEXT,
          add_desc TEXT,
          species TEXT)
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) {}
    );
  }

  // CREATE
  createData(Pokemon pokemon) async {
    final db = await database;
    var res = await db.insert(tableName, pokemon.toJson());
    return res;
  }

  // READ
  Future<Pokemon> getPokemon(String id) async {
    final db = await database;
    var res = await db.query(tableName, where: 'id = ?', whereArgs: [id]);
    List<Pokemon> list =
      res.isNotEmpty ? res.map((c) => Pokemon.fromJson(c)).toList() : [];
    Pokemon pokemon = list[0];
    return pokemon;
  }

  // READ ALL
  Future<List<Pokemon>> getAllPokemon() async {
    final db = await database;
    var res = await db.query(tableName);
    List<Pokemon> list =
        res.isNotEmpty ? res.map((c) => Pokemon.fromJson(c)).toList() : [];
    return list;
  }

  // DELETE
  deletePokemon(String id) async {
    final db = await database;
    db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
