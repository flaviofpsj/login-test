import 'package:flutter/material.dart';
import 'package:http/http.dart'; //to use http request
import 'dart:convert'; //to use json
import './../../mixins/validation.dart';
import './../models/login_model.dart';
import './second_screen.dart';

class LoginScreen extends StatefulWidget {

  //route to login screen
  static String route = '/loginScreen';

  //@override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Validation {

  //key created to validate input
  final formKey = GlobalKey<FormState>();

  //initial strings to contain the collected values
  String username = ''; //expected: five letters or more
  String email = ''; //expected: @
  String password = ''; //expected: five digits or more
  String token = ''; //token validator

  //password visibility
  bool obscurePassword = true;

  //node created to request focus from the next form
  FocusNode emailFocusNode = new FocusNode();
  FocusNode passwordFocusNode = new FocusNode();

  //api url's
  final String loginUrl = 'https://reqres.in/api/login';
  final String registerUrl = 'https://reqres.in/api/register';

  //form builder
  Widget formBuilder(
    TextInputType keyboardType,
    Function onSaved,
    Function validator,
    String labelText,
    bool obscureText,
    {Function onFieldSubmitted, FocusNode focusNode, Widget suffixIcon}) {
    return new Container(
      margin: new EdgeInsets.only(bottom: 20.0),
      child: new TextFormField(
        keyboardType: keyboardType,
        obscureText: obscureText,
        onSaved: onSaved,
        validator: validator,
        decoration: new InputDecoration(
          labelText: labelText,
          filled: true,
          border: InputBorder.none,
          suffixIcon: suffixIcon,
        ),
        onFieldSubmitted: onFieldSubmitted,
        focusNode: focusNode,
      ),
    );
  }

  //login post callback
  void loginPostData(BuildContext context) async {
    //post body
    dynamic bodyToSend = {'email': email, 'password': password};
    dynamic headers = {'Content-Type': 'application/json'};
    var body = json.encode(bodyToSend);
    print(body);
    //request
    var response = await post(loginUrl, body: body, headers: headers);
    var state = json.decode(response.body);
    //token
    var givenToken = state['token'];
    token = givenToken;
    print(token);
    if(response.statusCode == 200) {
      //Navigator.of(context).pushNamed('/secondScreen');
      var route = new MaterialPageRoute(
        builder: (BuildContext context) =>
          new SecondScreen(
            response: ResponseBody(
              username: this.username,
              email: this.email,
              password: this.password,
              accessToken: this.token,
            ),
          ),
      );
      Navigator.of(context).push(route);
    } else {
      //error message
      var error = state['error'];
      final snackBar = SnackBar(
        content: Text('E-mail ou senha incorretos'),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {},
        ),
      );
      Scaffold.of(context).showSnackBar(snackBar);
      print(error.toString());
    }
  }

  //register post callback
  void registerPostData(BuildContext context) async {
    //post body
    dynamic bodyToSend = {'email': email, 'password': password};
    dynamic headers = {'Content-Type': 'application/json'};
    var body = json.encode(bodyToSend);
    print(body);
    //request
    var response = await post(registerUrl, body: body, headers: headers);
    var state = json.decode(response.body);
    //token
    var givenToken = state['token'];
    token = givenToken;
    print(token);
    if(response.statusCode == 201) {
      //Navigator.of(context).pushNamed('/secondScreen');
      var route = new MaterialPageRoute(
        builder: (BuildContext context) =>
          new SecondScreen(
            response: ResponseBody(
              username: this.username,
              email: this.email,
              password: this.password,
              accessToken: this.token,
            ),
          ),
      );
      Navigator.of(context).push(route);
    } else {
      //error message
      var error = state['error'];
      final snackBar = SnackBar(
        content: Text('E-mail ou senha inválidos'),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {},
        ),
      );
      Scaffold.of(context).showSnackBar(snackBar);
      print(error.toString());
    }
  }

  //function to show or hide password
  void toggleObscure() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new Text('Login Test'),
      ),
      //listview created to not give overflow error when the keyboard appears
      body: new ListView(
        padding: new EdgeInsets.all(40.0),
        children: <Widget>[
          new Builder(
            builder: (BuildContext context) {
              return new GestureDetector(
                onTap: () {
                  //node created to request focus from the screen
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                //manages the entire form
                child: new Form(
                  key: formKey,
                  child: new Column(
                    children: <Widget>[
                      //username form
                      formBuilder(
                        TextInputType.text,
                        (String value) {
                          username = value;
                        },
                        //referencing function for validation
                        validateUsername,
                        'Username',
                        false,
                        //change focus to email form
                        onFieldSubmitted: (String value) {
                          FocusScope.of(context).requestFocus(emailFocusNode);
                        },
                      ),
                      //email form
                      formBuilder(
                        TextInputType.emailAddress,
                        (String value) {
                          email = value;
                        },
                        //referencing function for validation
                        validateEmail,
                        'Email',
                        false,
                        //referencing email focus
                        focusNode: emailFocusNode,
                        //change focus to password form
                        onFieldSubmitted: (String value) {
                          FocusScope.of(context).requestFocus(passwordFocusNode);
                        },
                      ),
                      //password form
                      formBuilder(
                        TextInputType.text,
                        (String value) {
                          password = value;
                        },
                        //referencing function for validation
                        validatePassword,
                        'Password',
                        //controlled by toggleObscure function
                        obscurePassword,
                        suffixIcon: new IconButton(
                          //calls toggleObscure function to enable or disable obscureText parameter
                          onPressed: toggleObscure,
                          icon: Icon(
                            //changes the icon
                            obscurePassword ? Icons.visibility_off : Icons.visibility
                          ),
                          tooltip: obscurePassword ? 'Show' : 'Hide',
                        ),
                        //referencing password focus
                        focusNode: passwordFocusNode,
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new RaisedButton(
                            child: new Text('Login'),
                            onPressed: () {
                              //method to validate forms
                              if(formKey.currentState.validate()) {
                                //method to save forms
                                formKey.currentState.save();
                                loginPostData(context);
                              }
                            },
                          ),
                          new RaisedButton(
                            child: new Text('Register'),
                            onPressed: () {
                              //method to validate forms
                              if(formKey.currentState.validate()) {
                                //method to save forms
                                formKey.currentState.save();
                                registerPostData(context);
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
