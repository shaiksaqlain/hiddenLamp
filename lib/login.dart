// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hidden_lamp/homescreen.dart';
import 'package:hidden_lamp/services/sharedPreferances.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String email = "";
  String password = "";
  bool isLoading = false;
  final Share _share = Share();

  Future<void> getUserData(String email) async {
    isLoading = true;
    setState(() {});
    try {
      DocumentReference projectCollectionRef =
          FirebaseFirestore.instance.collection('Users').doc(email);
      DocumentSnapshot documentSnapshot = await projectCollectionRef.get();
      print(documentSnapshot.data().toString());
      print(documentSnapshot.get("schoolName"));
      // ignore: duplicate_ignore, duplicate_ignore
      if (documentSnapshot.get("Password") == password) {
        // ignore: use_build_context_synchronously
        _share.sharePreferances("1", email, context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Login Successful"),
          ),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => Home(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Invalid Credentails"),
          ),
        );
      }
      isLoading = false;
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("User doesn't Exist"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(238, 238, 238, 1),
      body: SingleChildScrollView(
          child: !isLoading
              ? Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 60,
                              backgroundImage: AssetImage(
                                "assets/logo.png",
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 10)),
                          ],
                        ),
                        Text(
                          "Hello Again!",
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "welcome back you've \nbeen missed",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Theme(
                          data: Theme.of(context)
                              .copyWith(splashColor: Colors.transparent),
                          child: TextField(
                            onChanged: (value) {
                              email = value;
                            },
                            autofocus: false,
                            style:
                                TextStyle(fontSize: 22.0, color: Colors.black),
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.email_outlined,
                                color: Colors.black45,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Username',
                              contentPadding: const EdgeInsets.only(
                                  left: 26.0, bottom: 20.0, top: 20.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Theme(
                          data: Theme.of(context)
                              .copyWith(splashColor: Colors.transparent),
                          child: TextField(
                            onChanged: (value) {
                              password = value;
                            },
                            autofocus: false,
                            style:
                                TextStyle(fontSize: 22.0, color: Colors.black),
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.remove_red_eye_outlined,
                                color: Colors.black45,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Password',
                              contentPadding: const EdgeInsets.only(
                                  left: 26.0, bottom: 20.0, top: 20.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Forgot Password",
                                  style: TextStyle(color: Colors.black87),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (email != "" && password != "") {
                              getUserData(email);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Please Enter Email and Password"),
                                ),
                              );
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                                color: Color(0xff26c6da),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "SIGN IN",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width, //70.0,
                  height: MediaQuery.of(context).size.height, //70.0,
                  child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(),
                          SizedBox(height: 20),
                          Text(
                            "Loading please wait...!",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12),
                          )
                        ],
                      ))),
                )),
    );
  }
}
