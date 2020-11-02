import 'package:flutter/material.dart';
import 'package:flutterapp/services/auth_firebase.dart';

class Home extends StatelessWidget {
  Home({this.onSignIn, this.authFirebase});

  final VoidCallback onSignIn;
  final AuthFirebase authFirebase;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          FlatButton(onPressed: signOut, child: Text('Sign out'))
        ],
      ),
    );
  }

  void signOut() {
    authFirebase.signOut();
    onSignIn();
  }
  
}