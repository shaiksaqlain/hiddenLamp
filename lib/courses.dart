import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hidden_lamp/OngoingCourse.dart';
import 'package:hidden_lamp/course.dart';
import 'package:hidden_lamp/onCompletedCourse.dart';
import 'package:hidden_lamp/services/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Courses extends StatefulWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  @override
  void initState() {
    sharePreferances();

    super.initState();
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  var courses = [];
  String className = "";
  String name = "";
  String schoolName = "";
  String type = "";
  String userImage = "";
  String search = "";
  String email = "";
  List isCompleted = [];
  List isOngoing = [];
  // ignore: prefer_typing_uninitialized_variables
  var filterData;


  DrawerWidget drawerWidget = DrawerWidget();

  Future<void> getCourseData(String className) async {
    print(className);
    CollectionReference projectCollectionRef =
        FirebaseFirestore.instance.collection(className);

    QuerySnapshot querySnapshot = await projectCollectionRef.get();
    courses = querySnapshot.docs.map((doc) => doc.data()).toList();

    print(courses);
    setState(() {});
  }

  Future<void> getFilterDetails(String email) async {
    var collection = FirebaseFirestore.instance.collection('Filter');
    var docSnapshot = await collection.doc(email).get();
    if (docSnapshot.exists) {
      filterData = docSnapshot.data();
      isCompleted = filterData["isCourseCompleted"];
      isOngoing = filterData["isCourseOngoing"];
    }
    print(isCompleted);
    print(isOngoing);

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
    print(getEmail);
    print(getUserStatus?[0]);

    DocumentReference projectCollectionRef =
        FirebaseFirestore.instance.collection('Users').doc(getEmail[0]);
    DocumentSnapshot documentSnapshot = await projectCollectionRef.get();
    print(documentSnapshot.get("userName"));
    name = documentSnapshot.get("userName");
    userImage = documentSnapshot.get("ImageUrl");
    schoolName = documentSnapshot.get("schoolName");
    type = documentSnapshot.get("type");
    className = documentSnapshot.get("class");
    getCourseData(className);
    getFilterDetails(email);
    setState(() {});
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
                        "Courses",
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
                        child: Text('A'),
                      ),
                      label: Text('All',
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
                            builder: (BuildContext context) => OngoingCourse(
                              email: email,
                              courseList: courses,
                              ongoingList: isOngoing,
                            ),
                          ),
                        );
                      },
                      elevation: 0.3,
                      backgroundColor: Colors.white,
                      avatar: CircleAvatar(
                        backgroundColor: Colors.yellow,
                        child: Text('O',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      ),
                      label: Text('Ongoing'),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    ActionChip(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => OncompletedCourse(
                              email: email,
                              courseList: courses,
                              oncompletedlist: isCompleted,
                            ),
                          ),
                        );
                      },
                      elevation: 0.3,
                      backgroundColor: Colors.white,
                      avatar: CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text('C'),
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
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: courses.length,
                    itemBuilder: (BuildContext context, int index) =>
                        (courses[index]["CourseName"])
                                .toString()
                                .toLowerCase()
                                .startsWith(search)
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {

                                    
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Course(
                                          email: email,
                                          courseDetails: courses[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Center(
                                      child: Image.network(
                                    courses[index]["ImageUrl"],
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
