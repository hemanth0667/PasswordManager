import 'package:PasswordManager/encrypt_decrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:PasswordManager/screens/viewpwd.dart';
import 'package:PasswordManager/screens/homepage.dart';

class UpdatePwd extends StatefulWidget {
  final Map data;
  final DocumentReference ref;
  UpdatePwd(this.data, this.ref);

  @override
  _UpdatePwdState createState() => _UpdatePwdState();
}

class _UpdatePwdState extends State<UpdatePwd> {
  final TextEditingController _textController1 = new TextEditingController();
  final TextEditingController _textController2 = new TextEditingController();
  String type;
  String name;
  String pwd;

  @override
  Widget build(BuildContext context) {
    _textController1.text = "${widget.data['name']}";
    _textController2.text =
        Encrypt_decrypt.decrypt(widget.data['pwd']).toString();
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
                      onPressed: () {
                        if (name == null) {
                          name = widget.data['name'];
                        }
                        if (pwd == null) {
                          pwd = Encrypt_decrypt.decrypt(widget.data['pwd']);
                        }
                        type = widget.data['type'];
                        update();
                        // Navigator.of(context)
                        //     .push(
                        //   MaterialPageRoute(
                        //     builder: (context) => HomePage(),
                        //   ),
                        // )
                        //     .then((value) {
                        //   print("Calling Set state");
                        //   setState(() {});
                        //});
                      },
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
                      Text(
                        "${widget.data['type']}",
                        style: TextStyle(
                          fontSize: 32.0,
                          fontFamily: "lato",
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: TextFormField(
                          controller: _textController1,
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
                          controller: _textController2,
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

  void update() {
    // CollectionReference ref = FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(FirebaseAuth.instance.currentUser.uid)
    //     .collection('passwords').doc().update({'type':});

    widget.ref.update({
      'type': type,
      'name': name,
      'pwd': Encrypt_decrypt.encrypt(pwd),
      'created': DateTime.now()
    });
    // var data = {
    //   'type': type,
    //   'name': name,
    //   'pwd': Encrypt_decrypt.encrypt(pwd),
    //   'created': DateTime.now(),
    // };

    // ref.add(data);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  } 
}
