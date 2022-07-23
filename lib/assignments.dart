// ignore_for_file: sort_child_properties_last, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hidden_lamp/services/WebviewPage.dart';
import 'package:hidden_lamp/services/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'OnCompletedAssignments.dart';

class Assignments extends StatefulWidget {
  const Assignments({Key? key}) : super(key: key);
  @override
  State<Assignments> createState() => _AssignmentsState();
}

class _AssignmentsState extends State<Assignments> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    sharePreferances();
    super.initState();
  }

  var assignments = [];
  String name = "";
  String schoolName = "";
  String className = "";
  String type = "";
  String userImage = "";
  String search = "";
  List isCompleted = [];
  var filterData;
  String email = "";

  DrawerWidget drawerWidget = DrawerWidget();
  Future<void> getAssignmentData(String assignmentName) async {
    CollectionReference projectCollectionRef =
        FirebaseFirestore.instance.collection(assignmentName);
    QuerySnapshot querySnapshot = await projectCollectionRef.get();
    assignments = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(assignments);
    setState(() {});
  }

  sharePreferances() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? setStatus = prefs.getStringList("status");
    List<String>? setUserEmail = prefs.getStringList("email");
    setStatus == null ? setStatus = [] : print("List is not Empty");
    setUserEmail == null ? setUserEmail = [] : print("List is not Empty");
    var getEmail = prefs.getStringList("email");
    var getUserStatus = prefs.getStringList("status");

    email = getEmail![0];
    print(email);
    print(getUserStatus?[0]);
    DocumentReference projectCollectionRef =
        FirebaseFirestore.instance.collection('Users').doc(getEmail[0]);
    DocumentSnapshot documentSnapshot = await projectCollectionRef.get();
    print(documentSnapshot.get("userName"));
    name = documentSnapshot.get("userName");
    userImage = documentSnapshot.get("ImageUrl");
    schoolName = documentSnapshot.get("schoolName");
    className = documentSnapshot.get("class");
    className == "Courses"
        ? className = "Assignments"
        : className = documentSnapshot.get("class") + " assignment";
    type = documentSnapshot.get("type");
    getAssignmentData(className);
    getFilterDetails(getEmail[0]);
    setState(() {});
  }

  Future<void> getFilterDetails(String email) async {
    var collection = FirebaseFirestore.instance.collection('Filter');
    var docSnapshot = await collection.doc(email).get();
    if (docSnapshot.exists) {
      filterData = docSnapshot.data();
      isCompleted = filterData["isAssignmentCompleted"];
      print(isCompleted);
    }

    setState(() {});
  }

  updateFilter() {
    FirebaseFirestore.instance
        .collection('Filter')
        .doc(email)
        .update({'isAssignmentCompleted': isCompleted});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: drawerWidget.drawer(schoolName, userImage, name, type, context),
        key: _globalKey,
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
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: IconButton(
                          onPressed: () {
                            _globalKey.currentState?.openDrawer();
                          },
                          icon: Icon(
                            EvaIcons.list,
                            color: Colors.white,
                            size: 30,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 20),
                      child: Text(
                        "Assignments",
                        style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(splashColor: Colors.transparent),
                        child: TextField(
                          autofocus: false,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.search_rounded,
                              color: Colors.black45,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'search',
                            contentPadding: const EdgeInsets.only(
                                left: 26.0, bottom: 20.0, top: 20.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onChanged: (value) {
                            search = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Wrap(
                  children: [
                    ActionChip(
                      onPressed: () {},
                      elevation: 0.3,
                      backgroundColor: Colors.green,
                      avatar: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text('P'),
                      ),
                      label: Text('Pending',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    ActionChip(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                OncompletedAssignments(
                              email: email,
                              assignments: assignments,
                              oncompletedlist: isCompleted,
                            ),
                          ),
                        );
                      },
                      elevation: 0.3,
                      backgroundColor: Colors.white,
                      avatar: CircleAvatar(
                        backgroundColor: Colors.yellow,
                        child: Text('C',
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w700)),
                      ),
                      label: Text('Completed'),
                    ),
                  
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: assignments.length,
                  itemBuilder: (BuildContext context, int index) =>
                      (!isCompleted.contains(assignments[index]["DocId"]))
                          ? ((assignments[index]["assignmentName"])
                                  .toString()
                                  .toLowerCase()
                                  .startsWith(search))
                              ? GestureDetector(
                                  onTap: () {
                                    showDialog<void>(
                                      context: context,
                                      barrierDismissible: false,
                                      // user must tap button!
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            'Do you want to start this Assignment ?',
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          content: Text(
                                              "Once you Start you can't Retake your assignment"),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text(
                                                'Yes',
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ),
                                              onPressed: () async {
                                                isCompleted.add(
                                                    assignments[index]
                                                        ["DocId"]);
                                                updateFilter();
                                                getAssignmentData(className);
                                                Navigator.of(context).pop();
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        WebViewPage(
                                                      fileurl:
                                                          assignments[index]
                                                              ["AssignmentUrl"],

                                                      name: assignments[index]
                                                          ["assignmentName"],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                            TextButton(
                                              child: Text(
                                                'No',
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Center(
                                                  child: Text(
                                                "Assignment ${index + 1}",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Center(
                                                  child: Text(
                                                assignments[index]
                                                    ["assignmentName"],
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                assignments[index]
                                                    ["description"],
                                                textAlign: TextAlign.justify,
                                                maxLines: 3,
                                                style: TextStyle(
                                                    fontSize: 8,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Date: ${assignments[index]["date"]}",
                                                    style: TextStyle(
                                                        fontSize: 9,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "Time: ${assignments[index]["time"]}",
                                                    style: TextStyle(
                                                        fontSize: 9,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "Deadline: ${assignments[index]["deadline"]}",
                                                    style: TextStyle(
                                                        fontSize: 9,
                                                        fontWeight:
                                                            FontWeight.bold),
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
                              : Container()
                          : Container(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
