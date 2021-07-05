// import 'package:PasswordManager/main.dart';
import 'package:PasswordManager/screens/addpwd.dart';
import 'package:PasswordManager/screens/login.dart';
import 'package:PasswordManager/screens/viewpwd.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('passwords');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => AddPwd(),
            ),
          )
              .then((value) {
            print("Calling Set state");
            setState(() {});
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white70,
        ),
        backgroundColor: Colors.grey[700],
      ),
      appBar: AppBar(
        title: Text(
          "My Passwords",
          style: TextStyle(
            fontSize: 32.0,
            fontFamily: "lato",
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Color(0xff070706),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                User user = FirebaseAuth.instance.currentUser;
                print("before" + user.toString());
                await FirebaseAuth.instance.signOut();
                //  user = FirebaseAuth.instance.currentUser;
                print("After" + user.toString());

                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              }),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: ref.get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    Map data = snapshot.data.docs[index].data();
                    DateTime mydateTime = data['created'].toDate();
                    String formattedTime =
                        DateFormat.yMMMd().add_jm().format(mydateTime);
                    return InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(
                          MaterialPageRoute(
                            builder: (context) => ViewPwd(
                              data,
                              formattedTime,
                              snapshot.data.docs[index].reference,
                            ),
                          ),
                        )
                            .then((value) {
                          setState(() {});
                        });
                      },
                      child: Card(
                        color: Colors.grey[700],
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${data['type']}",
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontFamily: "lato",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  formattedTime,
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    fontFamily: "lato",
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: Text("Loading..."),
              );
            }
          }),
    );
  }
}
