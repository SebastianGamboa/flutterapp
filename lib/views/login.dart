import 'package:flutter/material.dart';
import 'package:flutterapp/services/auth_firebase.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title, this.authFirebase, this.onSignIn}): super(key: key);
  final String title;
  final AuthFirebase authFirebase;
  final VoidCallback onSignIn;
  @override
  _LoginState createState() => _LoginState();
}

enum FormType {
  login,
  register
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  FormType formType = FormType.login;
  var email = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.teal[300],
                  Colors.teal[400],
                  Colors.teal,
                  Colors.teal[600]
                ],
                stops: [0.1, 0.4, 0.7, 0.9]
              )
            ),
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 120.0
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Label Assistant',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 50.0),
                  Column(
                    children: <Widget>[
                      _themeColor(_buildEmailInput()),
                      SizedBox(height: 30.0),
                      _themeColor(_buildPasswordInput()),
                    ]
                  ),
                  SizedBox(height: 40.0),
                  Container(
                    width: double.infinity,
                    child: customButton(changeTextSubmitButton(), onSubmit)
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    width: double.infinity,
                    child: customFlatButton(changeLoginText())
                  )
                ],
              ),
            )
          )
        ],
      ),


      // body: Container(
      //   child: Form(
      //     key: formKey,
      //     child: Column(children: formLogin())
      //   )
      // ),
    );
  }

  Theme _themeColor(Widget child) {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: Colors.white, hintColor: Colors.white),
      child: child
    );
  }

  Widget _buildEmailInput() {
    return TextFormField(
      controller: email,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.teal,
        border: InputBorder.none,
        labelText: 'Email',
        prefixIcon: Icon(Icons.email, color: Colors.white)
      ),
      autocorrect: false,
      autofocus: false,
    );
  }

  Widget _buildPasswordInput() {
    return TextFormField(
      controller: password,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.teal,
        border: InputBorder.none,
        labelText: 'Password',
        prefixIcon: Icon(Icons.lock, color: Colors.white)
      ),
      autocorrect: false,
      autofocus: false,
      obscureText: true,
    );
  }

  // List<Widget> formLogin() {
  //   return [
  //     padded(
  //       child: TextFormField(
  //         controller: email,
  //         decoration: InputDecoration(
  //           border: OutlineInputBorder(),
  //           labelText: 'Username'
  //         ),
  //         autocorrect: false,
  //     )),
  //     padded(
  //       child: TextFormField(
  //         controller: password,
  //         decoration: InputDecoration(
  //           border: OutlineInputBorder(),
  //           labelText: 'Password'
  //         ),
  //         autocorrect: false,
  //         obscureText: true,
  //     )),
  //     Column(
  //       mainAxisSize: MainAxisSize.max,
  //       children: buttonWidgets(),
  //     )
  //   ];
  // }

  String changeTextSubmitButton() {
    return formType == FormType.login ? 'Login' : 'Register';
  }

  String changeLoginText() {
    return formType == FormType.login ? 'Sign up with email' : 'Sign in';
  }

  Widget customFlatButton(String text) {
    return FlatButton(
      child: Text(text),
      textColor: Colors.white,
      onPressed: () => resetForm(formType == FormType.login ? FormType.login : FormType.register)
    );
  }

  // List<Widget> buttonWidgets() {
  //   switch (formType) {
  //     case FormType.login:
  //       return [
  //         customButton('Login', onSubmit),
  //         FlatButton(
  //           child: Text('¿No tienes cuenta?, regístrate.'),
  //           onPressed: () => resetForm(FormType.register),
  //         )
  //       ];
  //       break;

  //     case FormType.register:
  //       return [
  //         customButton('Register', onSubmit),
  //         FlatButton(
  //           child: Text('Ingresar'),
  //           onPressed: () => resetForm(FormType.login),
  //         )
  //       ];
  //       break;
  //     default:
  //       return [];
  //   }
  // }

  void resetForm(FormType form) {
    formKey.currentState.reset();
    setState(() => formType = form);
  }

  void onSubmit() {
    formType == FormType.login ?
      widget.authFirebase.signIn(email.text, password.text) :
      widget.authFirebase.createUser(email.text, password.text);
    widget.onSignIn();
  }

  Widget customButton(String text, VoidCallback onPressed) {
    return RaisedButton(
      elevation: 2.0,
      onPressed: onPressed,
      padding: EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0)
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2
        )
      ),
      color: Colors.black54,
    );
  }

  Widget padded({Widget child}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: child,
    );
  }
}
