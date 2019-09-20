import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import 'chat_screen2.dart';

class LoginScreen extends StatefulWidget{
LoginScreen();
 @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
{
  String  email, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        child: Column(
          children: <Widget> [
            emailField(),
            passwordField(),
            loginButton(),
            //registerField(),
          ],
        ),
      ),

    )
    );
    
  }
   Widget emailField(){
     return Container(
      margin: EdgeInsets.only(top: 120.0),
      child: TextFormField(
       keyboardType: TextInputType.emailAddress,
       decoration: InputDecoration(
         labelText: 'Email Address',
         hintText: 'Enter a valid mail, like: jax@jungle.com',
       ),
       onChanged: (value)
       {
         email = value ;
       },

     ),
     );
   }
   Widget passwordField(){
     return Container(
       margin: EdgeInsets.only(bottom: 25.0),
       child: TextFormField(
         obscureText: true,
         decoration: InputDecoration(
         labelText: 'Password',
         hintText: 'Enter 6 chars at least', 
         labelStyle:TextStyle(color: Colors.grey, fontSize: 15.0),
         hintStyle:TextStyle(color: Colors.grey, fontSize: 15.0),
       ),
       onChanged: (value)
       {
         password = value ;
       },
     ),
     );

         
   }
  Widget loginButton(){
        return RaisedButton(
          color: Colors.purple[400],
          elevation: 5,
          //textColor: Colors.white ,
          child: Text(
            'Let`s chat!',
                style: TextStyle(
                //color: Color(0xFAF8FC),
                color: Colors.white,
              ),
            ),
          onPressed: () {
               FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
            Navigator.push(context,MaterialPageRoute(builder: (context) => ChatScreen()));
          },
       
     );
     }

  //  Widget  registerField() {
  //    return Row(
  //      children: <Widget>[
         
  //      ],
  //    );
  //  } 
  
}