import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import 'chat_screen2.dart';

String screenName='Log in', email , password;
bool isRegister=false;
bool isAlaa=true;
final Firestore _firestore= Firestore.instance;
final _firebaseAuth = FirebaseAuth.instance;
class LogIn extends StatefulWidget {
  LogIn();
  @override
  State<StatefulWidget> createState() => LogInState();

static const String id='Log_In_Screen';

}

class LogInState  extends State<LogIn>{
  //bool isRegister=false;
  @override
  Widget build(BuildContext context) {
    return myScreen();
  }
  Widget myScreen (){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Text(
                          screenName,
                          style: TextStyle(
                            fontSize: 60,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold)
                            ,)
                            ),
              const SizedBox(height: 30),
              Padding(
              padding: const EdgeInsets.all(7.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.purple,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  //Email TextField
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                       enabledBorder: UnderlineInputBorder(      
                      borderSide: BorderSide(color: Colors.transparent),   
                      ), 
                      labelText: 'Email Adress... ',
                      hintText: "jax@jungle.com",
                      labelStyle: TextStyle(color: Colors.blueGrey),                    
                    hintStyle: TextStyle(color: Colors.blueGrey)),
                    onChanged: (value)
                    {
                      email = value;
                
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),  color: Colors.purple,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  //password text field..
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(      
                      borderSide: BorderSide(color: Colors.transparent),   
                      ),
                      hintText: '  Password... ',
                      hintStyle: TextStyle(
                      color: Colors.blueGrey)
                      ),
                      onChanged: (value)
                    {
                      password = value;
                    },
                  ),
                ),
              ),
            ),
            !isRegister ? InkWell( onTap: (){ setState(() {
            
              isRegister=true; screenName='Sign up';
            }
            );
           },
           child: Text("I Don't have an account\n"
           , style: TextStyle(
             wordSpacing: 5.0,
             fontSize: 40,
             fontStyle: FontStyle.italic,
             color: Colors.grey[700]
             ),
           ),
          )

           : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),  color: Colors.purple,),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  //confirmation password TextField..
                  child: TextField(
                    decoration: InputDecoration(hintText: 'Password... ',hintStyle: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ) ,

            Center(
              //submit Button..
      child: RaisedButton(
      elevation: 5,
      textColor:Colors.greenAccent ,
      color: Colors.purple[600],
      child: Text('Let`s chat with the world!',
      style: TextStyle(
      fontSize: 20.0,
      fontWeight:FontWeight.bold,
      ),
      ),
       onPressed: () async {
           if( _firebaseAuth.fetchSignInMethodsForEmail(email: email)!= null){
           await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
            Navigator.push(context,MaterialPageRoute(builder: (context) => ChatScreen()));
           }
           else _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      },
  ),
    ),
          ],
        ),
      ),
    );
  }
}