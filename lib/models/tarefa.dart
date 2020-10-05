class Tarefa {
  String _emailUser;
  String _nome;
  String _dataEntrega;
  String _dataConcluir;
  bool _concluido;

  Tarefa(this._emailUser, this._nome, this._dataConcluir, this._dataEntrega, this._concluido);

  Tarefa.map(dynamic obj){
    this._emailUser = obj['emailUser'];
    this._nome = obj['nome'];
    this._dataEntrega = obj['dataEntrega'];
    this._dataConcluir = obj['dataConcluir'];
    this._concluido = obj['concluido'];
  }

  String get emailUser => _emailUser;
  String get nome => _nome;
  String get dataEntrega => _dataEntrega;
  String get dataConcluir => _dataConcluir;
  bool get concluido => _concluido;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["emailUser"] = _emailUser;
    map["nome"] = _nome;
    map["dataEntrega"] = _dataEntrega;
    map["dataConcluir"] = _dataConcluir;
    map["concluido"] = _concluido;
    return map;
  }
}