import 'package:chat_app/auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
      HomePage({this.auth,this.signedOut});
  final BaseAuth auth;
  final VoidCallback signedOut;
  void _signOut()async{
    try{
      await auth.signOut();
      signedOut();
    }
    catch(e){print(e);}
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
          actions: <Widget>[
            FlatButton(
              child: Text('sign out', style: TextStyle(fontSize: 20.0, color: Colors.white)),
              onPressed: ()=> _signOut
            ),
          ],
        ),
      body: SafeArea(
        child: Text('FriendList will be added here.'),
      ),
    );
  }
}
