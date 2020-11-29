import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:amr_apps/core/model/User.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper{
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if(_db != null)
      return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }
  

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute("CREATE TABLE User (id INTEGER PRIMARY KEY AUTOINCREMENT,username TEXT, token TEXT, work_order_id INTEGER, full_name TEXT, email TEXT, no_telp TEXT, isLogin TEXT)");
    print("Created tables User");
  }

  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert("User", user.toMap());
    return res;
  }

  Future<int> deleteUsers(String username) async {
    var dbClient = await db;
    int res = await dbClient.delete("User",where: "username=?",whereArgs: [username]);
    return res;
  }

  Future<bool> isLoggedIn() async {
    var dbClient = await db;
    var res = await dbClient.query("User");
    return res.length > 0? true: false;
  }
  Future <bool> updateToken(User user) async{
    var dbClient = await db;
    var result = await dbClient.rawUpdate('UPDATE User SET token = ? , username = ? WHERE username = ?',[user.token,user.username,user.username]);
    return result == 1 ? true:false;
  }
  Future <Map> getUser()async{
    var dbClient =  await db;
    var res = await dbClient.rawQuery("Select * from User");
    if(res.isEmpty){
      return null;
    }
    return res.first;
  }
  Future<User> checkUser(String username)async{
    var dbClient = await db;
    var result = await dbClient.rawQuery('Select * from User WHERE username = ?',[username]);
    var user = User.fromMap(result.first);
    return user;
  }
}