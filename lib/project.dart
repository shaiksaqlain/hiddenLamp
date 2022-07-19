import 'package:flutter/material.dart';

class Project extends StatefulWidget {
  const Project({Key? key, this.projectDetails}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final projectDetails;
  @override
  State<Project> createState() => _ProjectState();
}

class _ProjectState extends State<Project> {
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
                image: NetworkImage(widget.projectDetails["ImageUrl"]),
              ),
              Text(
                widget.projectDetails["ProjectName"],
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person, color: Color(0xff00acc1)),
                      Text(
                        widget.projectDetails["Author"],
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff00acc1)),
                      ),
                    ],
                  ),
                  Text("⭐ ${widget.projectDetails["Rating"]}"),
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
                widget.projectDetails["Discription"],
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.grey, fontSize: 18, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
