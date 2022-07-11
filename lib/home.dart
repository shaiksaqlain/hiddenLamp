// ignore_for_file: sized_box_for_whitespace, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hidden_lamp/course.dart';
import 'package:hidden_lamp/project.dart';
import 'package:hidden_lamp/services/drawer.dart';
import 'package:hidden_lamp/services/sharedPreferances.dart';
import 'package:hidden_lamp/services/storyView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/storyView.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  DrawerWidget drawerWidget = DrawerWidget();
  var popularCourses = [];
  var reels = [];
  var projects = [];
  String name = "";
  String type = "";
  String userImage = "";
  String schoolName = "";
  Share share = Share();
  bool isRefreshing = false;

  @override
  initState() {
    getCourseData();
    getReelsData();
    getprojectsData();
    sharePreferances();
    super.initState();
  }

  Future<void> getCourseData() async {
    CollectionReference coursesCollectionRef =
        FirebaseFirestore.instance.collection('PopularCourses');
    QuerySnapshot querySnapshot = await coursesCollectionRef.get();
    popularCourses = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(popularCourses[0]);
  }

  Future<void> getReelsData() async {
    CollectionReference reelsCollectionRef =
        FirebaseFirestore.instance.collection('Reels');
    QuerySnapshot querySnapshot = await reelsCollectionRef.get();

    reels = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(reels[0]);
    setState(() {});
  }

  Future<void> getprojectsData() async {
    CollectionReference projectCollectionRef =
        FirebaseFirestore.instance.collection('Projects');

    QuerySnapshot querySnapshot = await projectCollectionRef.get();

    projects = querySnapshot.docs.map((doc) => doc.data()).toList();

    print(projects[0]);
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
    print(getEmail);
    print(getUserStatus?[0]);

    DocumentReference projectCollectionRef =
        FirebaseFirestore.instance.collection('Users').doc(getEmail?[0]);
    DocumentSnapshot documentSnapshot = await projectCollectionRef.get();
    print(documentSnapshot.get("userName"));
    name = documentSnapshot.get("userName");
    userImage = documentSnapshot.get("ImageUrl");
    schoolName = documentSnapshot.get("schoolName");
    type = documentSnapshot.get("type");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return !isRefreshing
        ? GestureDetector(
            onVerticalDragDown: (details) {
              getCourseData();
              getReelsData();
              getprojectsData();
            },
            child: Scaffold(
                drawer: drawerWidget.drawer(
                    schoolName, userImage, name, type, context),
                key: globalKey,
                body: Column(mainAxisSize: MainAxisSize.max, children: [
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
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  globalKey.currentState?.openDrawer();
                                },
                                icon: Icon(
                                  EvaIcons.list,
                                  color: Colors.white,
                                )),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      // Container(
                                      //   decoration: BoxDecoration(
                                      //     color: Color(0xff0097a7),
                                      //     borderRadius:
                                      //         BorderRadius.circular(7),
                                      //   ),
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.all(8.0),
                                      //     child: Icon(
                                      //       EvaIcons.shoppingBag,
                                      //       color: Colors.white,
                                      //     ),
                                      //   ),
                                      // ),
                                      // SizedBox(
                                      //   width: 10,
                                      // ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xff0097a7),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.notifications,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "Hi, $name 👋",
                            style: TextStyle(
                                letterSpacing: 1,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: const [
                              Text(
                                "Let's start learning!",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Popular Course",
                              style: TextStyle(fontSize: 20),
                            ),
                            TextButton(onPressed: () {}, child: Text("See all"))
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: popularCourses.length,
                      itemBuilder: (BuildContext context, int index) => Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => Course(
                                  courseDetails: popularCourses[index],
                                ),
                              ),
                            );
                          },
                          child: Center(
                            child: Container(
                                width: 150,
                                child: Image.network(
                                    popularCourses[index]["ImageUrl"])),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "HL Reels",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: reels.length,
                      itemBuilder: (BuildContext context, int index) => Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      StoryViewPage(
                                    storyDetails: reels[index],
                                  ),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  NetworkImage(reels[index]["ImageURL"]),
                              backgroundColor: Colors.white70,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Popular Projects",
                              style: TextStyle(fontSize: 20),
                            ),
                            TextButton(onPressed: () {}, child: Text("See all"))
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: projects.length,
                      itemBuilder: (BuildContext context, int index) => Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => Project(
                                  projectDetails: projects[index],
                                ),
                              ),
                            );
                          },
                          child: Center(
                              child: Image.network(
                            projects[index]["ImageUrl"],
                            width: 150,
                          )),
                        ),
                      ),
                    ),
                  ),
                ])))
        : Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width, //70.0,
            height: MediaQuery.of(context).size.height, //70.0,
            child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text(
                      "Loading please wait...!",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                    )
                  ],
                ))),
          );
  }
}
