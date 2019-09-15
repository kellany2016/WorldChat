import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'log_in_Screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'World Chat',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: LogIn(),
    );
  }
}
