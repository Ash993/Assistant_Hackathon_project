import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import '../../models/user.dart';

class DBHelper {
  static Database _db;
  static const String ID = 'id';
  static const String NAME = 'name';
  static const String FAMILY = 'family';
  static const String USERNAME = 'username';
  static const String PASSWORD = 'password';
  static const String BIRTHDAY = 'birthday';
  static const String MOBILE = 'mobile';
  static const String NATIONAL_ID = 'nationalId';
  static const String USER_TABLE = 'User';
  static const String DB_NAME = 'user.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initDb();

    return _db;
  }

  initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $USER_TABLE ($USERNAME TEXT PRIMARY KEY NOT NULL, $PASSWORD TEXT)");
  }

  Future<User> save(User user) async {
    var dbClient = await db;
    user.id = await dbClient.insert(USER_TABLE, user.toMap());
    return user;
  }

  Future<List<User>> getUsers() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(USER_TABLE, columns: [
      USERNAME,
      PASSWORD,
      ]);

    List<User> users = [];

    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        users.add(User.fromMap(maps[i]));
      }
    }
    return users;
  }

  Future<dynamic> getUser(String username) async {
    final dbClient = await db;
    return await dbClient.query(USER_TABLE,
        where: "$USERNAME = ?", whereArgs: [username], limit: 1);
  }

  Future<User> checkLogin(String userName, String password) async {
    final dbClient = await db;
    var res = await dbClient.rawQuery(
        "SELECT * FROM $USER_TABLE WHERE username = '$userName' and password = '$password'");

    if (res.length > 0) {
      return new User.fromMap(res.first);
    }

    return null;
  }

  Future<int> delete(String username) async {
    var dbClient = await db;
    return await dbClient
        .delete(USER_TABLE, where: '$USERNAME = ?', whereArgs: [username]);
  }

  Future<int> update(User user) async {
    var dbClient = await db;
    return await dbClient.update(USER_TABLE, user.toMap(),
        where: '$USERNAME = ?', whereArgs: [user.username]);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}