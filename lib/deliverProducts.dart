// ignore_for_file: sort_child_properties_last, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class DeliveryPage extends StatefulWidget {
  const DeliveryPage({Key? key}) : super(key: key);
  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  @override
  void initState() {
    getAssignmentData();
    super.initState();
  }

  var products = [];

  Future<void> getAssignmentData() async {
    CollectionReference projectCollectionRef =
        FirebaseFirestore.instance.collection("deliveryProduct");

    QuerySnapshot querySnapshot = await projectCollectionRef.get();
    products = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(products[0]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
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
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 20),
                  child: Text(
                    "Delivery Page",
                    style: TextStyle(
                        letterSpacing: 1, color: Colors.white, fontSize: 25),
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
              children: const [
                Chip(
                  elevation: 0.3,
                  backgroundColor: Colors.green,
                  avatar: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text('P'),
                  ),
                  label: Text('Pending',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ),
                SizedBox(
                  width: 5,
                ),
                Chip(
                  elevation: 0.3,
                  backgroundColor: Colors.white,
                  avatar: CircleAvatar(
                    backgroundColor: Colors.yellow,
                    child: Text('P',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  ),
                  label: Text('On Progress'),
                ),
                SizedBox(
                  width: 5,
                ),
                Chip(
                  elevation: 0.3,
                  backgroundColor: Colors.white,
                  avatar: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text('D'),
                  ),
                  label: Text('Delivered'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) => GestureDetector(
                onTap: () {},
                child: Card(
                  elevation: 0.3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.4),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                                child: Text(
                              "Product ${index + 1}",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 10,
                              ),
                            )),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                                child: Text(
                              products[index]["name"],
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "productName: ${products[index]["productName"]}",
                              textAlign: TextAlign.justify,
                              maxLines: 3,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "productType: ${products[index]["productType"]}",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "productPrice: ${products[index]["productPrice"]}",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Phone: ${products[index]["phone"]}",
                              textAlign: TextAlign.justify,
                              maxLines: 3,
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Address: ${products[index]["address"]}",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Town: ${products[index]["town"]}",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Pincode: ${products[index]["pincode"]}",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
