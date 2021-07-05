import 'package:PasswordManager/encrypt_decrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddPwd extends StatefulWidget {
  @override
  _AddPwdState createState() => _AddPwdState();
}

class _AddPwdState extends State<AddPwd> {
  String type;
  String name;
  String pwd;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back_ios_outlined,
                        size: 24.0,
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.grey[700],
                        ),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 8.0)),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: add,
                      child: Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: "lato",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.grey[700],
                        ),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 8.0)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration:
                            InputDecoration.collapsed(hintText: "Account Type"),
                        style: TextStyle(
                          fontSize: 32.0,
                          fontFamily: "lato",
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        onChanged: (_val) {
                          type = _val;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: TextFormField(
                          decoration:
                              InputDecoration.collapsed(hintText: "Username"),
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "lato",
                            color: Colors.grey,
                          ),
                          onChanged: (_val) {
                            name = _val;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: TextFormField(
                          decoration:
                              InputDecoration.collapsed(hintText: "Password"),
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "lato",
                            color: Colors.grey,
                          ),
                          onChanged: (_val) {
                            pwd = _val;
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void add() async {
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('passwords');

    var data = {
      'type': type,
      'name': name,
      'pwd': Encrypt_decrypt.encrypt(pwd),
      'created': DateTime.now(),
    };

    ref.add(data);
    Navigator.pop(context);
  }
}
