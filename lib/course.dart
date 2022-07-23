import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hidden_lamp/courseList.dart';

class Course extends StatefulWidget {
  const Course({Key? key, this.courseDetails, this.email}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final courseDetails;
  // ignore: prefer_typing_uninitialized_variables
  final email;
  @override
  State<Course> createState() => _CourseState();
}

class _CourseState extends State<Course> {
  // ignore: prefer_typing_uninitialized_variables
  var filterData;
  List isCompleted = [];
  List isOngoing = [];
  @override
  void initState() {
    getFilterDetails(widget.email);
    super.initState();
  }

  Future<void> getFilterDetails(String email) async {
    var collection = FirebaseFirestore.instance.collection('Filter');
    var docSnapshot = await collection.doc(email).get();
    if (docSnapshot.exists) {
      filterData = docSnapshot.data();
      isCompleted = filterData["isCourseCompleted"];
      isOngoing = filterData["isCourseOngoing"];
      isCompleted.contains(widget.courseDetails["DocID"]);
      print(isCompleted);
      print(isOngoing);
      print(widget.courseDetails["DocID"]);
      print(isCompleted.contains(widget.courseDetails["DocID"]));
    }

    setState(() {});
  }

  updateFilter() {
    FirebaseFirestore.instance.collection('Filter').doc(widget.email).update(
        {'isCourseOngoing': isOngoing, 'isCourseCompleted': isCompleted});
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
                image:NetworkImage(widget.courseDetails["ImageUrl"]),
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
                    if (!isCompleted.contains(widget.courseDetails["DocID"]) &&
                        !isOngoing.contains(widget.courseDetails["DocID"])) {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'Do you want to start this Course ?',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text(
                                  'Yes',
                                  style: TextStyle(color: Colors.blue),
                                ),
                                onPressed: () async {
                                  isOngoing.add(widget.courseDetails["DocID"]);
                                  setState(() {});
                                  updateFilter();
                                  Navigator.of(context).pop();

                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          CourseList(
                                        courseList: widget.courseDetails,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              TextButton(
                                child: Text(
                                  'No',
                                  style: TextStyle(color: Colors.blue),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => CourseList(
                            courseList: widget.courseDetails,
                          ),
                        ),
                      );
                    }
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
                    child: isCompleted.contains(widget.courseDetails["DocID"])
                        ? Text(
                            "Completed",
                            style: TextStyle(fontSize: 17),
                          )
                        : isOngoing.contains(widget.courseDetails["DocID"])
                            ? Text(
                                "On Progress",
                                style: TextStyle(fontSize: 17),
                              )
                            : Text(
                                "Open Course",
                                style: TextStyle(fontSize: 17),
                              ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
