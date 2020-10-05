import 'package:flutter/material.dart';
import 'package:verzel_project/data/database-tarefas.dart';
import 'package:verzel_project/models/tarefa.dart';
import 'package:verzel_project/pages/home_page.dart';

class CadastroTarefasPage extends StatefulWidget {
  @override
  _CadastroTarefasPageState createState() => _CadastroTarefasPageState();
}

class _CadastroTarefasPageState extends State<CadastroTarefasPage> {
  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _emailUser, _nome, _dataConcluir, _dataEntrega;
  bool _concluido;
  String _validador( String texto){
    if(texto.isEmpty){
      return "Campo Obrigatorio";
    }
    return null;
  }


  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var loginBtn = new RaisedButton(
      onPressed: _submit,
      child: new Text("Cadastro de tarefas", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
      color: Colors.green,
    );


    var loginForm = new ListView(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Center(
          child: new Text(
            "Verzel App",
            textScaleFactor: 2.0,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _nome = val,
                  validator: _validador,
                  decoration: new InputDecoration(labelText: "Nome *"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _dataConcluir = val,
                  validator: _validador,
                  decoration: new InputDecoration(labelText: "Data de entrega *"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _dataEntrega = val,
                  decoration: new InputDecoration(labelText: "Data de conclusão"),
                ),
              )
            ],
          ),
        ),
        new Padding(
            padding: const EdgeInsets.all(10.0),
            child: loginBtn
        ),
      ],
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Nova Tarefa"),
      ),
      key: scaffoldKey,
      body: new Container(
        child: new Center(
          child: loginForm,
        ),
      ),
    );
  }

  void _submit(){
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        form.save();
        var emailUser = storage.getItem("emailUser");
        _emailUser = emailUser;
        _concluido = false;
        var tarefa = new Tarefa(_emailUser ,_nome, _dataEntrega, _dataConcluir, _concluido);
        var db = new DatabaseTarefas();
        db.saveTarefa(tarefa);
        Navigator.of(context).pushNamed("/home");
      });
    }
  }
}