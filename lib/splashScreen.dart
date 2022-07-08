// ignore_for_file: file_names, use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:hidden_lamp/homescreen.dart';

import 'dart:async';
import 'package:hidden_lamp/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const SplashScreen());

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(milliseconds: 3000),
      () => {sharePreferances()},
    );
  }

  sharePreferances() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? setStatus = prefs.getStringList("status");
    List<String>? setUserEmail = prefs.getStringList("email");
    setStatus == null ? setStatus = [] : print("List is not Empty");
    setUserEmail == null ? setUserEmail = [] : print("List is not Empty");
    await prefs.setStringList("status", setStatus);
    await prefs.setStringList("email", setUserEmail);

    var getUserStatus = prefs.getStringList("status");
    print(getUserStatus?.length);
    // ignore: prefer_is_empty
    if (getUserStatus?.length != 0) {
      if (getUserStatus?[0] == "1") {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => Home()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => LoginView()));
      }
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => LoginView()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.blue, Colors.red])),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 80,
                        backgroundImage: AssetImage(
                          "assets/logo.png",
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      const Text(
                        'Hidden Lamp',
                        style: TextStyle(
                          fontSize: 45,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: const <Widget>[
                        CircularProgressIndicator(
                          strokeWidth: 2,
                          backgroundColor: Colors.white,
                        ),
                        Padding(padding: EdgeInsets.only(top: 30)),
                        Text(
                          '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        Text(
                          'Enlighten your hidden talent',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
