// ignore_for_file: sort_child_properties_last, file_names, prefer_typing_uninitialized_variables
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateReel extends StatefulWidget {
  const UpdateReel({Key? key}) : super(key: key);
  @override
  State<UpdateReel> createState() => _UpdateReelState();
}

class _UpdateReelState extends State<UpdateReel> {
  @override
  void initState() {
    getReelsData();
    super.initState();
  }

  var reels = [];
  String search = "";
  Future<void> getReelsData() async {
    CollectionReference projectCollectionRef =
        FirebaseFirestore.instance.collection("Reels");

    QuerySnapshot querySnapshot = await projectCollectionRef.get();
    reels = querySnapshot.docs.map((doc) => doc.data()).toList();

    print(reels);

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
                        "Reels",
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
                  itemCount: reels.length,
                  itemBuilder: (BuildContext context, int index) => ((reels[
                              index]["label"])
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
                                  "Reel ${index + 1}",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 10,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Label : ${reels[index]["label"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                                reels[index]["ContentType"] == "image"
                                    ? Container(
                                        padding: EdgeInsets.all(20),
                                        child: Image.network(
                                            reels[index]["Content"]),
                                      )
                                    : Text(
                                        "Content : ${reels[index]["Content"]}"),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                                                          .collection("Reels")
                                                          .doc(reels[index]
                                                              ["DocID"])
                                                          .delete();
                                                      setState(
                                                        () {
                                                          getReelsData();
                                                        },
                                                      );
                                                      Navigator.of(context)
                                                          .pop();
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
                                                          EditReel(
                                                            reels: reels,
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
class EditReel extends StatefulWidget {
  const EditReel({Key? key, this.reels, this.index}) : super(key: key);

  final reels;
  final index;

  @override
  State<EditReel> createState() => _Editreelstate();
}

class _Editreelstate extends State<EditReel> {
  TextEditingController contenttype = TextEditingController();

  TextEditingController label = TextEditingController();
  TextEditingController docID = TextEditingController();
  TextEditingController content = TextEditingController();
  TextEditingController className = TextEditingController();

  File? image;
  TextEditingController imageController = TextEditingController();

  @override
  void initState() {
    contenttype.text = widget.reels[widget.index]['ContentType'];
    label.text = widget.reels[widget.index]['label'];
    docID.text = widget.reels[widget.index]['DocID'];
    content.text = widget.reels[widget.index]['Content'];
    imageController.text = widget.reels[widget.index]['ImageURL'];

    super.initState();
  }

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
            ? {
                content.text = downloadUrl,
              }
            : {imageController.text = downloadUrl};

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
                            hint: Text(contenttype.text),
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
                                contenttype.text = value!;
                              });
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
                          EvaIcons.text,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: label,
                        onSubmitted: (value) {
                          label.text = value;
                        },
                        decoration: InputDecoration(
                            hintText: "Label",
                            labelText: "Enter label (1 word)",
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
                            hintText: "REEl ID",
                            labelText: "REEL ID",
                            border: OutlineInputBorder()),
                      ),
                    )
                  ],
                ),
              ),

              contenttype.text == "text"
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
                              controller: content,
                              onSubmitted: (value) {
                                content.text = value;
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
                                controller: content,
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
                          if (content.text != '' && contenttype.text != '') {
                            FirebaseFirestore.instance
                                .collection('Reels')
                                .doc(docID.text)
                                .update({
                              'Content': content.text.toString(),
                              'label': label.text.toString(),
                              'ContentType': contenttype.text.toString(),
                              'ImageURL': imageController.text.toString(),
                              'DocID': docID.text.toString()
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
