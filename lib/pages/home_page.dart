import 'package:localstorage/localstorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:verzel_project/pages/tarefas.dart';
import 'login/login_page.dart';

final LocalStorage storage = new LocalStorage('verzel_app');


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool dialVisible = true;

  @override
  Widget build(BuildContext context) {

    SpeedDial buildSpeedDial() {
      return SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        // child: Icon(Icons.add),
        visible: dialVisible,
        curve: Curves.bounceIn,
        children: [
          SpeedDialChild(
            child: Icon(Icons.exit_to_app, color: Colors.white),
            backgroundColor: Colors.deepOrange,
            onTap: () =>{
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginPage()),(Route<dynamic> route) => false)
            },
            label: 'SAIR',
            labelStyle: TextStyle(fontWeight: FontWeight.w500),
            labelBackgroundColor: Colors.deepOrangeAccent,
          ),
          SpeedDialChild(
            child: Icon(Icons.add, color: Colors.white),
            backgroundColor: Colors.green,
            onTap: () => {
              Navigator.of(context).pushNamed("/cadastroTarefas")
            },
            label: 'Nova Tarefa',
            labelStyle: TextStyle(fontWeight: FontWeight.w500),
            labelBackgroundColor: Colors.green,
          )
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de tarefas'),
      ),
      body: Tarefas(),

      floatingActionButton: buildSpeedDial(),
    );
  }
}


