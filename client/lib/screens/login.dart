import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static const routeName = '/login';

  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();
  var _isLoading = false;
  String _token = "";
  Map<String, String> _authData = {'username': '', 'password': ''};
  Map<String, dynamic> _data = Map<String, dynamic>();

  Future<void> _login() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    const url = 'http://192.168.43.128:8000/api/users/login';
    try {
      final response = await http.post(url, body: {
        "username": _authData['username'],
        "password": _authData['password']
      });
      _data = json.decode(response.body);
      if (_data['token'] == null) {
        setState(() {
          _isLoading = false;
        });
        return;
      }
      _token = _data['token'];
      print(_token.runtimeType);

      Navigator.of(context).pushReplacementNamed('/dash-board');
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print(error);
    }
  }

//  _getAndSaveToken() async {
//   SharedPreferences prefs  = await SharedPreferences.getInstance();
//   String token = await _token;
//   await prefs.setInt('jwt', token);
// }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                      Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0, 1])),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                children: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    elevation: 8,
                    child: Container(
                      height: 265,
                      width: deviceSize.width * .75,
                      padding: EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'User name'),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enter your user name';
                                }
                              },
                              onSaved: (value) {
                                _authData['username'] = value;
                              },
                            ),
                            if (_data['username'] != null)
                              Text(_data['username']),
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Password'),
                              obscureText: true,
                              controller: _passwordController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enter your password';
                                }
                              },
                              onSaved: (value) {
                                _authData['password'] = value;
                              },
                            ),
                            if (_data['password'] != null)
                              Text(_data['password']),
                            if (_isLoading)
                              CircularProgressIndicator()
                            else
                              RaisedButton(
                                child: Text("Login"),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30.0, vertical: 8.0),
                                color: Theme.of(context).primaryColor,
                                textColor: Theme.of(context)
                                    .primaryTextTheme
                                    .button
                                    .color,
                                onPressed: _login,
                              )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
