
// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hidden_lamp/course.dart';

class OngoingCourse extends StatefulWidget {
  const OngoingCourse(
      {Key? key, this.courseList, required this.ongoingList, this.email})
      : super(key: key);

  final courseList;
  final List ongoingList;
  final email;

  @override
  State<OngoingCourse> createState() => _OngoingCourseState();
}

class _OngoingCourseState extends State<OngoingCourse> {
  
  @override
  void initState() {
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
                        "Ongoing Courses",
                        style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
                    itemCount: widget.courseList.length,
                    itemBuilder: (BuildContext context, int index) => widget
                            .ongoingList
                            .contains(widget.courseList[index]["DocID"])
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => Course(
                                      email: widget.email,
                                      courseDetails: widget.courseList[index],
                                    ),
                                  ),
                                );
                              },
                              child: Center(
                                  child: Image.network(
                                widget.courseList[index]["ImageUrl"],
                                width: 250,
                                height: 120,
                              )),
                            ),
                          )
                        : Container()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
