import 'package:flutter/material.dart';
import './components/login/login_screen.dart';
import './components/login/second_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title: 'Login Test',
      //hide debug banner
      debugShowCheckedModeBanner: false,
      //theme of application
      theme: new ThemeData(
        primaryColor: Colors.pinkAccent,
        primarySwatch: pinkAccent,
        cursorColor: Colors.pinkAccent,
        buttonColor: Colors.pinkAccent,
        buttonTheme: new ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
        ),
        errorColor: Colors.cyan,
      ),
      routes: screenRoutes,
      home: new LoginScreen(),
    );
  }
}

//create routes
final screenRoutes = <String, WidgetBuilder>{
  //route names coming from their respective classes
  LoginScreen.route: (BuildContext context) => new LoginScreen(),
  SecondScreen.route: (BuildContext context) => new SecondScreen(response: null,),
};

//create material color to assign to primarySwatch
const MaterialColor pinkAccent = const MaterialColor(
  0xFFFF4081,
  const <int, Color>{
    50: const Color(0xFFFF4081),
    100: const Color(0xFFFF4081),
    200: const Color(0xFFFF4081),
    300: const Color(0xFFFF4081),
    400: const Color(0xFFFF4081),
    500: const Color(0xFFFF4081),
    600: const Color(0xFFFF4081),
    700: const Color(0xFFFF4081),
    800: const Color(0xFFFF4081),
    900: const Color(0xFFFF4081),
  }
);
