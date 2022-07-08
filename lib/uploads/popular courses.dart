// ignore_for_file: file_names, prefer_final_fields

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPopularCourse extends StatefulWidget {
  const AddPopularCourse({Key? key}) : super(key: key);

  @override
  State<AddPopularCourse> createState() => _AddPopularCourseState();
}

class _AddPopularCourseState extends State<AddPopularCourse> {
  String autherName = "";
  String courseName = "";
  List episodeDuration = [];
  List episodeNames = [];
  List epiodesUrls = [];
  String totalEpisodes = "";

  String language = "";
  String rating = "";
  String registeredStudents = "";
  String subtitle = "";
  String discription = "";
  DateTime dateToday = DateTime.now();
  File? image;
  TextEditingController _controller = TextEditingController();

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } catch (e) {
      print('Failed to pick image: $e');
    }
    uploadImage(image!);
  }

  Future uploadImage(File image) async {
    final firebaseStorage = FirebaseStorage.instance;

    // ignore: unnecessary_null_comparison
    if (image != null) {
      //Upload to Firebase
      var snapshot = await firebaseStorage
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}')
          .putFile(image);

      var downloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        _controller.text = downloadUrl;
        print(downloadUrl);
      });
    } else {
      print('No Image Path Received');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff26c6da),
        centerTitle: true,
        title: Text("Upload Course"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 15, right: 15, left: 15),
                child: Text(
                  "You Are Uploading Course Details",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600]),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Icon(
                          EvaIcons.book,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          courseName = value;
                        },
                        decoration: InputDecoration(
                            hintText: "Course Name",
                            labelText: "Course name",
                            border: OutlineInputBorder()),
                      ),
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Icon(
                          EvaIcons.book,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          autherName = value;
                        },
                        decoration: InputDecoration(
                            hintText: "Auther Name",
                            labelText: "Auther name",
                            border: OutlineInputBorder()),
                      ),
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Icon(
                          EvaIcons.globe,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          totalEpisodes = value;
                        },
                        decoration: InputDecoration(
                            hintText: "Total no. of Episodes",
                            labelText: "No of episodes",
                            border: OutlineInputBorder()),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Icon(
                          EvaIcons.activity,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          episodeDuration = value.split(",");
                        },
                        decoration: InputDecoration(
                            hintText: "Episode Durations seperate by comma(,)",
                            labelText: "Episode Durations",
                            border: OutlineInputBorder()),
                      ),
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Icon(
                          EvaIcons.text,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          episodeNames = value.split(",");
                        },
                        decoration: InputDecoration(
                            hintText: "Episode Names seperate by comma(,)",
                            labelText: "Episode Names",
                            border: OutlineInputBorder()),
                      ),
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Icon(
                          EvaIcons.globe,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          episodeDuration = value.split(",");
                        },
                        decoration: InputDecoration(
                            hintText:
                                "Episode Urls Durations seperate by comma(,)",
                            labelText: "Episode Url's",
                            border: OutlineInputBorder()),
                      ),
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Icon(
                          EvaIcons.text,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          registeredStudents = value;
                        },
                        decoration: InputDecoration(
                            hintText: "Registerd students",
                            labelText: "Registerd students",
                            border: OutlineInputBorder()),
                      ),
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Icon(
                          EvaIcons.layersOutline,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                          maxLines: null,
                          onChanged: (value) {
                            language = value;
                          },
                          decoration: InputDecoration(
                              hintText: "Language's",
                              labelText: "Language's",
                              border: OutlineInputBorder()),
                          keyboardType: TextInputType.multiline),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Icon(
                          Icons.arrow_circle_up_sharp,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                          maxLines: null,
                          onChanged: (value) {
                            value =
                                "${dateToday.day}/${dateToday.month}/${dateToday.year}";
                          },
                          decoration: InputDecoration(
                              hintText:
                                  "${dateToday.day}/${dateToday.month}/${dateToday.year}",
                              labelText:
                                  "${dateToday.day}/${dateToday.month}/${dateToday.year}",
                              border: OutlineInputBorder()),
                          keyboardType: TextInputType.multiline),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Icon(
                          Icons.rate_review,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                          maxLines: null,
                          onChanged: (value) {
                            rating = value;
                          },
                          decoration: InputDecoration(
                              hintText: "Rating",
                              labelText: "Rating",
                              border: OutlineInputBorder()),
                          keyboardType: TextInputType.multiline),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Icon(
                          EvaIcons.imageOutline,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: TextField(
                          controller: _controller,
                          maxLines: null,
                          decoration: InputDecoration(
                              hintText: "Image Link",
                              labelText: "Image Link",
                              border: OutlineInputBorder()),
                          keyboardType: TextInputType.multiline),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: () {
                            pickImage();
                          },
                          icon: Icon(Icons.upload)),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Icon(
                          EvaIcons.starOutline,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          subtitle = value;
                        },
                        decoration: InputDecoration(
                            hintText: "SubTitle",
                            labelText: "SubTitle",
                            border: OutlineInputBorder()),
                      ),
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Icon(
                          EvaIcons.personOutline,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          discription = value;
                        },
                        decoration: InputDecoration(
                            hintText: "Discription",
                            labelText: "Discription",
                            border: OutlineInputBorder()),
                      ),
                    )
                  ],
                ),
              ),
// A flat icon Button  Which calls the function to upload the data into firebase

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Card(
                    color: Colors.deepOrange[400],
                    child: TextButton.icon(

                        //checking the fields to promte the user if its Empty

                        onPressed: () {
                          if (autherName != '' &&
                              courseName != '' &&
                              language != '' &&
                              rating != '' &&
                              registeredStudents != '' &&
                              subtitle != '' &&
                              totalEpisodes != '') {
                            try {
                              FirebaseFirestore.instance
                                  .collection("PopularCourses")
                                  .doc()
                                  .set({
                                'Author': autherName,
                                'CourseName': courseName,
                                'EpisodeDuration': episodeDuration,
                                'Episodes': episodeNames,
                                'EpisodesUrl': epiodesUrls,
                                'ImageUrl': _controller.text.toString(),
                                'Language': language,
                                'LastUpdate':
                                    "${dateToday.day}/${dateToday.month}/${dateToday.year}",
                                'Rating': rating,
                                'RegisteredStudents': registeredStudents,
                                'SubTitle': subtitle,
                                'TotalEpisodes': int.parse(totalEpisodes),
                                'description': discription,
                              });
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Course Added Successfully"),
                                ),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Error try again"),
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("All fields are needed"),
                              ),
                            );
                          }
                        },
                        icon: Icon(EvaIcons.upload, color: Colors.white),
                        label: Text(
                          "Upload",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
