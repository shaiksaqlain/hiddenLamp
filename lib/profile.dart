// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hidden_lamp/piedata/pie_data.dart';
import 'package:hidden_lamp/services/sharedPreferances.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({
    Key? key,
  }) : super(key: key);
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    sharePreferances();
    super.initState();
  }

  bool loading = true;
  String name = "";
  String gender = "";
  String rollNumber = "";
  String monthlyReport = "";
  String section = "";
  String school = "";
  String className = "";
  String imageUrl = "";
  String email = "";
  Share share = Share();

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
        FirebaseFirestore.instance.collection('Users').doc(getEmail![0]);
    DocumentSnapshot documentSnapshot = await projectCollectionRef.get();
    print(documentSnapshot.get("userName"));
    print(documentSnapshot.data().toString());
    print(documentSnapshot.get("schoolName"));
    imageUrl = documentSnapshot.get("ImageUrl");
    className = documentSnapshot.get("class");
    gender = documentSnapshot.get("gender");
    monthlyReport = documentSnapshot.get("montlyReport");
    name = documentSnapshot.get("userName");
    rollNumber = documentSnapshot.get("rollNumber");
    school = documentSnapshot.get("schoolName");
    section = documentSnapshot.get("section");
    loading = false;
    setState(() {});
  }

  int touchedIndex = 0;

  List<PieChartSectionData> getSections(int touchedIndex) => PieData.data
      .asMap()
      .map<int, PieChartSectionData>((index, data) {
        final isTouched = index == touchedIndex;
        final double fontSize = isTouched ? 15 : 10;
        final double radius = isTouched ? 70 : 60;
        final value = PieChartSectionData(
          color: data.color,
          value: data.percent,
          title: '${data.percent}%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff),
          ),
        );

        return MapEntry(index, value);
      })
      .values
      .toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: loading
          ? LinearProgressIndicator()
          : section != "admin"
              ? Column(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        CircleAvatar(
                          backgroundImage: NetworkImage(imageUrl),
                          backgroundColor: Colors.white,
                          radius: 40,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 30,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xff26c6da),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Roll No : $rollNumber',
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                    Text(
                      "Courses",
                      style: TextStyle(
                          letterSpacing: 1,
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (var i = 0; i < 4; i++)
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: CircleAvatar(
                                        radius: 20,
                                        backgroundImage:
                                            AssetImage("assets/s$i.png"),
                                        backgroundColor: Colors.white70,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("Subject $i")
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Assignment Progress Chart",
                      style: TextStyle(
                          letterSpacing: 1,
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 110.0),
                      child: PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                            touchCallback: (pieTouchResponse) {
                              setState(() {
                                if (pieTouchResponse.touchInput
                                        is FlLongPressEnd ||
                                    pieTouchResponse.touchInput is FlPanEnd) {
                                  touchedIndex = -1;
                                } else {
                                  touchedIndex =
                                      pieTouchResponse.touchedSectionIndex;
                                }
                              });
                            },
                          ),
                          borderData: FlBorderData(show: false),
                          sectionsSpace: 0,
                          centerSpaceRadius: 30,
                          sections: getSections(touchedIndex),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Account overview",
                            style: TextStyle(
                                letterSpacing: 1,
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 15),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xfff4f7fb)),
                            child: Center(
                              child: ListTile(
                                  leading: Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                        color: Colors.deepPurple[50],
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Icon(
                                      EvaIcons.loaderOutline,
                                      size: 30,
                                      color: Colors.green,
                                    ),
                                  ),
                                  title: Text(
                                    "Section",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600),
                                  ),
                                  trailing: Text(
                                    section,
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        color: Colors.red),
                                  )),
                            ),
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            child: itemList(EvaIcons.clipboard, className, "0"),
                            onTap: () {},
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            child: itemList(EvaIcons.person, gender, "0"),
                            onTap: () {},
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {},
                            child: itemList(EvaIcons.flagOutline, school, "0"),
                          ),
                          SizedBox(height: 10),
                          // GestureDetector(
                          //   child: itemList(EvaIcons.checkmarkCircle2Outline,
                          //       "Monthly report", "1"),
                          //   onTap: () {
                          //     Navigator.of(context).push(
                          //       MaterialPageRoute(
                          //         builder: (BuildContext context) => WebViewPage(
                          //           fileurl: monthlyReport,
                          //           name: "Monthly Report",
                          //         ),
                          //       ),
                          //     );
                          //   },
                          // ),
                          // SizedBox(height: 10),

                          SizedBox(height: 10),
                          GestureDetector(
                            child:
                                itemList(EvaIcons.logOutOutline, "Logout", "1"),
                            onTap: () {
                              share.clearSharePreferances(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        CircleAvatar(
                          backgroundImage: NetworkImage(imageUrl),
                          backgroundColor: Colors.white,
                          radius: 40,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 30,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xff26c6da),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Type : $rollNumber',
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Account overview",
                            style: TextStyle(
                                letterSpacing: 1,
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            child: itemList(EvaIcons.person, gender, "0"),
                            onTap: () {},
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            child: itemList(
                                EvaIcons.bulbOutline, "Hidden Lamp", "0"),
                            onTap: () {},
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            child:
                                itemList(EvaIcons.logOutOutline, "Logout", "1"),
                            onTap: () {
                              showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Are you sure want to Logout?',
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
                                          share.clearSharePreferances(context);
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
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    ));
  }

  Widget itemList(icon, text, arrow) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Color(0xfff4f7fb)),
      child: Center(
        child: ListTile(
          leading: Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: Colors.deepPurple[50],
                borderRadius: BorderRadius.circular(5)),
            child: Icon(
              icon,
              size: 30,
              color: Color(0xff26c6da),
            ),
          ),
          title: Text(
            text,
            style:
                TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w600),
          ),
          trailing: arrow == "1"
              ? Icon(
                  EvaIcons.arrowIosForward,
                  color: Colors.black54,
                )
              : null,
        ),
      ),
    );
  }
}
