// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:hidden_lamp/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Share {
  sharePreferances(String status, String email, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? setStatus = prefs.getStringList("status");
    List<String>? setUserEmail = prefs.getStringList("email");
    setStatus == null ? setStatus = [] : print("List is not Empty");
    setUserEmail == null ? setUserEmail = [] : print("List is not Empty");
    setStatus.clear();
    setUserEmail.clear();
    setStatus.add(status);
    setUserEmail.add(email);
    await prefs.setStringList("status", setStatus);
    await prefs.setStringList("email", setUserEmail);
    var getEmail = prefs.getStringList("status");
    var getUserStatus = prefs.getStringList("email");
    print(getEmail);
    print(getUserStatus);
  }

  clearSharePreferances(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? setStatus = prefs.getStringList("status");
    List<String>? setUserEmail = prefs.getStringList("email");

    setStatus == null ? setStatus = [] : print("List is not Empty");
    setUserEmail == null ? setUserEmail = [] : print("List is not Empty");
    setStatus.clear();
    setUserEmail.clear();

    setStatus.add("0");
    await prefs.setStringList("status", setStatus);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => LoginView(),
      ),
    );
  }
}
