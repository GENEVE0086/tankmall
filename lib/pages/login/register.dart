import 'package:flutter/material.dart';
import '../../data/database_helper.dart';
import '../../model/user.dart';
import 'login_page.dart';

// import 'package:gradient_app_bar/gradient_app_bar.dart';
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  BuildContext _ctx;
  bool _isLoading = false;
  Color _eyeColor;
  bool _isClickEye = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _name, _username, _password;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
            '注册',
            style: new TextStyle(color: Colors.white),
          ),

          // 设置按钮圆角
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        onPressed: _submit);
    final logo = new Hero(
      tag: 'hero',
      child: new CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
      ),
    );
    //body:new SingleChildScrollView(
    var loginForm = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        /* new Text(
          "注册",
          textScaleFactor: 2.0,
        ), */
        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              logo,
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _name = val,
                  decoration: new InputDecoration(
                      labelText: "用户名", prefixIcon: Icon(Icons.account_box)),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _username = val,
                  decoration: new InputDecoration(
                    labelText: "账号",
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  //obscureText: true,
                  obscureText: _isClickEye,
                  onSaved: (val) => _password = val,
                  decoration: new InputDecoration(
                      labelText: "密码",
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                          icon: Icon(Icons.remove_red_eye, color: _eyeColor),
                          onPressed: () {
                            setState(() {
                              _isClickEye = !_isClickEye;
                              _eyeColor =
                                  _isClickEye ? Colors.grey : Colors.blue;
                            });
                          })),
                ),
              ),
            ],
          ),
        ),
        loginBtn
      ],
    );

    return new Scaffold(
   
      appBar: new AppBar(
        title: new Text("注册"),
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

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        var user = new User(_name, _username, _password, null);
        var db = new DatabaseHelper();
        db.saveUser(user);
        _isLoading = false;
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new LoginPage()));
      });
    }
  }
}
