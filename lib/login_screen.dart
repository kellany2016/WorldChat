import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'auth.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({this.auth, this.signedIn});
  final BaseAuth auth;
  final VoidCallback signedIn;
  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

enum FormType { login, signup }

class LoginScreenState extends State<LoginScreen> {
  //form key is used for validation...
  final formKey = GlobalKey<FormState>();
  String email, password;
  FormType _formType = FormType.login;
  TextEditingController controller1;
  TextEditingController controller2;

  bool validation() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else
      return false;
  }

  void validateAndSubmit() async {
    if (validation()) {
      try {
        if (_formType == FormType.login) {
              await widget.auth.signInWithEmailAndPassword(email, password);
          //print('L : {$user.uid}');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ChatScreen()));
        } else {
              await widget.auth.createUserWithEmailAndPassword(email, password);
          //print('R: {$user.uid}');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ChatScreen()));
        }
        widget.signedIn();
      } catch (e) {
        print(e);
      }
    }
  }

  void moveToSignup() {
    formKey.currentState.reset();
    setState(() {
      // to reload the ui..
      _formType = FormType.signup;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      // to reload the ui..
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/earth.png',
                fit: BoxFit.contain,
                height: 32,
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Text('World Chat'),
              )
            ],
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: emailAndPasswordFields() + loginAndRegisterButtons(),
            ),
          ),
        ));
  }

  List<Widget> emailAndPasswordFields() {
    if (_formType == FormType.login) {
      return [
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          validator: (value) =>
              value.isEmpty ? 'Email address can\`t be empty' : null,
          onSaved: (value) => email = value,
          controller: controller1,
          decoration: InputDecoration(
            labelText: 'Email Address',
            hintText: 'Enter a valid mail, like: jax@jungle.com',
          ),
        ),
        TextFormField(
          obscureText: true,
          validator: (value) =>
              value.isEmpty ? 'Password can\`t be empty' : null,
          onSaved: (value) => password = value,
          controller: controller2,
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: 'Enter 6 chars at least',
            labelStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
            hintStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
          ),
        ),
      ];
    } else {
      return [
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          validator: (value) =>
              value.isEmpty ? 'Email address can\`t be empty' : null,
          onSaved: (value) => email = value,
          controller: controller1,
          decoration: InputDecoration(
            labelText: 'Email Address',
            hintText: 'Enter a valid mail, like: jax@jungle.com',
          ),
        ),
        TextFormField(
          obscureText: true,
          validator: (value) =>
              value.isEmpty ? 'Password can\`t be empty' : null,
          onSaved: (value) => password = value,
          controller: controller2,
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: 'Enter 6 chars at least',
            labelStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
            hintStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
          ),
        ),
      ];
    }
  }

  List<Widget> loginAndRegisterButtons() {
    if (_formType == FormType.login) {
      return [
        RaisedButton(
          color: Colors.purple[400],
          elevation: 5.0,
          child: Text(
            'Let`s chat!',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () => validateAndSubmit(),
        ),
        FlatButton(
          child: Text(
            'don\`t have an account? Sign up',
            style: TextStyle(fontSize: 20.0),
          ),
          onPressed: () => moveToSignup(),
        )
      ];
    } else {
      return [
        RaisedButton(
          color: Colors.purple[400],
          elevation: 5.0,
          child: Text(
            'sign up',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () => validateAndSubmit(),
        ),
        FlatButton(
          child: Text(
            'have an account? Login',
            style: TextStyle(fontSize: 20.0),
          ),
          onPressed: () => moveToLogin(),
        )
      ];
    }
  }
}
