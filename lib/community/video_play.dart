// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:agritool/custom/custom_data.dart';
import 'package:agritool/custom/custom_icon.dart';
import 'package:agritool/custom/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String type;
  final File videoFile;

  const VideoPlayerWidget(
      {super.key, required this.videoFile, required this.type});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    if (widget.type == 'file') {
      _controller = VideoPlayerController.file(widget.videoFile);
    } else {
      _controller =
          VideoPlayerController.networkUrl(Uri.parse(widget.videoFile.path));
    }
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CustomSizeData size = CustomSizeData.from(context: context);
    double height = size.height;
    double width = size.width;
    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SizedBox(
                  height: height * 0.08,
                  width: width * 0.9,
                  child: VideoPlayer(_controller),
                );
              } else {
                return const Center(
                  child: SizedBox(
                      height: 10,
                      width: 10,
                      child: CircularProgressIndicator()),
                );
              }
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconButton(
              icon: CustomIcon(
                icon: _controller.value.isPlaying
                    ? Icons.pause
                    : Icons.play_arrow,
              ),
              onPressed: () {
                setState(() {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                });
              },
            ),
            CustomIconButton(
              icon: const  CustomIcon(icon:  Icons.stop),
              onPressed: () {
                setState(() {
                  _controller.seekTo(Duration.zero);
                  _controller.pause();
                });
              },
            ),
             CustomIconButton(
              icon: const  CustomIcon(icon:Icons.replay),
              onPressed: () {
                setState(() {
                  _controller.seekTo(Duration.zero);
                  _controller.play();
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
