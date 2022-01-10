import 'package:flutter/material.dart';
import 'package:news_app/helper/auth.dart';

class Signin extends StatefulWidget {
  // const Signin({Key? key}) : super(key: key);
  final Function toggleView;
  Signin({required this.toggleView});

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        elevation: 0.0,
        title: Text("Signin to news app"),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: Icon(
              Icons.person,
              color: Colors.greenAccent,
            ),
            label: Text(
              "Sign Up",
              style: TextStyle(color: Colors.greenAccent),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return "Enter an email";
                  }

                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                validator: (String? value) {
                  if (value!.length < 6) {
                    return "Enter 6+ chars long";
                  }

                  return null;
                },
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                color: Colors.blueGrey[900],
                child: Text(
                  'Sign in',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                onPressed: () async {
                  final form = _formKey.currentState;
                  if (form != null && !form.validate()) {
                    // Invalid!
                    return;
                  }
                  dynamic result =
                      await _auth.signInWithEmailAndPassword(email, password);

                  if (result == null) {
                    setState(() {
                      error = 'Please enter valid data';
                    });
                  }
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
