import 'package:flutter/material.dart';
import './components/login/login_screen.dart';
import './components/login/second_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title: 'Login Test',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primaryColor: Colors.pinkAccent,
        cursorColor: Colors.pinkAccent,
        buttonColor: Colors.pinkAccent,
        buttonTheme: new ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
        ),
        errorColor: Colors.cyan,
      ),
      routes: <String, WidgetBuilder>{
        '/loginScreen': (BuildContext context) => new LoginScreen(),
        '/secondScreen': (BuildContext context) => new SecondScreen(),
      },
      home: new LoginScreen(),
    );
  }
}
