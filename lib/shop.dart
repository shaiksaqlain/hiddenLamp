import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Shop extends StatefulWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  State<Shop> createState() => _ShopState();
}

String name = "";
String schoolName = "";

class _ShopState extends State<Shop> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    getProductsData();
    sharePreferances();
    super.initState();
  }

  var products = [];

  CollectionReference projectCollectionRef =
      FirebaseFirestore.instance.collection('Products');

  Future<void> getProductsData() async {
    QuerySnapshot querySnapshot = await projectCollectionRef.get();
    products = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(products[0]);
    setState(() {});
  }

  sharePreferances() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? setStatus = prefs.getStringList("status");
    List<String>? setUserEmail = prefs.getStringList("email");
    setStatus == null ? setStatus = [] : print("List is not Empty");
    setUserEmail == null ? setUserEmail = [] : print("List is not Empty");
    var getEmail = prefs.getStringList("email");
    var getUserStatus = prefs.getStringList("status");
    print(getEmail);
    print(getUserStatus?[0]);

    DocumentReference projectCollectionRef =
        FirebaseFirestore.instance.collection('Users').doc(getEmail?[0]);
    DocumentSnapshot documentSnapshot = await projectCollectionRef.get();
    print(documentSnapshot.get("userName"));
    name = documentSnapshot.get("userName");
    schoolName = documentSnapshot.get("schoolName");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage("assets/logo.png"),
                ),
                accountName: Text(name),
                accountEmail: Text(schoolName)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 7),
                  child: CircleAvatar(
                    backgroundColor: Colors.redAccent.shade200,
                    radius: 20,
                    child: IconButton(
                        icon: Icon(
                          EvaIcons.google,
                          color: Colors.white,
                          size: 25,
                        ),
                        onPressed: () {
                          //googleLogin();
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 7),
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 20,
                    child: IconButton(
                        icon: Icon(
                          EvaIcons.facebook,
                          color: Colors.white,
                          size: 25,
                        ),
                        onPressed: () {
                          //   print("sss");
                          //   FirebaseAuth.instance.signOut();
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 7),
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 20,
                    child: IconButton(
                        icon: Icon(
                          EvaIcons.facebook,
                          color: Colors.white,
                          size: 25,
                        ),
                        onPressed: () {
                          //   print("sss");
                          //   FirebaseAuth.instance.signOut();
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 7),
                  child: CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 20,
                    child: IconButton(
                        icon: Icon(
                          EvaIcons.globe,
                          color: Colors.white,
                          size: 25,
                        ),
                        onPressed: () {
                          //   print("sss");
                          //   FirebaseAuth.instance.signOut();
                        }),
                  ),
                ),
              ],
            ),
            Divider(),
            ListTile(
              leading: Icon(
                EvaIcons.shoppingCartOutline,
                color: Colors.black,
              ),
              title: Text("My Orders"),
            ),
            ListTile(
              leading: Icon(
                EvaIcons.heartOutline,
                color: Colors.black,
              ),
              title: Text("Wishlist"),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                EvaIcons.settingsOutline,
                color: Colors.black,
              ),
              title: Text("Settings"),
            ),
            ListTile(
              leading: Icon(
                EvaIcons.fileTextOutline,
                color: Colors.black,
              ),
              title: Text("Terms & Conditions"),
            ),
            ListTile(
              leading: Icon(
                EvaIcons.questionMarkCircleOutline,
                color: Colors.black,
              ),
              title: Text("Help"),
            ),
            ListTile(
              leading: Icon(
                EvaIcons.headphonesOutline,
                color: Colors.black,
              ),
              title: Text("Contact Us"),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                EvaIcons.logOutOutline,
                color: Colors.black,
              ),
              title: Text("Logout"),
            ),
          ],
        ),
      ),
      key: _globalKey,
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
                        _globalKey.currentState?.openDrawer();
                      },
                      icon: Icon(
                        EvaIcons.list,
                        color: Colors.white,
                        size: 30,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 20),
                  child: Text(
                    "Shop",
                    style: TextStyle(
                        letterSpacing: 1,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
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
                    child: Text('K'),
                  ),
                  label: Text('Kits',
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
                    child: Text('S',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  ),
                  label: Text('Sensors'),
                ),
                SizedBox(
                  width: 5,
                ),
                Chip(
                  elevation: 0.3,
                  backgroundColor: Colors.white,
                  avatar: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text('B'),
                  ),
                  label: Text('Boards'),
                ),
                SizedBox(
                  width: 5,
                ),
                Chip(
                  elevation: 0.3,
                  backgroundColor: Colors.white,
                  avatar: CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Text('L'),
                  ),
                  label: Text('Leds'),
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
              itemBuilder: (BuildContext context, int index) => Card(
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
                    Center(
                        child: Image.network(
                      products[index]["ImageUrl"],
                      width: 150,
                      height: 100,
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      products[index]["productName"],
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          products[index]["Price"],
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
