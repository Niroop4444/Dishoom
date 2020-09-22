import 'package:dishoom/widgets/left.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ShowVid extends StatefulWidget {

  String userName;
  String desc;
  String videoURL;
  String vidName;
  String loc;

  ShowVid({this.videoURL, this.desc, this.loc, this.userName});

  @override
  _ShowVidState createState() => _ShowVidState();
}

class _ShowVidState extends State<ShowVid> {

  VideoPlayerController _videoController;
  bool isShowPlaying = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Video URL - "+widget.videoURL);
    _videoController = VideoPlayerController.network(widget.videoURL)..initialize().then((value) {
      _videoController.play();
      setState(() {
        isShowPlaying = false;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoController.dispose();
  }

  Widget isPlaying(){
    return _videoController.value.isPlaying && !isShowPlaying  ? Container() : Icon(Icons.play_arrow,size: 80,color: Colors.white.withOpacity(0.5),);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          setState(() {
            _videoController.value.isPlaying
                ? _videoController.pause()
                : _videoController.play();
          });
        },
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.black),
                  child: Stack(
                    children: <Widget>[
                      VideoPlayer(_videoController),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                          ),
                          child: isPlaying(),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, top: 20, bottom: 10),
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
//                          Expanded(
//                            child: Row(
//                              children: [
//                                LeftPanel(
//                                  name: widget.userName,
//                                  caption: widget.desc,
//                                  songName: widget.loc,
//                                )
//                              ],
//                            ),
//                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
