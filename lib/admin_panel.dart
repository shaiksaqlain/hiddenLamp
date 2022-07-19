// ignore_for_file: sort_child_properties_last

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hidden_lamp/deliverProducts.dart';
import 'package:hidden_lamp/uploads/addAssignment.dart';
import 'package:hidden_lamp/uploads/addCourse.dart';
import 'package:hidden_lamp/uploads/addProject.dart';
import 'package:hidden_lamp/uploads/addReel.dart';
import 'package:hidden_lamp/uploads/popular%20courses.dart';
import 'package:hidden_lamp/uploads/addUser.dart';
import 'package:hidden_lamp/uploads/updateReels.dart';
import 'package:hidden_lamp/uploads/updateUser.dart';

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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ExpansionTile(
                textColor: Colors.black,
                title: Text(
                  "User",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle:
                    Text("You can create and update the user Details here."),
                leading: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple[50],
                      borderRadius: BorderRadius.circular(5)),
                  child: Icon(EvaIcons.personOutline,
                      size: 30, color: Colors.deepPurple[300]),
                ),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => UserUpload(),
                              ),
                            );
                          },
                          icon: Icon(
                            EvaIcons.personAddOutline,
                            color: Colors.red[600],
                          ),
                          label: Text("Create")),
                      TextButton.icon(
                          onPressed: () {

                             Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => UpdateUser(),
                              ),
                            );
                          },
                          icon: Icon(
                            EvaIcons.edit2Outline,
                            color: Colors.orange[400],
                          ),
                          label: Text("Update")),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ExpansionTile(
                textColor: Colors.black,
                title: Text(
                  "Course",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle:
                    Text("You can create and update the Course Details here."),
                leading: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple[50],
                      borderRadius: BorderRadius.circular(5)),
                  child: Icon(EvaIcons.bookOutline,
                      size: 30, color: Colors.deepPurple[300]),
                ),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => AddCourse(),
                              ),
                            );
                          },
                          icon: Icon(
                            EvaIcons.personAddOutline,
                            color: Colors.red[600],
                          ),
                          label: Text("Create")),
                      TextButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            EvaIcons.edit2Outline,
                            color: Colors.orange[400],
                          ),
                          label: Text("Update")),
                    ],
                  )
                ],
              ),
              
              SizedBox(
                height: 20,
              ),
              ExpansionTile(
                textColor: Colors.black,
                title: Text(
                  "Reels",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle:
                    Text("You can create and update the Reels Details here."),
                leading: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple[50],
                      borderRadius: BorderRadius.circular(5)),
                  child: Icon(EvaIcons.starOutline,
                      size: 30, color: Colors.deepPurple[300]),
                ),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => AddReel(),
                              ),
                            );
                          },
                          icon: Icon(
                            EvaIcons.personAddOutline,
                            color: Colors.red[600],
                          ),
                          label: Text("Create")),
                      TextButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>UpdateReel(),
                              ),
                            );
                          },
                          icon: Icon(
                            EvaIcons.edit2Outline,
                            color: Colors.orange[400],
                          ),
                          label: Text("Update")),
                    ],
                  )
                ],
              ),
              
              SizedBox(
                height: 20,
              ),
              ExpansionTile(
                textColor: Colors.black,
                title: Text(
                  "Assignment",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle:
                    Text("You can create and update the Assignment Details here."),
                leading: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple[50],
                      borderRadius: BorderRadius.circular(5)),
                  child: Icon(EvaIcons.activityOutline,
                      size: 30, color: Colors.deepPurple[300]),
                ),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => AddAssignment(),
                              ),
                            );
                          },
                          icon: Icon(
                            EvaIcons.personAddOutline,
                            color: Colors.red[600],
                          ),
                          label: Text("Create")),
                      TextButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            EvaIcons.edit2Outline,
                            color: Colors.orange[400],
                          ),
                          label: Text("Update")),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              
              ExpansionTile(
                textColor: Colors.black,
                title: Text(
                  "Shop",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle:
                    Text("You can create and update the Shop Details here."),
                leading: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple[50],
                      borderRadius: BorderRadius.circular(5)),
                  child: Icon(EvaIcons.shoppingBagOutline,
                      size: 30, color: Colors.deepPurple[300]),
                ),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => DeliveryPage(),
                              ),
                            );
                          },
                          icon: Icon(
                            EvaIcons.personAddOutline,
                            color: Colors.red[600],
                          ),
                          label: Text("Create")),
                      TextButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            EvaIcons.edit2Outline,
                            color: Colors.orange[400],
                          ),
                          label: Text("Update")),
                    ],
                  )
                ],
              ),

              
              SizedBox(
                height: 20,
              ),
              ExpansionTile(
                textColor: Colors.black,
                title: Text(
                  "Project",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle:
                    Text("You can create and update the Project Details here."),
                leading: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple[50],
                      borderRadius: BorderRadius.circular(5)),
                  child: Icon(EvaIcons.toggleLeftOutline,
                      size: 30, color: Colors.deepPurple[300]),
                ),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => AddProject()
                              ),
                            );
                          },
                          icon: Icon(
                            EvaIcons.personAddOutline,
                            color: Colors.red[600],
                          ),
                          label: Text("Create")),
                      TextButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            EvaIcons.edit2Outline,
                            color: Colors.orange[400],
                          ),
                          label: Text("Update")),
                    ],
                  )
                ],
              ),

              SizedBox(
                height: 20,
              ),
              
              ExpansionTile(
                textColor: Colors.black,
                title: Text(
                  "Popular Course",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle:
                    Text("You can create and update the Popular Course Details here."),
                leading: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple[50],
                      borderRadius: BorderRadius.circular(5)),
                  child: Icon(EvaIcons.bookOutline,
                      size: 30, color: Colors.deepPurple[300]),
                ),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => AddPopularCourse(),
                              ),
                            );
                          },
                          icon: Icon(
                            EvaIcons.personAddOutline,
                            color: Colors.red[600],
                          ),
                          label: Text("Create")),
                      TextButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            EvaIcons.edit2Outline,
                            color: Colors.orange[400],
                          ),
                          label: Text("Update")),
                    ],
                  )
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
