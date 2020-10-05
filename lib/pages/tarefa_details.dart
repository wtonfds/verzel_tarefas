import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:verzel_project/data/database-tarefas.dart';
import 'package:date_format/date_format.dart';

import 'edite_tarefa_page.dart';


class TarefaDetails extends StatefulWidget {
  final tarefa_detail_id;
  final tarefa_detail_nome;
  final tarefa_detail_emailUser;
  final tarefa_detail_dataEntrega;
  final tarefa_detail_dataConcluir;
  final tarefa_detail_concluido;

  TarefaDetails({
    this.tarefa_detail_id,
    this.tarefa_detail_nome,
    this.tarefa_detail_emailUser,
    this.tarefa_detail_dataEntrega,
    this.tarefa_detail_dataConcluir,
    this.tarefa_detail_concluido
  });

  @override
  _TarefaDetailsState createState() => _TarefaDetailsState();
}

class _TarefaDetailsState extends State<TarefaDetails> {
  var dataNow = formatDate(DateTime.now(), [dd, '/',mm, '/', yyyy]);
  bool _desableButton = false;

  @override
  Widget build(BuildContext context) {
    if(widget.tarefa_detail_concluido == 1){
      _desableButton = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tarefa_detail_nome,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.0
          ),
        ),
      ),
      body: new ListView(
        children: <Widget> [
          SizedBox(
            height: 20,
          ),
          new Container(
            child: Center(
              child: new Container(
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Flexible(child: Text("Tarefa:   ", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.left,)),
                    Flexible(child: Text(widget.tarefa_detail_nome, style: TextStyle(fontSize: 30), textAlign: TextAlign.left,)),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          new Container(
            child: Center(
              child: new Container(
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Flexible(child: Text("Entrega:   ", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.left,)),
                    Flexible(child: Text(widget.tarefa_detail_dataEntrega, style: TextStyle(fontSize: 30), textAlign: TextAlign.left,)),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          new Container(
            child: Center(
              child: new Container(
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Flexible(child: Text("Conclusão:   ", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.left,)),
                    Flexible(child: widget.tarefa_detail_dataConcluir == '' ?
                    Text( "Nao Concluida", style: TextStyle(fontSize: 30, color: Colors.red), textAlign: TextAlign.left,)
                        : Text( widget.tarefa_detail_dataConcluir, style: TextStyle(fontSize: 30), textAlign: TextAlign.left,)),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          new Container(
            child: Center(
              child: new Container(
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Flexible(child: Text("Status:   ", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.left,)),
                    Flexible(child: widget.tarefa_detail_concluido == 0 ?
                    Text( "Em Aberto", style: TextStyle(fontSize: 30, color: Colors.red), textAlign: TextAlign.left,)
                        : Text( "Concluida", style: TextStyle(fontSize: 30, color: Colors.green), textAlign: TextAlign.left,))
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          new Container(
            child: Row(
              children: <Widget>[
                Text("    "),
                RaisedButton(
                  child: Text("CONCLUIR", style: TextStyle(fontSize: 20),),
                   onPressed: _desableButton == true ? null : (){
                     showDialog(
                       context: context,
                       builder: (BuildContext context) {
                         return AlertDialog(
                           title: new Text("Concluindo Tarefa"),
                           content: new Text("Tem certeza que deseja concluir essa Tarefa?"),
                           actions: <Widget>[
                             Container(
                               child: new FlatButton(
                                 child: new Text("Sim"),
                                 onPressed: () {
                                   DatabaseTarefas().concluirTarefa(widget.tarefa_detail_id, 1, dataNow);
                                   Navigator.of(context).pushNamed("/home");
                                 },
                               ),
                             ),
                             Container(
                               child: new FlatButton(
                                 child: new Text("Não"),
                                 onPressed: () {
                                   Navigator.of(context).pop();
                                 },
                               ),
                             ),
                           ],
                         );
                       },
                     );
                    },
                  color: Colors.greenAccent,
                ),
                Text("      "),
                RaisedButton(
                  child: Text("EDITAR", style: TextStyle(fontSize: 20),),
                  onPressed:(){
                    Navigator.of(context).push(
                        new MaterialPageRoute(
                            builder: (context) =>
                            new TarefaUpdate(
                              tarefa_update_id : widget.tarefa_detail_id,
                              tarefa_update_nome: widget.tarefa_detail_nome,
                              tarefa_update_dataEntrega: widget.tarefa_detail_dataEntrega,
                            )
                        )
                    );
                  },
                  color: Colors.greenAccent,
                ),
                Text("      "),
                RaisedButton(
                  child: Text("EXCLUIR", style: TextStyle(fontSize: 20),),
                  onPressed: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: new Text("Excluindo Tarefa"),
                          content: new Text("Tem certeza que deseja excluir essa Tarefa?"),
                          actions: <Widget>[
                            Container(
                              child: new FlatButton(
                                child: new Text("Sim"),
                                onPressed: () {
                                  DatabaseTarefas().deleteTarefa(widget.tarefa_detail_id);
                                  Navigator.of(context).pushNamed("/home");
                                },
                              ),
                            ),
                            Container(
                              child: new FlatButton(
                                child: new Text("Não"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    );
                    },
                  color: Colors.redAccent,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

