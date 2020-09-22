import 'package:dishoom/screens/video/watch_recorded_video_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_trimmer/trim_editor.dart';
import 'package:video_trimmer/video_trimmer.dart';
import 'package:video_trimmer/video_viewer.dart';

class TrimmerView extends StatefulWidget {
  final Trimmer _trimmer;
  TrimmerView(this._trimmer);
  @override
  _TrimmerViewState createState() => _TrimmerViewState();
}

class _TrimmerViewState extends State<TrimmerView> {
  double _startValue = 0.0;
  double _endValue = 0.0;

  bool _isPlaying = false;
  bool _progressVisibility = false;

  Future<String> _saveVideo() async {
    setState(() {
      _progressVisibility = true;
    });

    String _value;

    await widget._trimmer
        .saveTrimmedVideo(startValue: _startValue, endValue: _endValue)
        .then((value) {
      setState(() {
        _progressVisibility = false;
        _value = value;
      });
    });

    return _value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      bottomNavigationBar: new Stack(
        overflow: Overflow.visible,
        alignment: new FractionalOffset(.5, 1.0),
        children: [
          new Container(
            height: 40.0,
            color: Colors.black,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              new Padding(
                  padding: const EdgeInsets.only(bottom: 12.0, left: 12),
                  child: new FlatButton(
                    child: _isPlaying
                        ? Icon(
                      Icons.pause,
                      size: 50.0,
                      color: Colors.deepOrangeAccent,
                    )
                        : Icon(
                      Icons.play_arrow,
                      size: 50.0,
                      color: Colors.deepOrangeAccent,
                    ),
                    onPressed: () async {
                      bool playbackState =
                      await widget._trimmer.videPlaybackControl(
                        startValue: _startValue,
                        endValue: _endValue,
                      );
                      setState(() {
                        _isPlaying = playbackState;
                      });
                    },
                  )
              ),
              new Padding(
                padding: const EdgeInsets.only(bottom: 12.0, right: 12),
                child:  RaisedButton(
                  onPressed: _progressVisibility
                      ? null
                      : () async {
                    _saveVideo().then((outputPath) {
                      print('OUTPUT PATH: $outputPath');
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => WatchRecordedVideoScreen(
                            vidPath: outputPath,
                          ),
                        ),
                      );
                    });
                  },
                  child: Text("SAVE"),
                ),
              ),
            ],
          )
        ],
      ),
      body: Builder(
        builder: (context) =>
            Center(
              child: Container(
                padding: EdgeInsets.only(bottom: 30.0),
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Visibility(
                      visible: _progressVisibility,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.red,
                      ),
                    ),
//                    RaisedButton(
//                      onPressed: _progressVisibility
//                          ? null
//                          : () async {
//                        _saveVideo().then((outputPath) {
//                          print('OUTPUT PATH: $outputPath');
//                          Navigator.push(
//                            context,
//                            CupertinoPageRoute(
//                              builder: (_) => WatchRecordedVideoScreen(
//                                vidPath: outputPath,
//                              ),
//                            ),
//                          );
//                          final snackBar = SnackBar(
//                            content: Text('Video Saved successfully'),
//                          );
//                          Scaffold.of(context).showSnackBar(snackBar);
//                        });
//                      },
//                      child: Text("SAVE"),
//                    ),
                    Expanded(
                      child: VideoViewer(),
                    ),
                    Center(
                      child: TrimEditor(
                        viewerHeight: 50.0,
                        viewerWidth: MediaQuery
                            .of(context)
                            .size
                            .width,
                        maxVideoLength: Duration(seconds: 10),
                        onChangeStart: (value) {
                          _startValue = value;
                        },
                        onChangeEnd: (value) {
                          _endValue = value;
                        },
                        onChangePlaybackState: (value) {
                          setState(() {
                            _isPlaying = value;
                          });
                        },
                      ),
                    ),
//                    FlatButton(
//                      child: _isPlaying
//                          ? Icon(
//                        Icons.pause,
//                        size: 80.0,
//                        color: Colors.white,
//                      )
//                          : Icon(
//                        Icons.play_arrow,
//                        size: 80.0,
//                        color: Colors.white,
//                      ),
//                      onPressed: () async {
//                        bool playbackState =
//                        await widget._trimmer.videPlaybackControl(
//                          startValue: _startValue,
//                          endValue: _endValue,
//                        );
//                        setState(() {
//                          _isPlaying = playbackState;
//                        });
//                      },
//                    )
                  ],
                ),
              ),
            ),
      ),
    );
  }
}