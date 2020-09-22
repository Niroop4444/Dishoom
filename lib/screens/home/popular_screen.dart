import 'package:dishoom/api/constant.dart';
import 'package:dishoom/model/get_videos_model.dart';
import 'package:dishoom/widgets/popular_grid_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class PopularScreen extends StatefulWidget {
  @override
  _PopularScreenState createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {

  String token = "";
  List data;
  List<String> videopathList;

  List<VideoData> videosData = new List();

  @override
  void initState() {
    videopathList = new List();
    getToken();
    super.initState();
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('Accesstoken') ?? 'Access token';
    });
  }

  Future<dynamic> getVideos() async {
    String url = Constant.videoUploadUrl;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var location = prefs.getString('location');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Client-Id': 'dishuumapp:dishumm:bd3c59bf-fa01-4fc7-aed1-4330d59d7bfd',
      'Authorization': 'Bearer $token'
    };

    final response = await http.get(url + '?city=Bangalore', headers: headers);
    print("URL Of Profile screen"+response.toString());
    print("Data In Popular Screen - " + data.toString());
    if (response.statusCode == 200) {
      print('Response : ' + response.body);
      return json.decode(response.body);
    }

    print("Response Status : " + response.body);
  }

  Future<String> getThumbnailFromVideoUrl(String videoUrl) async {
    final uint8list = await VideoThumbnail.thumbnailFile(
      video: videoUrl,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.WEBP,
      maxHeight: 64,
      // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 75,
    );

    return uint8list;
  }


  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return FutureBuilder(
          future: getVideos(),
          builder: (context, res) {
            if (!res.hasData) {
              return Center(child: CircularProgressIndicator(),);
            } else {
              GetVideosModel getVideosModel = GetVideosModel.fromJson(res.data);
              return GridView.builder(
                  itemCount: getVideosModel.data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    getThumbnailFromVideoUrl(
                        getVideosModel.data[index].videopath)
                        .then((thumbUrl) {});
                    videosData.add(VideoData(
                        userName: getVideosModel.data[index].userName,
                        description: getVideosModel.data[index].description,
                        videopath: getVideosModel.data[index].videopath,
                        profileImageUrl: getVideosModel.data[index]
                            .profileImageUrl
                    ),);
                    return Center(
                      child: PopularGridCard(
                        popularCard: videosData[index],
                      ),
                    );
                  }
              );
            }
          },
        );
      },
    );
  }

}
