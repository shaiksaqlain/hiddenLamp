// ignore_for_file: sort_child_properties_last, file_names, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProject extends StatefulWidget {
  const UpdateProject({Key? key}) : super(key: key);
  @override
  State<UpdateProject> createState() => _UpdateProjectState();
}

class _UpdateProjectState extends State<UpdateProject> {
  @override
  void initState() {
    getProjectData();
    super.initState();
  }

  var projects = [];
  String search = "";

  Future<void> getProjectData() async {
    CollectionReference projectCollectionRef =
        FirebaseFirestore.instance.collection("Projects");

    QuerySnapshot querySnapshot = await projectCollectionRef.get();
    projects = querySnapshot.docs.map((doc) => doc.data()).toList();

    print(projects);

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
                        "Projects Data",
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
                  itemCount: projects.length,
                  itemBuilder: (BuildContext context, int index) => ((projects[
                              index]["ProjectName"])
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
                                  "Product ${index + 1}",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 10,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  projects[index]["ProjectName"],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Type : ${projects[index]["Author"]}",
                                  textAlign: TextAlign.justify,
                                  maxLines: 3,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Price : ${projects[index]["Rating"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Description : ${projects[index]["Discription"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Document ID : ${projects[index]["DocID"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "Last Update: ${projects[index]["LastUpdate"]}",
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
                                            builder: (BuildContext context) {
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
                                                          color: Colors.blue),
                                                    ),
                                                    onPressed: () async {
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              "projects")
                                                          .doc(projects[index]
                                                              ["DocID"])
                                                          .delete();
                                                      setState(
                                                        () {
                                                          getProjectData();
                                                        },
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
                                          EvaIcons.fileRemoveOutline,
                                          color: Colors.red[600],
                                        ),
                                        label: Text("Remove")),
                                    TextButton.icon(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          EditProduct(
                                                            projects: projects,
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
class EditProduct extends StatefulWidget {
  const EditProduct({Key? key, this.projects, this.index}) : super(key: key);

  final projects;
  final index;

  @override
  State<EditProduct> createState() => _Editprojectstate();
}

class _Editprojectstate extends State<EditProduct> {
  DateTime dateToday = DateTime.now();
  TextEditingController projectName = TextEditingController();
  TextEditingController docID = TextEditingController();
  TextEditingController autherName = TextEditingController();
  TextEditingController rating = TextEditingController();
  TextEditingController lastUpdate = TextEditingController();
  TextEditingController description = TextEditingController();

  File? image;
  TextEditingController imageController = TextEditingController();

  @override
  void initState() {
    projectName.text = widget.projects[widget.index]['ProjectName'];
    docID.text = widget.projects[widget.index]['DocID'];
    autherName.text = widget.projects[widget.index]['Author'];
    rating.text = widget.projects[widget.index]['Rating'];
    description.text = widget.projects[widget.index]['Discription'];
    lastUpdate.text = widget.projects[widget.index]['type'];
    imageController.text = widget.projects[widget.index]['ImageUrl'];
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
        title: Text("Update Product"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 15, right: 15, left: 15),
                child: Text(
                  "You Are Uploading project Details",
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
                        controller: projectName,
                        onSubmitted: (value) {
                          projectName.text = value;
                        },
                        decoration: InputDecoration(
                            hintText: "Project Name",
                            labelText: "Project name",
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
                            hintText: "Document ID",
                            labelText: "Enter Document ID",
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
                          EvaIcons.personOutline,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: description,
                        onSubmitted: (value) {
                          description.text = value;
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
                          if (autherName.text != '' &&
                              projectName.text != '' &&
                              rating.text != '') {
                            try {
                              FirebaseFirestore.instance
                                  .collection("Projects")
                                  .doc(docID.text.toString())
                                  .update(
                                {
                                  'Author': autherName.text.toString(),
                                  'ProjectName': projectName.text.toString(),
                                  'ImageUrl': imageController.text.toString(),
                                  'LastUpdate':
                                      "${dateToday.day}/${dateToday.month}/${dateToday.year}",
                                  'Rating': rating.text.toString(),
                                  'Discription': description.text.toString(),
                                  'DocID': docID.text.toString()
                                },
                              );
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
