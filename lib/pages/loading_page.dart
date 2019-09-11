import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Image(image: AssetImage("asset/loading.png"))
    );
  }

  @override
  void initState() {
    super.initState();
    countDown();
  }

  void countDown() {
    var _duration = Duration(seconds: 3);
    Future.delayed(_duration, newPage);
  }

  void newPage() {
    Navigator.of(context).pushReplacementNamed('/LoginPage');
  }
}
