import 'dart:convert';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:dishoom/api/constant.dart';
import 'package:dishoom/screens/video/languages_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path/path.dart' as Path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../dashboard_screen.dart';
import 'record_video_other_voice_screen.dart';

class WatchRecordedVideoScreen extends StatefulWidget {
  final String vidPath;

  WatchRecordedVideoScreen({Key key, @required this.vidPath}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WatchRecordedVideoScreenState();
  }
}

class WatchRecordedVideoScreenState extends State<WatchRecordedVideoScreen> {

  Dio dio = new Dio();
  final formKey = new GlobalKey<FormState>();
  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _descriptionController = new TextEditingController();
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;
  Chewie playerWidget;
  String poolId;
  String accessToken = "";
  String fileName = "";
  String fileVideo = "";
  String awsFolderPath;
  String bucketName;
  var vidFile;
  var size;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;
  String _currentAddress;
  String base64Image = "";

  bool isFileUploading = false;

  @override
  Future<void> initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.file(File(widget.vidPath));
    chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        aspectRatio: 2 / 3,
        autoPlay: true,
        looping: false);
    playerWidget = Chewie(
      controller: chewieController,
    );
    vidFile = File(widget.vidPath);
    fileName = vidFile.path.split('/').last;
    print('File full name : '+vidFile.toString());
    print('File name : '+fileName);
    print("File length");
    print(vidFile.lengthSync());
    size = vidFile.lengthSync();
    _tokenRetriever();
    _getCurrentLocation();
    _convertTobase();
  }

  _convertTobase() async {
    List<int> vidBytes = await File(widget.vidPath).readAsBytesSync();
    base64Image = base64Encode(vidBytes);
    print("Base 64 image : -"+base64Image);
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        print("Current Address : "+_currentPosition.toString());
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  uploadVideo() async {
    print('base64Image ' + base64Image);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String url = "https://grockers.com/s3upload/index1.php";
    var body = {'video' : base64Image};
    var jsonResponse;
    final response = await http.post(url,
        body: body
    );
    if(response.statusCode == 200){
      print("Response Status of Recorded Video Screen: ${response.body}");
      sharedPreferences.setString('uploadedVideo', response.body);
      _uploadVideo(response.body);
    }
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
        "${place.locality}";
        print("Current Address : "+_currentAddress);
      });
    } catch (e) {
      print(e);
    }
  }



  _tokenRetriever() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken = prefs.getString('Accesstoken') ?? 'Access token';
    });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  _uploadVideo(String desc) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fileVideo = prefs.getString('uploadedVideo') ?? 'Uploaded Video';
    });
    String url = Constant.videoUploadUrl;
    var jsonResponse;

    Map<String, String> headers = {
      'Content-Type' : 'application/json',
      'Client-Id' : 'dishuumapp:dishumm:bd3c59bf-fa01-4fc7-aed1-4330d59d7bfd',
      'Authorization' : 'Bearer $accessToken'
    };

    var body = json.encode({'videopath' : fileVideo, 'city' : 'Bangalore', 'intrestID' : '40a17cc1-17cb-464d-8cc7-308d3c43332a', 'description' : desc});
    final response = await http.post(url,
        headers: headers,
        body: body
    );
    if(response.statusCode == 200){
      jsonResponse = json.decode(response.body);
      print("Response Status of Recorded Video Screen: ${response.body}");
      if(jsonResponse != null){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => DashboardScreen()), (Route<dynamic> route) => false);
      }
    }
  }

  Future<bool> _goBack() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LanguagesScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _goBack,
      child: Scaffold(
        bottomNavigationBar: new Stack(
          overflow: Overflow.visible,
          alignment: new FractionalOffset(.5, 1.0),
          children: [
            new Container(
              height: 40.0,
              color: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                new Padding(
                  padding: const EdgeInsets.only(bottom: 12.0, left: 12),
                  child: new CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 20,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.arrow_back_ios),
                      color: Colors.white,
                      onPressed: _goBack,
                    ),
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(bottom: 12.0, right: 12),
                  child:  RaisedButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.blue)
                    ),
                    onPressed: () async {
//                      if(formKey.currentState.validate()){
//                        var desc = _descriptionController.text;
//                        var resp = await _uploadVideo(desc);
//                      }
//                      print("Upload button pressed");
//                      print(vidFile.lengthSync());
//                      print(widget.vidPath);
                      setState(() {
                        showLoaderDialog(context);
                      });
//                      uploadVideo();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('UPLOAD', style: TextStyle(color: Colors.white)),
                        Icon(Icons.chevron_right, color: Colors.white, size: 20,),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Chewie(
                      controller: chewieController,
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:8.0),
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Container(
                              child: TextFormField(
                                controller: _descriptionController,
                                validator: (String text){
                                  if(text.length == 0) return 'Description cannot be empty';
                                  else return null;
                                },
                                maxLines: 5,
                                decoration: InputDecoration(
                                  labelText: "Description",
                                  hintText: "Enter description",
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Color(0xFFAFDCEC),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.lightBlueAccent,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                cursorColor: Color(0xFFAFDCEC),
                                autofocus: false,
                              )
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }

//  Future<String> uploadVideo(File file, String path) async {
//
//    String result;
//
//    if(result == null) {
//      String fileName = "Username\_${DateTime
//          .now()
//          .millisecondsSinceEpoch}.$path";
//
//      AwsS3 awsS3 = AwsS3(
//          file: vidFile,
//          fileNameWithExt: fileName,
//          awsFolderPath: null,
//          poolId: null,
//          region: Regions.US_EAST_1,
//          bucketName: bucketName);
//
//      setState(() => isFileUploading = true);
//      displayUploadDialog(awsS3);
//      try {
//        try {
//          result = await awsS3.uploadFile;
//          print("Result :'$result'.");
//        } on PlatformException {
//          print("Result :'$result'.");
//        }
//      } on PlatformException catch (e) {
//        print('Failed : ${e.message}');
//      }
//      Navigator.of(context).pop();
//      return result;
//    }
//  }
//
//  Future displayUploadDialog(AwsS3 awsS3) {
//    return showDialog(
//      context: context,
//      barrierDismissible: false,
//      builder: (context) => StreamBuilder(
//        stream: awsS3.getUploadStatus,
//        builder: (BuildContext context, AsyncSnapshot snapshot) {
//          return buildFileUploadDialog(snapshot, context);
//        },
//      ),
//    );
//  }
//
//  AlertDialog buildFileUploadDialog(
//      AsyncSnapshot snapshot, BuildContext context) {
//    return AlertDialog(
//      title: Container(
//        padding: EdgeInsets.all(6),
//        child: LinearProgressIndicator(
//          value: (snapshot.data != null) ? snapshot.data / 100 : 0,
//          valueColor:
//          AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColorDark),
//        ),
//      ),
//      content: Padding(
//        padding: const EdgeInsets.symmetric(horizontal: 6),
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: [
//            Expanded(child: Text('Uploading...')),
//            Text("${snapshot.data ?? 0}%"),
//          ],
//        ),
//      ),
//    );
//  }

  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
        content: Wrap(
          children: [
            SpinKitDoubleBounce(color: Colors.deepOrangeAccent,),
            Align(
                alignment: Alignment.center,
                child: Text("Loading...", textAlign: TextAlign.center, )),
          ],
        )
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
}


