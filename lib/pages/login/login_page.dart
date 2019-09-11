import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'forget_page.dart';

import '../../model/user.dart';
import 'login_presenter.dart';
import 'register.dart';

import '../index_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginPageContract {
  BuildContext _ctx;
  PageController _pageController;
  bool _isLoading = false;
  Color _eyeColor;
  bool _isClickEye = false;
  bool validate = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Color left = Colors.black;
  Color right = Colors.white;

  String title = "登录";
  String _username, _password;

  LoginPagePresenter _presenter;

  _LoginPageState() {
    _presenter = new LoginPagePresenter(this);
  }

  void _register() {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new RegisterPage()));
  }

  void _submit() {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new IndexPage()));
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var loginBtn = new FlatButton(
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.white,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(30)),
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 60.0),

          child: new Text(
            '登录',
            style: new TextStyle(color: Colors.white),
          ),

          // 设置按钮圆角
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        onPressed: _submit);

    final forgetLabel = new FlatButton(
      onPressed: () {
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new ForgetPage()));
      },
      child: new Text(
        '忘记密码?',
        style: new TextStyle(color: Colors.blue),
      ),
    );
    final signInLabel = new FlatButton(
      // padding: const EdgeInsets.all(10.0),
      onPressed: _register,
      //child: new Text("注册"),
      child: new Text(
        '快速注册',
        style: new TextStyle(color: Colors.blue),
      ),
      //color: Colors.green,
    );
    final logo = new Hero(
      tag: 'hero',
      child: new CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
      ),
    );

    Widget bottomArea = new Container(
      margin: EdgeInsets.only(right: 20, left: 30),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          forgetLabel,
          signInLabel,
        ],
      ),
    );
    var loginForm = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        /* new Text(
          "登录",
          textScaleFactor: 2.0,
        ), */
        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              logo,
              new Padding(
                padding: const EdgeInsets.all(20.0),
                child: new TextFormField(
                  onSaved: (val) => _username = val,
                  decoration: new InputDecoration(
                    labelText: "账号",
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (val) {
                    if (val.isEmpty) {
                      return '账号不得为空!';
                    }
                  },
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(20.0),
                child: new TextFormField(
                  //obscureText: true,
                  autovalidate: validate,
                  onSaved: (val) => _password = val,
                  obscureText: _isClickEye,
                  decoration: new InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: "密码",
                    suffixIcon: IconButton(
                        icon: Icon(Icons.remove_red_eye, color: _eyeColor),
                        onPressed: () {
                          setState(() {
                            _isClickEye = !_isClickEye;
                            _eyeColor = _isClickEye ? Colors.grey : Colors.blue;
                          });
                        }),
                  ),
                  validator: (val) {
                    if (val.isEmpty) {
                      return '密码不得为空!';
                    }
                  },
                ),
              ),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: const EdgeInsets.all(10.0), child: loginBtn),
                  bottomArea
                ],
              )
            ],
          ),
        ),
      ],
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("登录"),
        backgroundColor: Colors.blue,
      ),
      key: scaffoldKey,
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 0, right: 0),
          child: Container(
            decoration: new BoxDecoration(color: Colors.white),
            child: Column(
                mainAxisSize: MainAxisSize.max, children: <Widget>[loginForm]),
          ),
        ),
      ),
      resizeToAvoidBottomPadding: false, //输入框抵住键盘
    );
  }

  @override
  void onLoginError(String error) {
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
    print("密码错误");
  }

  @override
  void onLoginSuccess(User user) async {
    print("进入onLoginSuccess!");

    _showSnackBar(user.toString());
    setState(() {
      _isLoading = false;
    });
    if (user.flaglogado == "existente") {
      print("existente");
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new IndexPage()));
    } else {
      print("Nao existente");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("错误的用户或密码"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("关闭"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
