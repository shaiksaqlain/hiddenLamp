// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hidden_lamp/services/WebviewPage.dart';

class OncompletedAssignments extends StatefulWidget {
  const OncompletedAssignments(
      {Key? key, required this.oncompletedlist, this.email, this.assignments})
      : super(key: key);

  final assignments;
  final List oncompletedlist;
  final email;

  @override
  State<OncompletedAssignments> createState() => _OncompletedAssignmentsState();
}

class _OncompletedAssignmentsState extends State<OncompletedAssignments> {
  @override
  void initState() {
    print(widget.assignments);
    print(widget.oncompletedlist);
    print(widget.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xff26c6da),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              EvaIcons.arrowIosBack,
                              color: Colors.white,
                            )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15),
                      child: Text(
                        "Completed Assignments",
                        style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: widget.assignments.length,
                  itemBuilder: (BuildContext context, int index) => (widget
                          .oncompletedlist
                          .contains(widget.assignments[index]["DocId"]))
                      ? GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => WebViewPage(
                                  fileurl: widget.assignments[index]
                                      ["AssignmentUrl"],
                                  name: widget.assignments[index]
                                      ["assignmentName"],
                                ),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 0.3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(
                                color: Colors.grey.withOpacity(0.4),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                          child: Text(
                                        "Assignment ${index + 1}",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      )),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                          child: Text(
                                        widget.assignments[index]
                                            ["assignmentName"],
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                      )),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        widget.assignments[index]
                                            ["description"],
                                        textAlign: TextAlign.justify,
                                        maxLines: 3,
                                        style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Text(
                                            "Date: ${widget.assignments[index]["date"]}",
                                            style: TextStyle(
                                                fontSize: 9,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Time: ${widget.assignments[index]["time"]}",
                                            style: TextStyle(
                                                fontSize: 9,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Deadline: ${widget.assignments[index]["deadline"]}",
                                            style: TextStyle(
                                                fontSize: 9,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
