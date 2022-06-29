import 'package:flutter/material.dart';
import 'package:hidden_lamp/courseList.dart';

class Course extends StatefulWidget {
  const Course({Key? key, this.courseDetails}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final courseDetails;
  @override
  State<Course> createState() => _CourseState();
}

class _CourseState extends State<Course> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(""),
        actions: const [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Icon(
              Icons.notifications_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: AssetImage("assets/1.png"),
              ),
              Text(
                widget.courseDetails["CourseName"],
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person, color: Color(0xff00acc1)),
                      Text(
                        widget.courseDetails["Author"],
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff00acc1)),
                      ),
                    ],
                  ),
                  Text("⭐ ${widget.courseDetails["Rating"]}"),
                  Text(
                    "",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff00acc1)),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.courseDetails["description"],
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.grey, fontSize: 18, height: 1.5),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Students",
                          style: TextStyle(
                              color: Colors.grey, fontSize: 18, height: 1.5),
                        ),
                        Text(
                          widget.courseDetails["RegisteredStudents"],
                          style: TextStyle(
                              color: Colors.black, fontSize: 18, height: 1.5),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Language",
                          style: TextStyle(
                              color: Colors.grey, fontSize: 18, height: 1.5),
                        ),
                        Text(
                          widget.courseDetails["Language"],
                          style: TextStyle(
                              color: Colors.black, fontSize: 18, height: 1.5),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Last Update",
                          style: TextStyle(
                              color: Colors.grey, fontSize: 18, height: 1.5),
                        ),
                        Text(
                          widget.courseDetails["LastUpdate"],
                          style: TextStyle(
                              color: Colors.black, fontSize: 18, height: 1.5),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Subtitle",
                          style: TextStyle(
                              color: Colors.grey, fontSize: 18, height: 1.5),
                        ),
                        Text(
                          widget.courseDetails["SubTitle"],
                          style: TextStyle(
                              color: Colors.black, fontSize: 18, height: 1.5),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => CourseList(
                          courseList: widget.courseDetails,
                        ),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xff26c6da)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 120, right: 120, top: 20, bottom: 20),
                    child: Text(
                      "Open Course",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
