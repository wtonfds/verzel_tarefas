import 'package:flutter/material.dart';
import 'package:verzel_project/components/alert.dart';
import 'package:verzel_project/models/user.dart';
import 'package:localstorage/localstorage.dart';
import 'package:verzel_project/pages/home_page.dart';

import 'login_presenter.dart';

final LocalStorage storage = new LocalStorage('verzel_app');

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginPageContract {
  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  String _email, _password;

  LoginPagePresenter _presenter;

  _LoginPageState() {
    _presenter = new LoginPagePresenter(this);
  }

  void _register() {
    Navigator.of(context).pushNamed("/register");
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _presenter.doLogin(_email, _password);
      });
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var loginBtn = new RaisedButton(
      onPressed: _submit,
      child: new Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
      color: Colors.green,
    );
    var registerBtn = new RaisedButton(
      padding: const EdgeInsets.all(10.0),
      onPressed: _register,
      child: new Text("Registre-se", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
      color: Colors.green,
    );
    var loginForm = new ListView(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        new Container(
          child: Column(
            children: <Widget>[
              Center(
                child: Text(
                  "Verzel App - Login",
                  textScaleFactor: 2.0,
                ),
              )
            ],
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
                padding: const EdgeInsets.all(20.0),
                child: new TextFormField(
                  onSaved: (val) => _email = val,
                  decoration: new InputDecoration(labelText: "Email"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(20.0),
                child: new TextFormField(
                  onSaved: (val) => _password = val,
                  obscureText: true,
                  decoration: new InputDecoration(labelText: "Senha"),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 100,
        ),
        new Padding(
            padding: const EdgeInsets.all(10.0),
            child: loginBtn
        ),
        new Padding(
            padding: const EdgeInsets.all(10.0),
            child: registerBtn
        ),
      ],
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Login Page"),
      ),
      key: scaffoldKey,
      body: new Container(
        child: new Center(
          child: loginForm,
        ),
      ),
    );
  }

  @override
  void onLoginError(String error) {
    // TODO: implement onLoginError
    _showSnackBar("Login not successful");
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(User user) async {
    // TODO: implement onLoginSuccess
    if(user.email == ""){
      alert(context, "Email é um campo obrigatorio");
    }else if(user.senha == ""){
      alert(context, "Senha é um campo obrigatorio");
    }
    setState(() {
      _isLoading = false;
    });
    if(user.flaglogged == "logged"){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>HomePage()),(Route<dynamic> route) => false);
    }else{
      alert(context, "Email ou senha Inválido");
    }
  }
}
