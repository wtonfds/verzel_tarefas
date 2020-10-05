import 'dart:async';
import 'package:verzel_project/models/user.dart';
import 'package:verzel_project/pages/home_page.dart';

import 'database-helper.dart';

class RestData {
  static final BASE_URL = "";
  static final LOGIN_URL = BASE_URL + "/";

  Future<User> login( String email, String senha) async {
    String flagLogged = "logged";
    //simulate internet connection by selecting the local database to check if user has already been registered
    var user = new User(null, null, email, senha, null, null, null, null, null, null);
    var db = new DatabaseHelper();
    var userRetorno = new User(null, null, null, null, null, null, null, null, null, null);
    userRetorno = await db.selectUser(user);
    if(userRetorno != null){
      storage.setItem("emailUser", email);
      flagLogged = "logged";
      return new Future.value(new User(null, null, email, senha, null, null, null, null, null, flagLogged));
    }else {
      flagLogged = "not";
      return new Future.value(new User(null, null, email, senha, null, null, null, null, null, flagLogged));
    }
  }

  Future<User> getIdUser() async{

  }
}
