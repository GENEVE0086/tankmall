import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/user.dart';

import '../index_page.dart';
import 'search_presenter.dart';

//import 'package:gradient_app_bar/gradient_app_bar.dart';
class ForgetPage extends StatefulWidget {
  ForgetPage({Key key}) : super(key: key);
  @override
  _ForgetPageState createState() => new _ForgetPageState();
}

class _ForgetPageState extends State<ForgetPage> implements SearchPageContract {
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

  String title = "找回密码";
  String _name, _username;

  SearchPagePresenter _presenter;

  _SearchPageState() {
    _presenter = new SearchPagePresenter(this);
  }

/*   void _register() {
     Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new RegisterPage()));
  } */

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        print("Entro 01");
        _presenter.doLogin(_name, _username);
      });
    } else {
      print('Opssssssssssssssssssssssssssssssssssssssssssssssssssssss!!!!');
    }
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
              color: Colors.blue,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(30)),
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 60.0),

          child: new Text(
            '查询密码',
            style: new TextStyle(color: Colors.white),
          ),

          // 设置按钮圆角
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return AlertDialog(
                title: new Text("用户信息"),
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
        });

    final logo = new Hero(
      tag: 'hero',
      child: new CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
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
                  onSaved: (val) => _name = val,
                  decoration: new InputDecoration(
                    labelText: "用户名",
                    prefixIcon: Icon(Icons.account_box),
                  ),
                  validator: (val) {
                    if (val.isEmpty) {
                      return '用户名不得为空!';
                    }
                  },
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(20.0),
                child: new TextFormField(
                  //obscureText: true,
                  autovalidate: validate,
                  onSaved: (val) => _username = val,
                  //obscureText: _isClickEye,
                  decoration: new InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: "账号",

                   
                  ),
                  validator: (val) {
                    if (val.isEmpty) {
                      return '账号不得为空!';
                    }
                  },
                ),
              ),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: const EdgeInsets.all(10.0), child: loginBtn),
               
                ],
              )
            ],
          ),
        ),
      ],
    );

    return new Scaffold(
      /*  appBar: PreferredSize(
        child: GradientAppBar(
          title: Text(title),
          titleSpacing: 50,
          backgroundColorStart: Color(0xFF91DBE5),
          backgroundColorEnd: Color(0xFF84E5C5),
        ),
       
        preferredSize: Size.fromHeight(50),
      ), key: scaffoldKey, */
      appBar: new AppBar(
        title: new Text("找回密码"),
        backgroundColor: Colors.blue,
      ),
      key: scaffoldKey,
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 0, right: 0),
          child: Container(
            decoration: new BoxDecoration(
              color: Colors.white
            ),
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
