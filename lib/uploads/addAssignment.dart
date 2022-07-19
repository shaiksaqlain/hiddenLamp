// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class AddAssignment extends StatefulWidget {
  const AddAssignment({Key? key}) : super(key: key);

  @override
  State<AddAssignment> createState() => _AddAssignmentState();
}

class _AddAssignmentState extends State<AddAssignment> {
  String assignmentUrl = "";
  String assignmentName = "";
  String assignmentClass = "";
  String deadLine = "";
  String description = "";
  String time = "";
  DateTime dateToday = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff26c6da),
        centerTitle: true,
        title: Text("Upload Assignment"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 15, right: 15, left: 15),
                child: Text(
                  "You Are Uploading Assignment Details.",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600]),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Icon(
                          EvaIcons.hashOutline,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          assignmentName = value;
                        },
                        decoration: InputDecoration(
                            hintText: "Assignment Name",
                            labelText: "Assignment Name",
                            border: OutlineInputBorder()),
                      ),
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Icon(
                          EvaIcons.shieldOutline,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(
                              5,
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                            hint: Text(assignmentClass),
                            items: <String>[
                              '1st Class assignment',
                              '2nt Class assignment',
                              '3rt Class assignment',
                              '4th Class assignment',
                              '5th Class assignment',
                              '6th Class assignment',
                              '7th Class assignment',
                              '8th Class assignment',
                              '9th Class assignment',
                              '10th Clas assignment',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                assignmentClass = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Icon(
                          EvaIcons.globe,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          assignmentUrl = value;
                        },
                        decoration: InputDecoration(
                            hintText: "Assignment Url",
                            labelText: "Assignment Url",
                            border: OutlineInputBorder()),
                      ),
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Icon(
                          EvaIcons.clockOutline,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          value =
                              "${dateToday.day}/${dateToday.month}/${dateToday.year}";
                        },
                        decoration: InputDecoration(
                            hintText:
                                "${dateToday.day}/${dateToday.month}/${dateToday.year}",
                            labelText:
                                "${dateToday.day}/${dateToday.month}/${dateToday.year}",
                            border: OutlineInputBorder()),
                      ),
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Icon(
                          EvaIcons.flagOutline,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          deadLine = value;
                        },
                        decoration: InputDecoration(
                            hintText: "DeadLine",
                            labelText: "DeadLine",
                            border: OutlineInputBorder()),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Icon(
                          EvaIcons.text,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                          maxLines: null,
                          onChanged: (value) {
                            description = value;
                          },
                          decoration: InputDecoration(
                              hintText: "Description (5-7 words)",
                              labelText: "Description",
                              border: OutlineInputBorder()),
                          keyboardType: TextInputType.multiline),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Icon(
                          EvaIcons.clock,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                          maxLines: null,
                          onChanged: (value) {
                            time = value;
                          },
                          decoration: InputDecoration(
                              hintText: "Time",
                              labelText: "Time",
                              border: OutlineInputBorder()),
                          keyboardType: TextInputType.multiline),
                    ),
                  ],
                ),
              ),
// A flat icon Button  Which calls the function to upload the data into firebase

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Card(
                    color: Colors.deepOrange[400],
                    child: TextButton.icon(

                        //checking the fields to promte the user if its Empty

                        onPressed: () {
                          if (assignmentUrl != '' &&
                              deadLine != '' &&
                              assignmentName != '' &&
                              time != '' &&
                              description != '') {
                            FirebaseFirestore.instance
                                .collection(assignmentClass)
                                .doc()
                                .set({
                              'AssignmentUrl': assignmentUrl,
                              'assignmentName': assignmentName,
                              'date':
                                  "${dateToday.day}/${dateToday.month}/${dateToday.year}",
                              'deadline': deadLine,
                              'time': time,
                              'description': description
                            });
                            FirebaseFirestore.instance
                                .collection("Assignments")
                                .doc()
                                .set({
                              'AssignmentUrl': assignmentUrl,
                              'assignmentName': assignmentName,
                              'date':
                                  "${dateToday.day}/${dateToday.month}/${dateToday.year}",
                              'deadline': deadLine,
                              'time': time,
                              'description': description
                            });
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("User Added Successfully"),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("All fields are needed"),
                              ),
                            );
                          }
                        },
                        icon: Icon(EvaIcons.upload, color: Colors.white),
                        label: Text(
                          "Upload",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
