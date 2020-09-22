import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:dishoom/api/constant.dart';
import 'package:dishoom/screens/video/record_video_other_voice_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AudioLibraryScreen extends StatefulWidget {
  @override
  _AudioLibraryScreenState createState() => _AudioLibraryScreenState();
}

class _AudioLibraryScreenState extends State<AudioLibraryScreen> {
  List data;
  var jsonResponse;
  String token = "";
  String movieid = "";
  Map<int, String> audioUrlMap = new Map();
  Map<int, AudioPlayer> audioPlayerMap = new Map();
  Map<int, Duration> durationMap = new Map();
  Map<int, Duration> positionMap = new Map();

  Map<int, bool> playingMap = new Map();

  @override
  void initState() {
    getToken();
    getMovieId();
    getSounds();
    super.initState();
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('Accesstoken') ?? 'Access token';
    });
  }

  getMovieId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      movieid = prefs.getString('movieid') ?? 'Access token';
    });
  }

  getSounds() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String url = Constant.musicUrl + movieid;
    print("URL - " + url);
    var jsonResponse;

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Client-Id': 'dishuumapp:dishumm:bd3c59bf-fa01-4fc7-aed1-4330d59d7bfd',
      'Authorization': 'Bearer $token'
    };

    final response = await http.get(url, headers: headers);
    setState(() {
      data = json.decode(response.body)['data'];
    });
    if (response.statusCode == 200) {
      print('Response in Audio Library: ' + response.body);
      jsonResponse = json.decode(response.body);
    }

    print("Response Status : " + response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Sounds', style: TextStyle(color: Colors.deepOrangeAccent)),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: new IconButton(
          icon: Image.asset(
            'assets/images/ic_logo.png',
          ),
          onPressed: () {},
        ),
      ),
      body: Column(
        children: [
          _buildListView(),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return Flexible(
      child: Container(
        child: ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (context, index) {
              audioUrlMap.putIfAbsent(index, () => "");
              audioPlayerMap.putIfAbsent(index, () => new AudioPlayer());
              durationMap.putIfAbsent(index, () => new Duration(seconds: 0));
              positionMap.putIfAbsent(index, () => new Duration(seconds: 0));
              playingMap.putIfAbsent(index, () => false);

              getAudio(data[index], index);

              return _buildMoviesColumn(data[index], index);
            }),
      ),
    );
  }

  _buildMoviesColumn(dynamic item, int index) {
    return GestureDetector(
      onTap: () {
        print('You Tapped ${item['soundID']}');
      },
      child: Container(
        decoration: BoxDecoration(color: Colors.white54),
        margin: const EdgeInsets.all(4),
        child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Text(
                          item['sound'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () async {
                          if (playingMap[index]) {
                            var res = await audioPlayerMap[index].pause();
                            if (res == 1) {
                              setState(() {
                                playingMap.update(index, (value) => false);
                              });
                            }
                          } else {

                            for(int i=0; i<playingMap.length; i++){
                              if(i!=index){
                                await audioPlayerMap[i].pause();
                                setState(() {
                                  playingMap.update(i, (value) => false);
                                });
                              }else{
                                var res = await audioPlayerMap[i].play(item['soundURL'], isLocal: true);
                                if (res == 1) {
                                  setState(() {
                                    playingMap.update(i, (value) => true);
                                  });
                                }
                              }
                            }

                          }
                        },
                        child: Icon(
                          playingMap[index] == false
                              ? Icons.play_circle_outline
                              : Icons.pause_circle_outline,
                          size: 50,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                      _slider(index),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Material(
                          type: MaterialType.transparency,
                          child: Ink(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.deepOrangeAccent, width: 4.0),
                              color: Colors.deepOrange.withOpacity(0.7),
                              shape: BoxShape.circle,
                            ),
                            child: InkWell(
                              onTap: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setString(
                                    'selectedSound', item['soundURL']);
                                print("Selected Sounds - " +
                                    prefs.getString('selectedSound'));
                                for (int i = 0; i < playingMap.length; i++) {
                                  playingMap.update(i, (value) => false);
                                  audioPlayerMap[i].dispose();
                                }
                                playingMap[index] == false;

                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return RecordVideoOtherVoiceScreen(
                                      item['soundURL'].toString());
                                }));
                              },
                              borderRadius: BorderRadius.circular(100.0),
                              //Something large to ensure a circle
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.chevron_right,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget _slider(int index) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        valueIndicatorColor: Colors.blue,
        inactiveTrackColor: Color(0xFF8D8E98),
        activeTrackColor: Colors.white,
        thumbColor: Colors.red,
        overlayColor: Color(0x29EB1555),
        // Custom Thumb overlay Color
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
      ),
      child: Slider.adaptive(
          min: 0.0,
          value: positionMap[index].inSeconds.toDouble(),
          max: durationMap[index].inSeconds.toDouble(),
          onChanged: (double value) {
            setState(() {
              audioPlayerMap[index].seek(new Duration(seconds: value.toInt()));
            });
          }),
    );
  }

  void getAudio(dynamic item, int index) async {
    var url = item['soundURL'];
    print("soundURL - " + url);
//    if (playingMap[index]) {
//      var res = await audioPlayerMap[index].pause();
//      if (res == 1) {
//        setState(() {
//          playingMap.update(index, (value) => false);
//        });
//      }
//    } else {
//      var res = await audioPlayerMap[index].play(url);
//      if (res == 1) {
//        setState(() {
//          playingMap.update(index, (value) => true);
//        });
//      }
//    }

    audioPlayerMap[index].onDurationChanged.listen((Duration dd) {
      setState(() {
        durationMap.update(index, (value) => dd);
      });
    });
    audioPlayerMap[index].onAudioPositionChanged.listen((Duration dd) {
      setState(() {
        positionMap.update(index, (value) => dd);
      });
    });
    audioPlayerMap[index].onPlayerCompletion.listen((event) {
      setState(() {
        playingMap.update(index, (value) => false);
        positionMap.update(index, (value) => Duration(seconds: 0));
        durationMap.update(index, (value) => Duration(seconds: 0));
      });
    });
  }

  Widget _buttonNext() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (int i = 0; i < playingMap.length; i++) {
      playingMap.update(i, (value) => false);
      audioPlayerMap[i].dispose();
    }
  }

  @override
  void deactivate() {
    super.deactivate();
    for (int i = 0; i < playingMap.length; i++) {
      playingMap.update(i, (value) => false);
      audioPlayerMap[i].dispose();
    }
  }
}
