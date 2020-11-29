import 'package:sqflite/sqflite.dart';
import 'dart:async';
//mendukug pemrograman asinkron
import 'dart:io';
//bekerja pada file dan directory
import 'package:path_provider/path_provider.dart';
import 'package:amr_apps/core/model/User.dart';
//pubspec.yml

//kelass Dbhelper
class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;  

  DbHelper._createObject();

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper;
  }

  Future<Database> initDb() async {

  //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'User.db';

   //create, read databases
    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb);

    //mengembalikan nilai object sebagai hasil dari fungsinya
    return todoDatabase;
  }

    //buat tabel baru dengan nama contact
  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        token TEXT,
        password TEXT,
        full_name TEXT,
        email TEXT,
        no_telp TEXT,
        work_order_id INTEGER
      )
    ''');
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }

  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.database;
    var mapList = await db.query('user', orderBy: 'username');
    return mapList;
  }

//create databases
  Future<int> insert(User object) async {
    Database db = await this.database;
    int count = await db.insert('user', object.toMap());
    return count;
  }
//update databases
  Future<int> update(User object) async {
    Database db = await this.database;
    int count = await db.update('user', object.toMap(), 
                                where: 'username=?',
                                whereArgs: [object.username]);
    return count;
  }

//delete databases
  Future<int> delete(String username) async {
    Database db = await this.database;
    int count = await db.delete('user', 
                                where: 'username=?', 
                                whereArgs: [username]);
    return count;
  }

  Future<List<User>> getUserList() async {
    var userMapList = await select();
    int count = userMapList.length;
    List<User> userList = List<User>();
    for (int i=0; i<count; i++) {
      userList.add(User.fromMap(userMapList[i]));
    }
    return userList;
  }

}