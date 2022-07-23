// ignore_for_file: prefer_final_fields, file_names
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Addproduct extends StatefulWidget {
  const Addproduct({Key? key}) : super(key: key);

  @override
  State<Addproduct> createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> {
  String productName = "";
  String docID = "";
  String description = "";
  String price = "";
  String type = "select User Type";

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
        title: Text("Upload USER"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 15, right: 15, left: 15),
                child: Text(
                  "You Are Uploading User Details.",
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
                          EvaIcons.pieChartOutline,
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
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                            hint: Text(type),
                            items: <String>[
                              'kits',
                              'sensors',
                              'boards',
                              'leds',
                            ].map(
                              (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              },
                            ).toList(),
                            onChanged: (value) {
                              setState(
                                () {
                                  type = value!;
                                },
                              );
                            },
                          ),
                        ),
                      ),
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
                          EvaIcons.starOutline,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          productName = value;
                        },
                        decoration: InputDecoration(
                          hintText: "Product Name",
                          labelText: "Enter Product Name",
                          border: OutlineInputBorder(),
                        ),
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
                          EvaIcons.hashOutline,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          docID = value;
                        },
                        decoration: InputDecoration(
                          hintText: "Document ID",
                          labelText: "Enter Document ID",
                          border: OutlineInputBorder(),
                        ),
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
                        onChanged: (value) {
                          description = value;
                        },
                        decoration: InputDecoration(
                          hintText: "Description",
                          labelText: "Enter Description",
                          border: OutlineInputBorder(),
                        ),
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
                          EvaIcons.pricetagsOutline,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          price = value;
                        },
                        decoration: InputDecoration(
                          hintText: "Price",
                          labelText: "Enter product price",
                          border: OutlineInputBorder(),
                        ),
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
                            border: OutlineInputBorder(),
                          ),
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

// A flat icon Button  Which calls the function to upload the data into firebase

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Card(
                    color: Colors.deepOrange[400],
                    child: TextButton.icon(
                      onPressed: () {
                        if (productName != '' &&
                            type != '' &&
                            price != '' &&
                            description != '') {
                          FirebaseFirestore.instance
                              .collection('Products')
                              .doc(docID)
                              .set(
                            {
                              'productName': productName,
                              'type': type,
                              'description': description,
                              'Price': price,
                              "DocID":docID,
                              'ImageUrl': _controller.text.toString(),
                            },
                          );

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
                      ),
                    ),
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
