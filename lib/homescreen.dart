// ignore_for_file: file_names

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hidden_lamp/assignments.dart';
import 'package:hidden_lamp/courses.dart';
import 'package:hidden_lamp/home.dart';
import 'package:hidden_lamp/profile.dart';
import 'package:hidden_lamp/shop.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  Widget home = HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        selectedItemColor: Color(0xff26c6da),
        unselectedItemColor: Colors.grey[500],
        currentIndex: currentIndex,
        onTap: (value) {
          currentIndex = value;
          switch (value) {
            case 0:
              home = HomeScreen();
              break;
            case 1:
              home = Courses();
              break;
            case 2:
              home = Assignments();
              break;
            case 3:
              home = Shop();
              break;
            case 4:
              home = ProfileView();
          }
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              activeIcon: Icon(Icons.home_filled),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(EvaIcons.bookOutline),
              activeIcon: Icon(EvaIcons.bookOpenOutline),
              label: "Courses"),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment_ind_outlined),
              activeIcon: Icon(Icons.assignment_ind_rounded),
              label: "Assignments"),
          BottomNavigationBarItem(
              icon: Icon(EvaIcons.shoppingBagOutline),
              activeIcon: Icon(EvaIcons.shoppingBag),
              label: "Shop"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              activeIcon: Icon(Icons.person),
              label: "Profile"),
        ],
      ),
      body: home,
    );
  }
}
