import 'package:flutter/material.dart';
import './../models/login_model.dart';

class SecondScreen extends StatefulWidget {
  //declare a field that holds the Response
  final ResponseBody response;

  //in the constructor, require a Response
  SecondScreen({Key key, @required this.response}) : super(key: key);

  //route to second screen
  static String route = '/secondScreen';

  //@override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {

  //style local variables declarated
  var usernameStyle = new TextStyle(color: Colors.black, fontSize: 40.0, fontWeight: FontWeight.w100,);
  var textStyle = new TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w100,);
  var boldTextStyle = new TextStyle(fontWeight: FontWeight.w300,);

  //icon builder
  Widget iconBuilder() {
    return new Icon(
      Icons.sentiment_very_satisfied,
      color: Colors.pinkAccent,
      size: 200.0,
    );
  }

  //username builder
  Widget usernameTextBuilder() {
    return new Container(
      padding: new EdgeInsets.only(bottom: 12.0,),
      child: new RichText(
        text: new TextSpan(
          text: 'Hello, ',
          style: usernameStyle,
          children: <TextSpan>[
            new TextSpan(
              text: '${widget.response.username}',
              style: boldTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  //text builder
  Widget textBuilder(IconData icon, String firstText, String secondText) {
    return Container(
      padding: new EdgeInsets.only(bottom: 8.0,),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            margin: new EdgeInsets.only(right: 5.0),
            child: new Icon(
              icon,
              color: Colors.pinkAccent,
              size: 20.0,
            ),
          ),
          new RichText(
            text: new TextSpan(
              text: firstText,
              style: textStyle,
              children: <TextSpan>[
                new TextSpan(
                  text: secondText,
                  style: boldTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
              iconBuilder(),
              usernameTextBuilder(),
              //widget is the current configuration. A State object's configuration
              //is the corresponding StatefulWidget instance.
              textBuilder(Icons.email, 'Your Email is: ', '${widget.response.email}'),
              textBuilder(Icons.lock, 'Your Password is: ', '${widget.response.password}'),
              textBuilder(Icons.vpn_key, 'Your Access Token is: ', '${widget.response.accessToken}'),
            ],
          ),
        ),
      ),
    );
  }
}
