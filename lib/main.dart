import 'package:flutter/material.dart';
import 'package:flutterapp/services/auth_firebase.dart';
import 'package:flutterapp/views/root.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();

}

class _State extends State<MyApp> {

  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Scaffold(
        body: Root(authFirebase: AuthFirebase())
      ),
    );
  }
}