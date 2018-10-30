import 'package:flutter/material.dart';
import 'package:http/http.dart'; //to use http request
import 'dart:convert'; //to use json
import './../../mixins/validation.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Validation {

  //key created to validate input
  final formKey = GlobalKey<FormState>();

  //initial strings to contain the collected values
  String email = ''; //expected: @
  String password = ''; //expected: five digits or more
  String token = ''; //token validator

  //password visibility
  bool obscurePassword = true;

  //node created to request focus from the next form
  FocusNode secondFocusNode = new FocusNode();

  //api url's
  final String loginUrl = 'https://reqres.in/api/login';
  final String registerUrl = 'https://reqres.in/api/register';

  //form builder
  Widget formBuilder(
    TextInputType keyboardType,
    Function onSaved,
    Function validator,
    String labelText,
    {bool obscureText, Function onFieldSubmitted, FocusNode focusNode, Widget suffixIcon}) {
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
  void loginPostData() async {
    //post body
    dynamic body = {'email': email, 'password': password};
    print(body);
    //request
    var response = await post(loginUrl, body: body);
    var state = json.decode(response.body);
    //token
    var givenToken = state['token'];
    token = givenToken;
    print(token);
    if(response.statusCode == 200) {
      Navigator.of(context).pushNamed('/secondScreen');
    } else {
      //error message
      var error = state['error'];
      print(error.toString());
    }
  }

  //register post callback
  void registerPostData() async {
    //post body
    dynamic body = {'email': email, 'password': password};
    print(body);
    //request
    var response = await post(registerUrl, body: body);
    var state = json.decode(response.body);
    //token
    var givenToken = state['token'];
    token = givenToken;
    print(token);
    if(response.statusCode == 201) {
      Navigator.of(context).pushNamed('/secondScreen');
    } else {
      //error message
      var error = state['error'];
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
      appBar: new AppBar(
        title: new Text('Login Test'),
      ),
      body: new GestureDetector(
        onTap: () {
          //node created to request focus from the screen
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: new Container(
          color: Colors.white,
          padding: new EdgeInsets.all(40.0),
          child: new Center(
            child: new Form(
              key: formKey,
              child: new Column(
                children: <Widget>[
                  //email form
                  formBuilder(
                    TextInputType.emailAddress,
                    (String value) {
                      email = value;
                    },
                    //referencing function for validation
                    validateEmail,
                    'Email',
                    obscureText: false,
                    onFieldSubmitted: (String value) {
                      FocusScope.of(context).requestFocus(secondFocusNode);
                    }
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
                    suffixIcon: new GestureDetector(
                      //calls toggleObscure function to enable or disable obscureText parameter
                      onTap: toggleObscure,
                      child: Icon(
                        //changes the icon
                        obscurePassword ? Icons.visibility : Icons.visibility_off
                      ),
                    ),
                    //controlled by toggleObscure function
                    obscureText: obscurePassword,
                    focusNode: secondFocusNode,
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
                            loginPostData();
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
                            registerPostData();
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
