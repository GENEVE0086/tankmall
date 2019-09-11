import 'dart:async';
import 'database_helper.dart';
import '../model/user.dart';

class RestData {
  //NetworkUtil _netUtil = new NetworkUtil();
  static final baseURL = "";
  static final loginURL = baseURL + "/";

  Future<User> login(String username, String password) async {
    String flaglogado = "logado";
    // 在这里，我们将通过在本地bd上进行选择来模拟与internet的连接，以查看用户是否已经注册

    var user = new User(null, username, password, null);
    var db = new DatabaseHelper();
    var userRetorno = new User(null, null, null, null);
    userRetorno = await db.selectUser(user);
    
    if (userRetorno != null) {
      flaglogado = "existente";
      return new Future.value(new User(null, username, password, flaglogado));
    }
    else {
      flaglogado = "nao";
      return new Future.value(new User(null, username, password, flaglogado));
    }
  }

Future<User> search(String name, String username) async {
    String flaglogado = "logado";
    // 在这里，我们将通过在本地bd上进行选择来模拟与internet的连接，以查看用户是否已经注册

    var user = new User(name, username, null, null);
    var db = new DatabaseHelper();
    var userRetorno = new User(null, null, null, null);
    userRetorno = await db.searchUser(user);
    
    if (userRetorno != null) {
      flaglogado = "existente";
      return new Future.value(new User(name, username, null, flaglogado));
    }
    else {
      flaglogado = "nao";
      return new Future.value(new User(name, username, null, flaglogado));
    }
  }

}

