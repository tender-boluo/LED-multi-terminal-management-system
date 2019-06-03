import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/images.dart';

class DatabaseHelper{

  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper()=>_instance;


  DatabaseHelper.internal();

  static Database _db;

  Future<Database> get db async{
    if(_db != null){
      return _db;
    }else{
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async{
    /*获取app的 文档目录 android 中的appdata*/
    Directory documentDirectory =  await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path,"terminal.db");
    var ourDb = await openDatabase(path,version: 1,onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async{
    await db.execute(
        "CREATE TABLE Images(id INTEGER PRIMARY KEY, fileName TEXT)");
    print("table create");
  }

  /*保存对象*/
  Future<int> saveImage(Images image) async {
    var dbClient = await db;
    int res = await dbClient.rawInsert(
          'INSERT INTO Images(fileName) VALUES(?)',
          [image.imageName]);
    return res;
  }

  /*获取所有的数据*/
  Future<List> getAllImages() async{
    var dbClient = await db;
    var result =  await dbClient.query("Images",columns: ["fileName"]);
    return result.toList();
  }

  /*获取数据数据的数量*/
  Future<int> getCount() async{
    var dbClient = await db;
    int cnt = Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM Images'));
    return cnt;
  }

  Future close() async{
    var dbClient = await db;
    return dbClient.close();
  }
}