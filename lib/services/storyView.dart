// ignore_for_file: file_names, prefer_typing_uninitialized_variables, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class StoryViewPage extends StatefulWidget {
  const StoryViewPage({Key? key, this.storyDetails}) : super(key: key);

  final storyDetails;

  @override
  State<StoryViewPage> createState() => _StoryViewPageState();
}

class _StoryViewPageState extends State<StoryViewPage> {
  final controller = StoryController();
  @override
  Widget build(BuildContext context) {
    return Material(
        child: StoryView(
      storyItems: [
        widget.storyDetails["ContentType"] == "text"
            ? StoryItem.text(
                title: widget.storyDetails["Content"],
                backgroundColor: Colors.red)
            : StoryItem.pageImage(
                url: widget.storyDetails["Content"], controller: controller),
      ],
      controller: controller,
      inline: false,
    )
        // child: Text(""),
        );
  }
}
