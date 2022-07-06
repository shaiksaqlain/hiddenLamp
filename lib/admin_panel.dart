// ignore_for_file: sort_child_properties_last

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hidden_lamp/uploads/addAssignment.dart';
import 'package:hidden_lamp/uploads/addCourse.dart';
import 'package:hidden_lamp/uploads/addProject.dart';
import 'package:hidden_lamp/uploads/addReel.dart';
import 'package:hidden_lamp/uploads/popular%20courses.dart';
import 'package:hidden_lamp/uploads/userUpload.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff26c6da),
        title: Text("Admin Panel"),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => UserUpload(),
                              ),
                            );
                          },
                          child: listCard(EvaIcons.personAddOutline, "Users"))),
                  Expanded(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => AddCourse(),
                              ),
                            );
                          },
                          child: listCard(EvaIcons.bookOutline, "Courses"))),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => AddReel(),
                              ),
                            );
                          },
                          child: listCard(EvaIcons.starOutline, "Reels"))),
                  Expanded(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  AddAssignment(),
                            ),
                          );
                        },
                        child: listCard(EvaIcons.activity, "Assignment")),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                        onTap: () {},
                        child: listCard(EvaIcons.shoppingBagOutline, "Shop")),
                  ),
                  Expanded(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => AddProject(),
                              ),
                            );
                          },
                          child: listCard(EvaIcons.bookOutline, "Projects"))),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    AddPopularCourse(),
                              ),
                            );
                          },
                          child: listCard(
                              EvaIcons.bookOutline, "Popular Courses"))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listCard(icon, name) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Card(
        child: Container(
          height: 200,
          width: 150,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Icon(icon, size: 140, color: Colors.deepOrange[300]),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.deepPurple[50],
              borderRadius: BorderRadius.circular(5)),
        ),
      ),
    );
  }
}
