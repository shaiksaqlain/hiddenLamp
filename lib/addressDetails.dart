// ignore_for_file: file_names, prefer_typing_uninitialized_variables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class AddressDetails extends StatefulWidget {
  const AddressDetails({Key? key, this.productDetails}) : super(key: key);
  final productDetails;

  @override
  State<AddressDetails> createState() => _AddressDetailsState();
}

class _AddressDetailsState extends State<AddressDetails> {
  String name = "";
  String phone = "";
  String address = "";
  String town = "";
  String state = "";
  String pincode = "";
  String numberOfProducts = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff26c6da),
        centerTitle: true,
        title: Text("Delivery Address"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 15, right: 15, left: 15),
                child: Text(
                  "Enter address to delivary the product",
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
                          EvaIcons.person,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          name = value;
                        },
                        decoration: InputDecoration(
                            hintText: "enter your name",
                            labelText: "Name",
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
                          EvaIcons.hashOutline,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          numberOfProducts = value;
                        },
                        decoration: InputDecoration(
                            hintText: "Number of Products",
                            labelText: "Count",
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
                          EvaIcons.phone,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          phone = value;
                        },
                        decoration: InputDecoration(
                            hintText: "Enter your phone number",
                            labelText: "Phone",
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
                          EvaIcons.home,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          address = value;
                        },
                        decoration: InputDecoration(
                            hintText: "Enter address",
                            labelText: "Address",
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
                          EvaIcons.map,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          town = value;
                        },
                        decoration: InputDecoration(
                            hintText: "Enter town name",
                            labelText: "Town",
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
                          EvaIcons.pin,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          pincode = value;
                        },
                        decoration: InputDecoration(
                            hintText: "pincode",
                            labelText: "Pincode",
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
                          EvaIcons.star,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          state = value;
                        },
                        decoration: InputDecoration(
                            hintText: "Enter State name",
                            labelText: "State",
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
                          if (name != "" &&
                              phone != "" &&
                              address != "" &&
                              town != "" &&
                              pincode != "" &&
                              state != "") {
                            try {
                              FirebaseFirestore.instance
                                  .collection("deliveryProduct")
                                  .doc()
                                  .set({
                                'name': name,
                                'phone': phone,
                                'address': address,
                                'town': town,
                                'pincode': pincode,
                                'state': state,
                                'productName':
                                    widget.productDetails['productName'],
                                'productType': widget.productDetails['type'],
                                'productPrice': widget.productDetails['Price'],
                                'productImage':
                                    widget.productDetails['ImageUrl'],
                                'productDescription':
                                    widget.productDetails['description']
                              });
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Product request added Successfuly"),
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
