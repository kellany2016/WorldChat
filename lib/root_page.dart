import 'package:chat_app/auth.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'home_page.dart';

class RootPage extends StatefulWidget {
  final BaseAuth auth;
  RootPage({this.auth});
  @override
  State<StatefulWidget> createState() => new RootPageState();
}

enum AuthStatus { notSignedIn, signedIn }

class RootPageState extends State<RootPage> {
  AuthStatus _authStatus = AuthStatus.notSignedIn;

  initState() {
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
        _authStatus =
            userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void signedIn() {
    setState(() {
      _authStatus = AuthStatus.signedIn;
    });
  }
  void _signedout(){setState(() {
    _authStatus = AuthStatus.notSignedIn;
  });
  }

  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case AuthStatus.notSignedIn:
        return LoginScreen(auth: widget.auth, signedIn: signedIn);
      case AuthStatus.signedIn:
        return HomePage(auth: widget.auth,
        signedOut: _signedout,
        );
    }
  }
}
