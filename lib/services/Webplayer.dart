// ignore_for_file: file_names, library_private_types_in_public_api

import 'dart:async';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPlayer extends StatefulWidget {
  final String fileurl;
  final String name;

  const WebPlayer({Key? key, required this.fileurl, required this.name})
      : super(key: key);
  @override
  _WebPlayerState createState() => _WebPlayerState();
}

class _WebPlayerState extends State<WebPlayer> {
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
      body: WebView(
        initialUrl: url,
        onWebResourceError: (error) => {print("bajhbvs$error")},
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
