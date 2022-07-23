// ignore_for_file: sort_child_properties_last, file_names, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdatePopularCourse extends StatefulWidget {
  const UpdatePopularCourse({Key? key}) : super(key: key);
  @override
  State<UpdatePopularCourse> createState() => _UpdatePopularCourseState();
}

class _UpdatePopularCourseState extends State<UpdatePopularCourse> {
  @override
  void initState() {
    getPopularCourseData();
    super.initState();
  }

  var popularCourses = [];
  String search = "";

  Future<void> getPopularCourseData() async {
    CollectionReference projectCollectionRef =
        FirebaseFirestore.instance.collection("PopularCourses");

    QuerySnapshot querySnapshot = await projectCollectionRef.get();
    popularCourses = querySnapshot.docs.map((doc) => doc.data()).toList();

    print(popularCourses);

    setState(() {});
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
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          EvaIcons.arrowIosBack,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 20),
                      child: Text(
                        "popularCourses Data",
                        style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.white,
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
                          onSubmitted: ((value) {
                            search = value;
                            setState(() {});
                          }),
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: popularCourses.length,
                  itemBuilder: (BuildContext context, int index) =>
                      ((popularCourses[index]["CourseName"])
                              .toString()
                              .toLowerCase()
                              .startsWith(search))
                          ? Card(
                              elevation: 0.3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                side: BorderSide(
                                  color: Colors.grey.withOpacity(0.4),
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Course ${index + 1}",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 10,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      popularCourses[index]["CourseName"],
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "TotalEpisodes : ${popularCourses[index]["Author"]}",
                                      textAlign: TextAlign.justify,
                                      maxLines: 3,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Document ID : ${popularCourses[index]["DocID"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Language : ${popularCourses[index]["Language"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Last Update : ${popularCourses[index]["LastUpdate"]}",
                                      textAlign: TextAlign.justify,
                                      maxLines: 3,
                                      style: TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Rating : ${popularCourses[index]["Rating"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Registered Students : ${popularCourses[index]["RegisteredStudents"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "SubTitle : ${popularCourses[index]["SubTitle"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Description : ${popularCourses[index]["description"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        TextButton.icon(
                                            onPressed: () {
                                              showDialog<void>(
                                                context: context,
                                                barrierDismissible: false,
                                                // user must tap button!
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                      'Are you sure want to Remove?',
                                                      style: TextStyle(
                                                          color: Colors.black45,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: Text(
                                                          'Yes',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue),
                                                        ),
                                                        onPressed: () async {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "popularCourses")
                                                              .doc(popularCourses[
                                                                      index][
                                                                  "phoneNumber"])
                                                              .delete();
                                                          setState(
                                                            () {
                                                              getPopularCourseData();
                                                            },
                                                          );
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: Text(
                                                          'No',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            icon: Icon(
                                              EvaIcons.personRemoveOutline,
                                              color: Colors.red[600],
                                            ),
                                            label: Text("Remove")),
                                        TextButton.icon(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          EditPopularcourses(
                                                            popularCourses:
                                                                popularCourses,
                                                            index: index,
                                                          )));
                                            },
                                            icon: Icon(
                                              EvaIcons.edit2Outline,
                                              color: Colors.orange[400],
                                            ),
                                            label: Text("Edit")),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
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

// ignore: duplicate_ignore
class EditPopularcourses extends StatefulWidget {
  const EditPopularcourses({Key? key, this.popularCourses, this.index})
      : super(key: key);

  final popularCourses;
  final index;

  @override
  State<EditPopularcourses> createState() => _EditpopularCoursesstate();
}

class _EditpopularCoursesstate extends State<EditPopularcourses> {
  TextEditingController courseName = TextEditingController();

  TextEditingController autherName = TextEditingController();
  TextEditingController language = TextEditingController();
  TextEditingController rating = TextEditingController();
  TextEditingController registeredStudents = TextEditingController();
  TextEditingController subtitle = TextEditingController();
  TextEditingController totalEpisodes = TextEditingController();
  TextEditingController discription = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController docID = TextEditingController();
  TextEditingController episodeDurationControler = TextEditingController();
  TextEditingController episodeNamesControler = TextEditingController();
  TextEditingController epiodesUrlsControler = TextEditingController();
  TextEditingController thoeryEpisodesUrlControler = TextEditingController();
  File? image;
  TextEditingController imageController = TextEditingController();
  DateTime dateToday = DateTime.now();

  @override
  void initState() {
    autherName.text = widget.popularCourses[widget.index]['Author'];
    courseName.text = widget.popularCourses[widget.index]['CourseName'];
    language.text = widget.popularCourses[widget.index]['Language'];
    rating.text = widget.popularCourses[widget.index]['Rating'];
    registeredStudents.text =
        widget.popularCourses[widget.index]['RegisteredStudents'];
    subtitle.text = widget.popularCourses[widget.index]['SubTitle'];
    totalEpisodes.text =
        widget.popularCourses[widget.index]['TotalEpisodes'].toString();
    discription.text = widget.popularCourses[widget.index]['description'];
    phone.text = widget.popularCourses[widget.index]['phoneNumber'];
    imageController.text = widget.popularCourses[widget.index]['ImageUrl'];
    docID.text = widget.popularCourses[widget.index]['DocID'];

    episodeDurationControler.text = widget.popularCourses[widget.index]
            ['EpisodeDuration']
        .toString()
        .substring(
            1,
            widget.popularCourses[widget.index]['EpisodeDuration']
                    .toString()
                    .length -
                1);
    episodeNamesControler.text = widget.popularCourses[widget.index]['Episodes']
        .toString()
        .substring(
            1,
            widget.popularCourses[widget.index]['Episodes'].toString().length -
                1);
    thoeryEpisodesUrlControler.text = widget.popularCourses[widget.index]
            ['TheoryEpisodes']
        .toString()
        .substring(
            1,
            widget.popularCourses[widget.index]['TheoryEpisodes']
                    .toString()
                    .length -
                1);
    epiodesUrlsControler.text =
        widget.popularCourses[widget.index]['EpisodesUrl'].toString().substring(
            1,
            widget.popularCourses[widget.index]['EpisodesUrl']
                    .toString()
                    .length -
                1);
    ;
    ;

    super.initState();
  }

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
        imageController.text = downloadUrl;
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
        title: Text("Update USER"),
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
                        controller: courseName,
                        onSubmitted: (value) {
                          courseName.text = value;
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
                          EvaIcons.starOutline,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: docID,
                        onSubmitted: (value) {
                          docID.text = value;
                        },
                        decoration: InputDecoration(
                            hintText: "Enter Document ID",
                            labelText: "Document ID",
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
                        controller: autherName,
                        onSubmitted: (value) {
                          autherName.text = value;
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
                        controller: totalEpisodes,
                        onSubmitted: (value) {
                          totalEpisodes.text = value;
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
                        controller: episodeDurationControler,
                        onSubmitted: (value) {
                          episodeDurationControler.text = value;
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
                        controller: episodeNamesControler,
                        onSubmitted: (value) {
                          episodeNamesControler.text = value;
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
                          EvaIcons.filmOutline,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: epiodesUrlsControler,
                        onSubmitted: (value) {
                          epiodesUrlsControler.text = value;
                        },
                        decoration: InputDecoration(
                            hintText: "Video Urls seperate by comma(,)",
                            labelText: "Video Url's",
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
                          EvaIcons.textOutline,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: thoeryEpisodesUrlControler,
                        onSubmitted: (value) {
                          thoeryEpisodesUrlControler.text = value;
                        },
                        decoration: InputDecoration(
                            hintText:
                                "Thoery Episode Urls seperate by comma(,)",
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
                          EvaIcons.personAddOutline,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: registeredStudents,
                        onSubmitted: (value) {
                          registeredStudents.text = value;
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
                          controller: language,
                          maxLines: null,
                          onSubmitted: (value) {
                            language.text = value;
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
                          onSubmitted: (value) {
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
                          controller: rating,
                          maxLines: null,
                          onSubmitted: (value) {
                            rating.text = value;
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
                          controller: imageController,
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
                        controller: subtitle,
                        onSubmitted: (value) {
                          subtitle.text = value;
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
                        controller: discription,
                        onSubmitted: (value) {
                          discription.text = value;
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
                          if (courseName.text != '' &&
                              docID.text != '' &&
                              autherName.text != '' &&
                              autherName.text != '' &&
                              autherName.text != '' &&
                              autherName.text != '' &&
                              autherName.text != '') {
                            try {
                              FirebaseFirestore.instance
                                  .collection("PopularCourses")
                                  .doc(docID.text)
                                  .update({
                                'Author': autherName.text.toString(),
                                'CourseName': courseName.text.toString(),
                                'ImageUrl': imageController.text.toString(),
                                'Language': language.text.toString(),
                                'LastUpdate':
                                    "${dateToday.day}/${dateToday.month}/${dateToday.year}",
                                'Rating': rating.text.toString(),
                                'RegisteredStudents':
                                    registeredStudents.text.toString(),
                                'SubTitle': subtitle.text.toString(),
                                'TotalEpisodes':
                                    int.parse(totalEpisodes.text.toString()),
                                'description': discription.text.toString(),
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
