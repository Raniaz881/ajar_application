import 'package:flutter_app/services/ResetPassword.dart';
import 'package:flutter/material.dart';
import 'auth.dart';
import 'package:flutter_app/HomePage/home_screen.dart';
import 'package:flutter_app/services/Register.dart';

class SignIn extends StatefulWidget {   //stateful widget refers to the widgets which interacts with the user
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';
  String error = '';

  AuthService _auth = new AuthService();

  void _showEmailDialog() {
    showDialog(context: context,
    builder: (BuildContext context){
      return AlertDialog(
        title: new Text('Please Verify Your Email'),
        content: new Text("We need you to verify your email to continue using our app"),
        actions: <Widget>[
          new FlatButton(onPressed: () {
            Navigator.of(context).pop();
            _auth.sendEmailVerification();
          }, child: Text('Send')),
          new FlatButton(onPressed: () {
            Navigator.of(context).pop();
          }, child: Text('Dismiss'))
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 1.0),
                Center(child: Image.asset('assets/logo.png')),
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 30.0),
                TextFormField(
                  style: TextStyle(color: Colors.green[800]),
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.green[800]),
                      hintText: "Enter your Email",
                      filled: true,
                      fillColor: Colors.lightGreen[50],
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.green[300], width: 3.0),
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.green[500], width: 3.0),
                        borderRadius: new BorderRadius.circular(25.0),
                      )),
                  validator: (val){
                    return null;
                  },
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  style: TextStyle(color: Colors.green[800]),
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.green[800]),
                      hintText: "Enter your Password",
                      filled: true,
                      fillColor: Colors.lightGreen[50],
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.green[300], width: 3.0),
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.green[500], width: 3.0),
                        borderRadius: new BorderRadius.circular(25.0),
                      )),
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.green[400],
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if (result == null) {
                        setState(() {
                          error = 'Could not sign in with those credentials';
                        });
                      }
                      else if (!(await _auth.isEmailVerified())) {
                        setState(() {
                          error = 'Please Verify your email';
                          _showEmailDialog();
                        });
                      }
                      else{
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                      }
                    }
                  },
                ),


                SizedBox(height: 22.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Text('Don\'t have an account?', style: TextStyle(fontWeight: FontWeight.w500),),
                    RawMaterialButton(
                        splashColor: Colors.green,
                        textStyle: TextStyle(color: Colors.black),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(' Sign Up now  ', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.green),),
                            Icon(Icons.person_add)
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Register()),
                          );
                        }
                    ),

                  ],
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Text('Forgot your password ?', style: TextStyle(fontWeight: FontWeight.w500),),
                    RawMaterialButton(
                        splashColor: Colors.green,
                        textStyle: TextStyle(color: Colors.black),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text('Retrieve', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.green),),

                          ],
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPassword()),
                          );
                        }
                    ),

                  ],
                ),



                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}