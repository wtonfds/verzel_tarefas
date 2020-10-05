import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:verzel_project/models/tarefa.dart';
import 'package:localstorage/localstorage.dart';
import 'package:verzel_project/models/user.dart';

class DatabaseTarefas{
  static final DatabaseTarefas _instance = new DatabaseTarefas.internal();
  factory DatabaseTarefas() => _instance;
  final LocalStorage storage = new LocalStorage('verzel_app');

  static Database _db;
  final String tableUser = "Tarefa";
  final String columnNome = "nome";
  final String columnDataEntrega = "dataEntrega";
  final String columnDataConcluir = "dataConcluir";
  final bool columnConcluido = null;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseTarefas.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "tarefa-main.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE Tarefa(id INTEGER PRIMARY KEY, emailUser TEXT, nome TEXT, "
            "dataEntrega TEXT, dataConcluir TEXT, concluido BOOLEAN)");
    print("Table is created");
  }

  //insertion
  Future<int> saveTarefa(Tarefa tarefa) async {
    var dbTarefa = await db;
    int res = await dbTarefa.insert("Tarefa", tarefa.toMap());
    List<Map> list = await dbTarefa.rawQuery('SELECT * FROM Tarefa');
    print(list);
    return res;
  }

  //deletion
  Future<int> deleteTarefa(id) async {
    var dbTarefa = await db;
    int res = (await dbTarefa.rawDelete('DELETE FROM Tarefa where id = "$id"')) as int;
    return res;
  }
  
  Future<int> updateTarefa(int id, nome, dataEntrega ) async{
    var dbTarefa = await db;
    int res = await dbTarefa.rawUpdate('UPDATE Tarefa SET nome = ?, dataEntrega = ? WHERE id = "$id"',
        ['$nome', '$dataEntrega']);
    return res;
  }

  Future<int> concluirTarefa(id, status, conclusao) async {
    var dbTarefa = await db;
    int res = await dbTarefa.rawUpdate('UPDATE Tarefa SET concluido = ?, dataConcluir = ? WHERE id = "$id"',
        ['$status', '$conclusao']);
    return res;
  }

  Future<List> queryTarefa() async{
    var emailUser = storage.getItem("emailUser");
    var dbTarefa = await db;
    List<Map> list = await dbTarefa.rawQuery('SELECT * FROM Tarefa WHERE emailUser == "$emailUser"');
    return list;
  }


}