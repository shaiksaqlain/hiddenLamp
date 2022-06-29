// ignore_for_file: file_names

import 'dart:async';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String fileurl;
  final String name;

  const WebViewPage({Key? key, required this.fileurl, required this.name})
      : super(key: key);
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late String url;
  Completer<WebViewController> webViewController =
      Completer<WebViewController>();

  @override
  void initState() {
    if (widget.fileurl.startsWith("https:")) {
      setState(() {
        url = widget.fileurl;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff26c6da),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(EvaIcons.arrowBack),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Text(widget.name),
      ),
      body: WebView(
        initialUrl: url,
        onWebResourceError: (error) => {print("bajhbvs$error")},
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
