import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash/add_product_page.dart';
import 'package:flash/component/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'component/rounded_field.dart';

class LoginPage extends StatefulWidget {
  static String pageName = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final auth = FirebaseAuth.instance;
  String _email;
  String _password;
  bool _isLoading = false;

  void createUser({String email, String password}) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print(user.user);
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  void loginWithEmail({String email, String password}) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(user.user);
      setState(() {
        _isLoading = false;
        Navigator.pushNamed(context, AddProductPage.pageName);
      });
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag: 'flash',
                    child: Image.asset(
                      'images/flash.png',
                      height: 180.0,
                      width: 180.0,
                    ),
                  ),
                  Container(
                    width: 200.0,
                    child: TypewriterAnimatedTextKit(
                        text: ['Flash Chat'],
                        textStyle:
                            TextStyle(fontSize: 30.0, fontFamily: "Agne"),
                        textAlign: TextAlign.start,
                        alignment: AlignmentDirectional
                            .topStart // or Alignment.topLeft
                        ),
                  )
                ],
              ),
              RoundedField(
                isPassword: false,
                onChanged: (text) {
                  setState(() {
                    _email = text;
                  });
                },
                label: 'Email',
              ),
              RoundedField(
                isPassword: true,
                onChanged: (text) {
                  setState(() {
                    _password = text;
                  });
                },
                label: 'password',
              ),
              RoundedButton(
                text: 'LOGIN',
                onPress: () {
                  loginWithEmail(email: _email, password: _password);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
