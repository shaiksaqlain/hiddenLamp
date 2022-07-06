// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoApp extends StatefulWidget {
  const VideoApp({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    print(widget.url);
    final url = widget.url;
    super.initState();
    _controller = VideoPlayerController.network(url)
      ..addListener(() => setState(() {
            videoPosition = _controller.value.position;
          }))
      ..initialize().then((_) => setState(() {
            videoLength = _controller.value.duration;
          }));
  }

  late Duration videoLength;
  late Duration videoPosition;
  double volume = 0.5;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video Demo',
      home: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: <Widget>[
                  if (_controller.value.isInitialized) ...[
                    FittedBox(
                      fit: BoxFit.contain,
                      child: SizedBox(
                        width: _controller.value.size.width,
                        height: _controller.value.size.height,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                    VideoProgressIndicator(
                      _controller,
                      allowScrubbing: true,
                      padding: EdgeInsets.all(10),
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(_controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow),
                          onPressed: () {
                            setState(() {
                              _controller.value.isPlaying
                                  ? _controller.pause()
                                  : _controller.play();
                            });
                          },
                        ),
                        Text(
                            '${convertToMinutesSeconds(videoPosition)} / ${convertToMinutesSeconds(videoLength)}'),
                        SizedBox(width: 10),
                        Icon(animatedVolumeIcon(volume)),
                        Slider(
                          value: volume,
                          min: 0,
                          max: 1,
                          onChanged: (volume) => setState(() {
                            volume = volume;
                            _controller.setVolume(volume);
                          }),
                        ),
                        Expanded(
                          child: IconButton(
                              icon: Icon(
                                Icons.loop,
                                color: _controller.value.isLooping
                                    ? Colors.green
                                    : Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  _controller
                                      .setLooping(!_controller.value.isLooping);
                                });
                              }),
                        ),
                      ],
                    )
                  ],
                ],
              ),
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

String convertToMinutesSeconds(Duration duration) {
  final parsedMinutes = duration.inMinutes < 10
      ? '0${duration.inMinutes}'
      : duration.inMinutes.toString();

  final seconds = duration.inSeconds % 60;

  final parsedSeconds =
      seconds < 10 ? '0${seconds % 60}' : (seconds % 60).toString();
  return '$parsedMinutes:$parsedSeconds';
}

IconData animatedVolumeIcon(double volume) {
  if (volume == 0) {
    return Icons.volume_mute;
  } else if (volume < 0.5) {
    return Icons.volume_down;
  } else {
    return Icons.volume_up;
  }
}
