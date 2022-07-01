// ignore_for_file: sized_box_for_whitespace, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hidden_lamp/admin_panel.dart';
import 'package:hidden_lamp/course.dart';
import 'package:hidden_lamp/project.dart';
import 'package:hidden_lamp/services/WebviewPage.dart';
import 'package:hidden_lamp/services/drawer.dart';
import 'package:hidden_lamp/services/sharedPreferances.dart';
import 'package:hidden_lamp/services/storyView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
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

  @override
  initState() {
    getCourseData();
    getReelsData();
    getprojectsData();
    sharePreferances();
    super.initState();
  }

  CollectionReference coursesCollectionRef =
      FirebaseFirestore.instance.collection('PopularCourses');

  CollectionReference reelsCollectionRef =
      FirebaseFirestore.instance.collection('Reels');

  CollectionReference projectCollectionRef =
      FirebaseFirestore.instance.collection('Projects');

  Future<void> getCourseData() async {
    QuerySnapshot querySnapshot = await coursesCollectionRef.get();
    popularCourses = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(popularCourses[0]);
    setState(() {});
  }

  Future<void> getReelsData() async {
    QuerySnapshot querySnapshot = await reelsCollectionRef.get();

    reels = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(reels[0]);
    setState(() {});
  }

  Future<void> getprojectsData() async {
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
    return Scaffold(
      drawer: drawerWidget.drawer(schoolName, userImage, name, type, context),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xff0097a7),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  EvaIcons.shoppingBag,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xff0097a7),
                                borderRadius: BorderRadius.circular(7),
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
          flex: 1,
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
                      width: 140,
                      child: Image.network(popularCourses[index]["ImageUrl"])),
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
        Row(
          children: [
            for (var i = 0; i < reels.length; i++)
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => StoryViewPage(
                            storyDetails: reels[i],
                          ),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(reels[i]["ImageURL"]),
                      backgroundColor: Colors.white70,
                    ),
                  ),
                ),
              ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
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
          flex: 1,
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
                child: Card(
                  elevation: 0.3,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.4),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: Image.network(
                        projects[index]["ImageUrl"],
                        width: 170,
                        height: 100,
                      )),
                      Text(projects[index]["ProjectName"]),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
