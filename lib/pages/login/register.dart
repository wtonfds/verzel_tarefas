import 'package:flutter/material.dart';
import 'package:verzel_project/data/database-helper.dart';
import 'package:verzel_project/models/user.dart';
import 'package:cpfcnpj/cpfcnpj.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState  extends State<RegisterPage> {
  FormFieldState<List<String>> state;

  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _nome, _email, _senha, _dataNascimento, _CPF, _CEP, _endereco, _numero, _flaglogged;
  int _id;
  var controllerCPF = new MaskedTextController(mask: "000.000.000-00");
  var controlerData = new MaskedTextController(mask: '00/00/0000');


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
      child: new Text("Registrar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
      color: Colors.green,
    );


    var loginForm = new ListView(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Center(
          child: new Text(
            "Verzel App - Nova Conta",
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
                  onSaved: (val) => _email = val,
                  validator: _validador,
                  decoration: new InputDecoration(labelText: "Email *"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _senha = val,
                  validator: _validador,
                  decoration: new InputDecoration(labelText: "Senha *"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _dataNascimento = val,
                  controller: controlerData,
                  validator: _validador,
                  decoration: new InputDecoration(labelText: "Data de Nascimento *"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  controller: controllerCPF,
                  onSaved: (val) => _CPF = val,
                  decoration: new InputDecoration(labelText: "CPF"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _CEP = val,
                  decoration: new InputDecoration(labelText: "CEP"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _endereco = val,
                  decoration: new InputDecoration(labelText: "Endereço"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _numero = val,
                  decoration: new InputDecoration(labelText: "Numero"),
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
        title: new Text("Registrar-se"),
      ),
      key: scaffoldKey,
      body: new Container(
        child: new Center(
          child: loginForm,
        ),
      ),
    );
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  void _submit(){
    final form = formKey.currentState;
      if (form.validate()) {
          setState(() {
            _isLoading = true;
            form.save();
            var user = new User(_id, _nome, _email, _senha, _dataNascimento, _CPF, _CEP, _endereco, _numero, _flaglogged);
            var db = new DatabaseHelper();
            db.saveUser(user);
            _isLoading = false;
            Navigator.of(context).pushNamed("/login");
          });
        }
      }
}