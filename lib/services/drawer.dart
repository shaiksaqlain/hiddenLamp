import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hidden_lamp/admin_panel.dart';
import 'package:hidden_lamp/services/WebviewPage.dart';
import 'package:hidden_lamp/services/sharedPreferances.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerWidget {
  Share _share = Share();
  drawer(String schoolName, String userImage, String name, String type,
      BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(userImage),
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
                    onPressed: () async {
                      Navigator.of(context).pop();
                      const uri =
                          'mailto:hiddenlamp.org@gmail.com?subject=Suggestions:&body=';
                      if (await canLaunch(uri)) {
                        await launch(uri);
                      } else {
                        throw 'Could not launch $uri';
                      }
                    },
                  ),
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
                        _launchURL(
                            "https://www.facebook.com/hiddenlamp.pvt.ltd");
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
                        _launchURL("https://hiddenlamp.in/");
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
          type == "admin"
              ? ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => AdminPanel(),
                      ),
                    );
                  },
                  leading: Icon(
                    EvaIcons.atOutline,
                    color: Colors.black,
                  ),
                  title: Text("Admin"),
                )
              : Container(),
          ListTile(
            onTap: (() {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => WebViewPage(
                      fileurl:
                          "https://drive.google.com/file/d/17MtmjE6wn9kpb03LHHXZZQyeCH0czEIP/view?usp=sharing",
                      name: "Privacy Policies"),
                ),
              );
            }),
            leading: Icon(
              EvaIcons.shieldOutline,
              color: Colors.black,
            ),
            title: Text("Privacy policies"),
          ),
          ListTile(
            onTap: (() {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => WebViewPage(
                      fileurl:
                          "https://drive.google.com/file/d/1ah35oddtZFxUDVIJBu-wRFl98hFAr-EF/view?usp=sharing",
                      name: "Terms & Conditions"),
                ),
              );
            }),
            leading: Icon(
              EvaIcons.fileTextOutline,
              color: Colors.black,
            ),
            title: Text("Terms & Conditions"),
          ),
          ListTile(
            onTap: (() {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => WebViewPage(
                      fileurl: "https://hiddenlamp.in/about-us/",
                      name: "About us"),
                ),
              );
            }),
            leading: Icon(
              EvaIcons.questionMarkCircleOutline,
              color: Colors.black,
            ),
            title: Text("About us"),
          ),
          ListTile(
            onTap: (() {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => WebViewPage(
                      fileurl: "https://hiddenlamp.in/contact-us-2/",
                      name: "Contact us"),
                ),
              );
            }),
            leading: Icon(
              EvaIcons.headphonesOutline,
              color: Colors.black,
            ),
            title: Text("Contact Us"),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              showDialog<void>(
                context: context,
                barrierDismissible: false,
                // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'Are you sure want to Logout?',
                      style: TextStyle(
                          color: Colors.black45, fontWeight: FontWeight.bold),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text(
                          'Yes',
                          style: TextStyle(color: Colors.blue),
                        ),
                        onPressed: () async {
                          _share.clearSharePreferances(context);
                        },
                      ),
                      FlatButton(
                        child: Text(
                          'No',
                          style: TextStyle(color: Colors.blue),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            leading: Icon(
              EvaIcons.logOutOutline,
              color: Colors.black,
            ),
            title: Text("Logout"),
          ),
        ],
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
