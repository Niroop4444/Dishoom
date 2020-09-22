import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ShowUserVideoScreen extends StatefulWidget {
  String videoURL;

  ShowUserVideoScreen({this.videoURL});

  @override
  _ShowUserVideoScreenState createState() => _ShowUserVideoScreenState();
}

class _ShowUserVideoScreenState extends State<ShowUserVideoScreen> {
  VideoPlayerController _controller;
  ChewieController chewieController;
  Chewie playerWidget;

  @override
  Future<void> initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoURL);
    chewieController = ChewieController(
        videoPlayerController: _controller,
        aspectRatio: 2 / 4,
        autoPlay: true,
        looping: false);
    playerWidget = Chewie(
      controller: chewieController,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Chewie(
            controller: chewieController,
          ),
        ));
  }
}
