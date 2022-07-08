// ignore_for_file: file_names, prefer_final_fields

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddReel extends StatefulWidget {
  const AddReel({Key? key}) : super(key: key);

  @override
  State<AddReel> createState() => _AddReelState();
}

class _AddReelState extends State<AddReel> {
  String contenttype = "Select Content Type";
  String content = "";

  File? image;
  TextEditingController _controller = TextEditingController();

  TextEditingController _contentController = TextEditingController();

  Future pickImage(bool isContentImage) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } catch (e) {
      print('Failed to pick image: $e');
    }
    uploadImage(image!, isContentImage);
  }

  Future uploadImage(File image, bool isContentImage) async {
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
        isContentImage
            ? {_contentController.text = downloadUrl, content = downloadUrl}
            : {_controller.text = downloadUrl};

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
        title: Text("Upload Reel"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 15, right: 15, left: 15),
                child: Text(
                  "You Are Uploading Reel Details.",
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
                          EvaIcons.personAddOutline,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(
                              5,
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                            hint: Text(contenttype),
                            items: <String>[
                              'image',
                              'text',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                contenttype = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              contenttype == "text"
                  ? Padding(
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
                                content = value;
                              },
                              decoration: InputDecoration(
                                  hintText: "Content",
                                  labelText: "Enter Content",
                                  border: OutlineInputBorder()),
                            ),
                          )
                        ],
                      ),
                    )
                  : Padding(
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
                                controller: _contentController,
                                maxLines: null,
                                decoration: InputDecoration(
                                    hintText: "Content Image Link",
                                    labelText: "Content Image Link",
                                    border: OutlineInputBorder()),
                                keyboardType: TextInputType.multiline),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                                onPressed: () {
                                  pickImage(true);
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
                            pickImage(false);
                          },
                          icon: Icon(Icons.upload)),
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
                          if (content != '' && contenttype != '') {
                            FirebaseFirestore.instance
                                .collection('Reels')
                                .doc()
                                .set({
                              'Content': content,
                              'ContentType': contenttype,
                              'ImageURL': _controller.text.toString(),
                            });

                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("User Added Successfully"),
                              ),
                            );
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
