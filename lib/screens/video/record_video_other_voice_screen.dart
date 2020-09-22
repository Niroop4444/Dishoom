import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:camera/camera.dart';
import 'package:dishoom/screens/video/watch_recorded_video_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_trimmer/video_trimmer.dart';

import 'audio_library_screen.dart';
import 'trim_video_screen.dart';

class RecordVideoOtherVoiceScreen extends StatelessWidget {

  final String songUrl;
  RecordVideoOtherVoiceScreen(this.songUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: CustomCamera(songUrl),
      ),
    );
  }
}

class CustomCamera extends StatefulWidget {

  final String songUrl;
  CustomCamera(this.songUrl);

  @override
  _CustomCameraState createState() => _CustomCameraState();
}

class _CustomCameraState extends State<CustomCamera> {

  final Trimmer _trimmer = Trimmer();
  CameraController controller;
  List<CameraDescription> cameras;
  bool cameraInit;
  int selectedCamera = 0;
  bool btnState = false;
  bool isReady = false;
  String videoPath;
  var filename;
  final fileName = TextEditingController();
  Timer _timer;
  int _recordTime = 30;
  int _start = 0;
  bool _isShowCountdownTime;
  bool _isRecording;
  final picker = ImagePicker();
  File _video;
  AudioPlayer audioPlayer = new AudioPlayer();
  bool playing = false;

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  @override
  void initState() {
    super.initState();
    cameraInit = false;
    _setupCamera();
    _isShowCountdownTime = false;
    _isRecording = false;
  }

  @override
  void dispose() {
    controller?.dispose();
    _timer.cancel();
    super.dispose();
  }

  void startTimerCountdown() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start < 1) {
            timer.cancel();
            _isShowCountdownTime = false;
            _isRecording = true;
            startTimerRecord();
            controller != null &&
                controller.value.isInitialized &&
                !controller.value.isRecordingVideo
                ? startVideoRecording()
                : null;
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  void startTimerRecord() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_recordTime < 1) {
            timer.cancel();
            controller != null &&
                controller.value.isInitialized &&
                controller.value.isRecordingVideo
                ? stopVideoRecording().then((_) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      WatchRecordedVideoScreen(vidPath: videoPath),
                ),
              );
              if (mounted) setState(() {});
            })
                : null;
          } else {
            _recordTime = _recordTime - 1;
          }
        },
      ),
    );
  }

  Future<void> _setupCamera() async {
    try {
      cameras = await availableCameras();
      controller = new CameraController(cameras[selectedCamera], ResolutionPreset.high);
      await controller.initialize();
    } on CameraException catch (_) {}
    if (!mounted) return;
    setState(() {
      isReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller.value.isInitialized) {
      return SingleChildScrollView(
        child: new Container(
            child: Center(
              child: SpinKitDoubleBounce(
                color: Colors.deepOrangeAccent,
              ),
            )
        ),
      );
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: Stack(
                children: [
                  CameraPreview(controller),
                  _goBack(),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          _recorder(),
        ],
      ),
    );
  }

  Widget _goBack(){
    return Positioned(
      top: 30,
      left: 20,
      child: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AudioLibraryScreen()));
        },
      ),
    );
  }

  Widget _centerWidget() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        child: Text(
          'Blackbird singing in the dead of night \n Take these broken wings and learn to fly \n All your life \n You were only waiting for this moment to arise',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _recorder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
            icon: new Icon(
              Icons.camera_front,
              color: Colors.white70,
            ),
            onPressed: () => toggleCamera()),
        IconButton(
          icon: Icon(
            Icons.image,
            color: Colors.white,
          ),
          onPressed: _pickVideo,
        ),
        Container(
          padding: EdgeInsets.all(7),
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(.4),
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(50)),
              border: Border.all(color: Colors.black, width: 1.5),
            ),
            child: IconButton(
              iconSize: 25,
              icon: btnState == false
                  ? new Icon(Icons.videocam)
                  : new Icon(Icons.stop),
              onPressed: () {
                btnState == false ? onVideoStarted() : onVideoStopped();
              },
            ),
          ),
        ),
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 15,
          child: Text(
            '$_recordTime',
            style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.flash_off,
            color: Colors.white70,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  void toggleCamera() {
    setState(() {
      selectedCamera = (selectedCamera == 1) ? 0 : 1;
      _setupCamera();
    });
  }

  Future _videoPick() async {

  }

  Future _pickVideo() async {
    final picker = ImagePicker();
    File pickedFile = await ImagePicker.pickVideo(source: ImageSource.gallery,);
    if(pickedFile != null){
      await _trimmer.loadVideo(videoFile: pickedFile);
      Navigator.of(context)
          .push(CupertinoPageRoute(builder: (context) {
        return TrimmerView(_trimmer);
      }));
    }
//    _video = File(pickedFile.path);

//    Navigator.push(
//      context,
//      CupertinoPageRoute(
//        builder: (_) => WatchRecordedVideoScreen(
//          vidPath: pickedFile.path,
//        ),
//      ),
//    );
  }

  void onVideoStarted() {
    setState(() {
      btnState = true;
      startTimerCountdown();
    });
    startVideoRecording().then((String filePath) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  Future<String> startVideoRecording() async {
    if (!controller.value.isInitialized) return null;

    if (controller.value.isRecordingVideo) return null;

    var res = await audioPlayer.play(widget.songUrl, isLocal: true);
    if (res == 1) {
      setState(() {
        playing = true;
      });
    }

    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Movies/flutter_test';
    print("File name in record : "+dirPath);
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.mp4';

    //todo: once we have the video file, we need to merge it with audio file
    // once we merge it, we have another mp4 file



    if (controller.value.isRecordingVideo) {
      return null;
    }

    try {
      setState(() {
        videoPath = filePath;
      });
      await controller.startVideoRecording(filePath);
    } on CameraException catch (e) {
      return null;
    }
    return filePath;
  }

  void onVideoStopped() {
    setState(() {
      btnState = false;
      _playVideo();
//      fileName.text = "${filename.toString()}";
    });
    stopVideoRecording().then((_) {
      if (mounted) setState(() {});
    });
  }

  Future<void> stopVideoRecording() async {
    print('Stop Video Recording');
    var res = await audioPlayer.pause();
    if (res == 1) {
      setState(() {
        playing = false;
      });
    }
    if (!controller.value.isRecordingVideo) {
      return null;
    }

    try {
      await controller.stopVideoRecording();
    } on CameraException catch (e) {
      return null;
    }
  }

  void _playVideo() {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => WatchRecordedVideoScreen(
          vidPath: videoPath,
        ),
      ),
    );
  }
}
