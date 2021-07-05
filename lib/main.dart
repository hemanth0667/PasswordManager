import 'package:PasswordManager/screens/homepage.dart';
import 'package:PasswordManager/screens/login.dart';
// import 'package:firebase/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// import 'package:firebase_auth/firebase_auth.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Password Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.white,
          accentColor: Colors.white,
          scaffoldBackgroundColor: Color(0xff070706)),
      home: Wrapper(),
    );
  }
}
//import 'package:firebase/firebase.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser;
    if (user == null) return LoginPage();
    return HomePage();
  }
}
