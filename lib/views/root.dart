import 'package:flutter/material.dart';
import 'package:flutterapp/services/auth_firebase.dart';
import 'package:flutterapp/views/home.dart';
import 'package:flutterapp/views/login.dart';

class Root extends StatefulWidget {
  Root({Key key, this.authFirebase}): super(key: key);
  final AuthFirebase authFirebase;
  @override
  _RootState createState() => _RootState();
  
}

class _RootState extends State<Root> {
  AuthStatus authStatus = AuthStatus.notSignIn;

  @override
  void initState() {
    widget.authFirebase.currentUser().then((userId) {
      setState(() {
        authStatus = userId != null ? AuthStatus.signIn : AuthStatus.notSignIn;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignIn:
        return Login(title: 'Login', authFirebase: widget.authFirebase, onSignIn: () => updateAuthStatus(AuthStatus.signIn));
        break;
      case AuthStatus.signIn:
        return Home(onSignIn: () => updateAuthStatus(AuthStatus.notSignIn), authFirebase: widget.authFirebase);
        break;
      default:
        return Login(title: 'Login', authFirebase: widget.authFirebase, onSignIn: () => updateAuthStatus(AuthStatus.signIn));
    }
  }

  void updateAuthStatus(AuthStatus auth) {
    setState(() => authStatus = auth);
  }
  
}

enum AuthStatus {
  signIn,
  notSignIn
}