import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Login Test'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(40.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Icon(
                Icons.sentiment_very_satisfied,
                color: Colors.pinkAccent,
                size: 200.0,
              ),
              new Text('Hello', style: new TextStyle(fontSize: 45.0, fontWeight: FontWeight.w100),),
            ],
          ),
        ),
      ),
    );
  }
}
