import 'package:client/services/auth.dart';
import 'package:client/shared/appbar.dart';
import 'package:client/shared/constants.dart';
import 'package:client/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});
  // const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // Create instant object _auth
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //Text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Color(0xFFFFFFFF),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 80,
                  ),
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/logowithtext.png',
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            validator: (value) =>
                                value!.isEmpty ? 'Enter a valid Email' : null,
                            onChanged: (value) {
                              setState(() => email = value);
                            },
                            decoration: textInputDecoration.copyWith(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            validator: (value) => value!.length < 6
                                ? 'Enter an 6+ chars long password'
                                : null,
                            obscureText: true,
                            onChanged: (value) {
                              setState(() => password = value);
                            },
                            decoration: textInputDecoration.copyWith(
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            error,
                            style: TextStyle(color: Colors.red, fontSize: 14),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 250,
                            child: RaisedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() => loading = true);
                                  dynamic result =
                                      await _auth.signinWithEmailAndPassword(
                                          email, password);
                                  if (result == null) {
                                    setState(() {
                                      error =
                                          'Could not sign in with those cedentials';
                                      loading = false;
                                    });
                                  }
                                }
                              },
                              child: Text('Sign In',
                                  style: TextStyle(
                                      color: Color(0xFFFFFFFF), fontSize: 17)),
                              color: Color(0xFF29BF12),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Or'),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 250,
                            child: RaisedButton(
                              onPressed: () async {
                                widget.toggleView();
                              },
                              child: Text('Register',
                                  style: TextStyle(
                                      color: Color(0xFFFFFFFF), fontSize: 17)),
                              color: Color(0xFF29BF12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
