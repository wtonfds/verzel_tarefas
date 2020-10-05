import 'package:flutter/material.dart';
import 'package:verzel_project/data/database-tarefas.dart';
import 'package:verzel_project/models/tarefa.dart';

class TarefaUpdate extends StatefulWidget {
  final tarefa_update_id;
  final tarefa_update_nome;
  final tarefa_update_dataEntrega;

  TarefaUpdate({
    this.tarefa_update_id,
    this.tarefa_update_nome,
    this.tarefa_update_dataEntrega
  });

  @override
  _TarefaUpdateState createState() => _TarefaUpdateState();
}

class _TarefaUpdateState extends State<TarefaUpdate> {
  final formKey = new GlobalKey<FormState>();
  String _nome, _dataEntrega;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tarefa_update_nome,
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
          new Form(
            key: formKey,
            child: new Column(
             children: <Widget>[
               new Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: new TextFormField(
                   onSaved: (val) => _nome = val,
                   decoration: new InputDecoration(
                       labelText: widget.tarefa_update_nome,
                       hintText: "Nome da Tarefa"
                   ),
                 ),
               ),
               new Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: new TextFormField(
                   onSaved: (val) =>  _dataEntrega = val,
                   decoration: new InputDecoration(
                       labelText: widget.tarefa_update_dataEntrega,
                       hintText: "Data de Entrega"
                   ),
                 ),
               )
             ],
            ),
          ),
          SizedBox(
            height: 100,
          ),
          new Container(
            child: Row(
              children: <Widget>[
                Text("      "),
                RaisedButton(
                  child: Text("SALVAR", style: TextStyle(fontSize: 20),),
                  onPressed: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: new Text("Alterações realizadas"),
                          content: new Text("Tem certeza que deseja alterar essa Tarefa?"),
                          actions: <Widget>[
                            Container(
                              child: new FlatButton(
                                child: new Text("Sim"),
                                onPressed: () {
                                  _submit();
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

  void _submit(){
    final form = formKey.currentState;
    if (form.validate()) {
      setState(() {
        form.save();
        var db = new DatabaseTarefas();
        if(_nome.isEmpty){
          _nome = widget.tarefa_update_nome;
        }
        if(_dataEntrega.isEmpty){
          _dataEntrega = widget.tarefa_update_dataEntrega;
        }
        db.updateTarefa(widget.tarefa_update_id, _nome, _dataEntrega);
        Navigator.of(context).pushNamed("/home");
      });
    }
  }
}


