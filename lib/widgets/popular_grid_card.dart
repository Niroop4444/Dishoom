import 'package:dishoom/model/get_videos_model.dart';
import 'package:dishoom/model/popular_card_model.dart';
import 'package:dishoom/screens/video/show_user_video_screen.dart';
import 'package:dishoom/screens/video/showvid.dart';
import 'package:dishoom/screens/video/watch_video_screen.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:dishoom/screens/Widgets/AppVideoPlayer.dart';

class PopularGridCard extends StatelessWidget {

  final VideoData popularCard;

  const PopularGridCard({Key key, this.popularCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5,),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ShowVid(videoURL: popularCard.videopath)));
        },
        child: Card(
          elevation: 0,
          color: Colors.white,
          child: Center(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    // Center(
                    //   child: Icon(Icons.play_circle_filled, color: Colors.deepOrangeAccent,),
                    // ),
                    AppVideoPlayer(
                      username: popularCard.userName,
                      desc: popularCard.description,
                      loc: popularCard.cityname,
                      url: popularCard.videopath,),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.memory(Uint8List.fromList(popularCard.videopath.codeUnits)),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Image(
                                  image: NetworkImage(popularCard.profileImageUrl),
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 5,),
                            Expanded(
                                flex: 12,
                                child: Text(popularCard.userName ?? "Username")),
//                            Expanded(
//                                flex: 2,
//                                child: Icon(Icons.favorite)),
//                            Expanded(
//                                flex: 3,
//                                child: Text(popularCard.likes))
                          ],
                        ),
                        Text(popularCard.description),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Icon(Icons.location_on),
                            ),
                            Expanded(
                              flex: 12,
                              child: Text(popularCard.cityname ?? "Bengaluru"),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                )
            ),
          ),
        ),
      ),
    );
  }
}
