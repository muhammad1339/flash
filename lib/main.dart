import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash/products_page.dart';
import 'package:flutter/material.dart';

import 'add_product_page.dart';
import 'component/rounded_button.dart';
import 'login_page.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: MainPage.pageName,
      routes: {
        MainPage.pageName: (context) => MainPage(),
        LoginPage.pageName: (context) => LoginPage(),
        AddProductPage.pageName: (context) => AddProductPage(),
        ProductsPage.pageName: (context) => ProductsPage(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  static String pageName = 'main';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser user = await firebaseAuth.currentUser();
    if (user != null) {
      Navigator.pushNamed(context, AddProductPage.pageName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: 'flash',
              child: Image.asset(
                'images/flash.png',
                width: 220.0,
                height: 220.0,
              ),
            ),
            Text(
              'Flash Chat',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            RoundedButton(
              text: 'LOGIN',
              onPress: () {
                Navigator.pushNamed(context, LoginPage.pageName);
              },
            ),
            RoundedButton(
              text: 'REGISTER',
              onPress: () {},
            ),
          ],
        ),
      ),
    ));
  }
}
