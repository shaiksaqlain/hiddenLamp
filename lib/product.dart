import 'package:flutter/material.dart';

class Product extends StatefulWidget {
  const Product({Key? key, this.productDetails}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final productDetails;
  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(""),
        actions: const [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Icon(
              Icons.notifications_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: NetworkImage(widget.productDetails["ImageUrl"]),
              ),
              Text(
                widget.productDetails["productName"],
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Icon(Icons.type_specimen, color: Color(0xff00acc1)),
                      Text(
                        widget.productDetails["type"],
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff00acc1)),
                      ),
                    ],
                  ),
                  Text("INR ${widget.productDetails["Price"]}"),
                  Text(
                    "",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff00acc1)),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.productDetails["description"],
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.grey, fontSize: 18, height: 1.5),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Shop will come Soon"),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xff26c6da)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 120, right: 120, top: 20, bottom: 20),
                    child: Text(
                      "Buy",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
