import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import 'package:localstorage/localstorage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:verzel_project/models/user.dart';


class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  final LocalStorage storage = new LocalStorage('verzel_app');

  static Database _db;
  final String tableUser = "User";
  final String columnId = "id";
  final String columnNome = "nome";
  final String columnEmail = "email";
  final String columnSenha = "senha";
  final String columnDataNascimento = "dataNascimento";
  final String columnCPF = "CPF";
  final String columnCEP = "CEP";
  final String columnEndereco = "endereco";
  final String columnNumero = "numero";

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "verzel.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE User(id INTEGER PRIMARY KEY, nome TEXT, email TEXT, senha TEXT, "
            "dataNascimento TEXT, CPF TEXT, CEP TEXT, endereco TEXT, numero TEXT, flaglogged TEXT)");
    print("Table is created");
  }

  //insertion
  Future<int> saveUser(User user) async {
    var dbClient = await db;
    print(user.nome);
    int res = await dbClient.insert("User", user.toMap());
    /*List<Map> list = await dbClient.rawQuery('SELECT * FROM User');
    print(list);*/
    return res;
  }

  //deletion
  Future<int> deleteUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.delete("User");
    return res;
  }
  Future<User> selectUser(User user) async{

    var dbClient = await db;
    List<Map> maps = await dbClient.query(tableUser,
        columns: [columnEmail, columnSenha],
        where: "$columnEmail = ? and $columnSenha = ?",
        whereArgs: [user.email,user.senha]);

    if (maps.length > 0) {
      return user;
    }else {
      return null;
    }
  }

  Future<User> idGetUser(User user) async{

    var dbClient = await db;
    List<Map> maps = await dbClient.query(tableUser,
        columns: [columnId],
        where: "$columnId = ?",
        whereArgs: [user.id]);

    if (maps.length > 0) {
      return user;
    }else {
      return null;
    }
  }

}
