import 'package:flutter/material.dart';
import 'package:verzel_project/data/database-tarefas.dart';
import 'package:verzel_project/pages/tarefa_details.dart';


class Tarefas extends StatefulWidget {
  @override
  _TarefasState createState() => _TarefasState();
}

class _TarefasState extends State<Tarefas> {
  DatabaseTarefas _query = new DatabaseTarefas();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _query.queryTarefa(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index){
                  Map wppost = snapshot.data[index];
                  if(wppost != null){
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Single_Tarefa(
                        tarefa_nome: wppost['nome'],
                        tarefa_id: wppost['id'],
                        tarefa_emailUser: wppost['emailUser'],
                        tarefa_dataEntrega: wppost['dataEntrega'],
                        tarefa_dataConcluir: wppost['dataConcluir'],
                        tarefa_concluido: wppost['concluido'],
                      ),
                    );
                  }else{
                    return CircularProgressIndicator();
                  }

                });
          }else{
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class Single_Tarefa extends StatelessWidget {
  final tarefa_id;
  final tarefa_nome;
  final tarefa_emailUser;
  final tarefa_dataEntrega;
  final tarefa_dataConcluir;
  final tarefa_concluido;

  Single_Tarefa({
    this.tarefa_id,
    this.tarefa_nome,
    this.tarefa_emailUser,
    this.tarefa_dataEntrega,
    this.tarefa_dataConcluir,
    this.tarefa_concluido
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Card(
        color: Colors.tealAccent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () =>
                Navigator.of(context).push(
                    new MaterialPageRoute(
                        builder: (context) =>
                        new TarefaDetails(
                          tarefa_detail_id : tarefa_id,
                          tarefa_detail_nome : tarefa_nome,
                          tarefa_detail_emailUser : tarefa_emailUser,
                          tarefa_detail_dataEntrega : tarefa_dataEntrega,
                          tarefa_detail_dataConcluir : tarefa_dataConcluir,
                          tarefa_detail_concluido : tarefa_concluido
                        )
                    )
                ),
            child: ListTile(
              title: new Text(tarefa_nome, style: TextStyle(fontWeight: FontWeight.bold),),
              subtitle: tarefa_concluido == 0 ?
              new Text("EM ABERTO", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),)
                  : new Text("CONCLUÍDO", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),)
            ),
          ),
        ),
      ),
    );
  }
}


