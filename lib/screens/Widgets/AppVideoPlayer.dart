import 'package:dishoom/screens/video/show_user_video_screen.dart';
import 'package:dishoom/screens/video/showvid.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:dishoom/screens/video/watch_video_screen.dart';

class AppVideoPlayer extends StatefulWidget {

  String username;
  String desc;
  String loc;
  String url;

  AppVideoPlayer({this.username, this.desc, this.loc, this.url});
  @override
  _AppVideoPlayerState createState() => _AppVideoPlayerState();
}

class _AppVideoPlayerState extends State<AppVideoPlayer> {
  bool isVideoPlaying;
  bool isButtonVisible;
  bool isYTButtonVisible;
  bool isYoutubeVideo;

  VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    isVideoPlaying=false;
    isButtonVisible=true;
    isYTButtonVisible=true;
    isYoutubeVideo=false;


    if(widget.url.contains(new RegExp("^((?:https?:)?\/\/)?((?:www|m)\.)?((?:youtube\.com|youtu.be))(\/(?:[\w\-]+\?v=|embed\/|v\/)?)([\w\-]+)(\S+)?", caseSensitive: false))){
      setState(() {
        isYoutubeVideo=true;
        isYTButtonVisible=true;
      });

      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          isYTButtonVisible = false;
        });
      });

    }

    if(!isYoutubeVideo) {
      _videoController = VideoPlayerController.network(widget.url)
        ..initialize().then((_) {
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              isButtonVisible = false;
            });
          });
        });
    }


  }

  @override
  void didUpdateWidget(AppVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    try {
      _videoController.pause();
    }catch(e){}
  }

  @override
  void deactivate() {
    super.deactivate();
    try {
      _videoController.pause();
    }catch(e){}
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ShowVid(videoURL: widget.url)));
      },
        // onTap: (){
        //   setState(() {
        //     isButtonVisible = true;
        //   });
        //   Future.delayed(Duration(seconds: 2), (){
        //     setState(() {
        //       isButtonVisible = false;
        //     });
        //   });
        //   if(!isVideoPlaying){
        //     _videoController.play();
        //   }else{
        //     _videoController.pause();
        //   }
        //   setState(() {
        //     isVideoPlaying=!isVideoPlaying;
        //   });
        // },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Center(
              child: _videoController.value.initialized
                  ? AspectRatio(
                aspectRatio: _videoController.value.aspectRatio,
                child: VideoPlayer(_videoController),
              )
                  : Container(
                color: Colors.black,
              ),
            ),
            Visibility(
              visible: isButtonVisible,
              child: Icon(
                _videoController.value.isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white, size: 46,
              ),
            ),
          ],
        ),
      );

  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }

}