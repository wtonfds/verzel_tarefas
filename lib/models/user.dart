class User {
  int _id;
  String _nome;
  String _email;
  String _senha;
  String _dataNascimento;
  String _CPF;
  String _CEP;
  String _endereco;
  String _numero;
  String _flaglogged;



  User(this._id, this._nome, this._email, this._senha, this._dataNascimento, this._CPF, this._CEP, this._endereco, this._numero, this._flaglogged);

  User.map(dynamic obj) {
    this._id = obj['id'];
    this._nome = obj['nome'];
    this._email = obj['email'];
    this._senha = obj['senha'];
    this._dataNascimento = obj['dataNascimento'];
    this._CEP = obj['cep'];
    this._CPF = obj['cpf'];
    this._endereco = obj['endereco'];
    this._numero = obj['numero'];
    this._flaglogged = obj['password'];
  }

  int get id => id;
  String get nome => _nome;
  String get email => _email;
  String get senha => _senha;
  String get dataNascimento => _dataNascimento;
  String get CPF => _CPF;
  String get CEP => _CEP;
  String get endereco => _endereco;
  String get numero => _numero;
  String get flaglogged => _flaglogged;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = _id;
    map["nome"] = _nome;
    map["email"] = _email;
    map["senha"] = _senha;
    map["dataNascimento"] = _dataNascimento;
    map["CPF"] = _CPF;
    map["CEP"] = _CEP;
    map["endereco"] = _endereco;
    map["numero"] = _numero;
    map["flaglogged"] = _flaglogged;
    return map;
  }
}
