import 'package:flutter/material.dart';
import 'package:verzel_project/pages/cadastro_tarefa.dart';
import 'package:verzel_project/pages/home_page.dart';
import 'package:verzel_project/pages/login/login_page.dart';
import 'package:verzel_project/pages/login/register.dart';


void main() => runApp(MyApp());

final routes = {
  '/login': (BuildContext context) => new LoginPage(),
  '/home': (BuildContext context) => new HomePage(),
  '/register': (BuildContext context) => new RegisterPage(),
  '/': (BuildContext context) => new LoginPage(),
  '/cadastroTarefas' : (BuildContext context) => new CadastroTarefasPage(),
};

class MyApp extends StatelessWidget {
 
 @override
 Widget build(BuildContext context){
   return new MaterialApp(
     debugShowCheckedModeBanner: false,
     title: 'Sqflite App',
     theme: new ThemeData(primarySwatch: Colors.teal),
     routes: routes,
   );
 }
}
