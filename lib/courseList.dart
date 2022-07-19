// ignore_for_file: file_names

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hidden_lamp/services/WebviewPage.dart';
// ignore: unused_import
import 'package:hidden_lamp/services/videoPlayer.dart';

class CourseList extends StatefulWidget {
  const CourseList({Key? key, this.courseList}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final courseList;
  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  @override
  void initState() {
    super.initState();
    print(widget.courseList);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
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
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
                    child: Center(
                      child: Text(
                        "Episodes",
                        style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: widget.courseList["TotalEpisodes"],
                  itemBuilder: (BuildContext context, int index) =>
                      ExpansionTile(
                    textColor: Colors.black,
                    title: Text(
                      "Episode ${index + 1}",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    trailing: Text(widget.courseList["EpisodeDuration"][index]),
                    subtitle: Text(widget.courseList["Episodes"][index]),
                    leading: Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: Colors.deepPurple[50],
                          borderRadius: BorderRadius.circular(5)),
                      child: Icon(EvaIcons.videoOutline,
                          size: 30, color: Colors.deepPurple[300]),
                    ),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton.icon(
                              onPressed: () {
                                Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) => WebViewPage(
                                    fileurl: widget.courseList["EpisodesUrl"]
                                        [index],
                                    name: "Hidden Lamp")));
                              },
                              icon: Icon(
                                EvaIcons.videoOutline,
                                color: Colors.red[600],
                              ),
                              label: Text("Video")),
                          TextButton.icon(
                              onPressed: () {
                             Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) => WebViewPage(
                                    fileurl: widget.courseList["TheoryEpisodes"]
                                        [index],
                                    name: "Hidden Lamp")));
                              },
                              icon: Icon(
                                EvaIcons.text,
                                color: Colors.orange[400],
                              ),
                              label: Text("Theory")),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

















