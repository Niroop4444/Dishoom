import 'package:dishoom/model/explore_card_model.dart';
import 'package:flutter/material.dart';

class ExploreCard extends StatelessWidget {

  final ExploreCardModel exploreCard;
  ExploreCard({Key key, this.exploreCard}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      height: 240,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(exploreCard.imageUrl, width: 25, height: 25,),
                  SizedBox(width: 10,),
                  Text(exploreCard.name),
                ],
              ),
              GestureDetector(
                onTap: (){},
                child: Row(
                  children: [
                    Text('SEE ALL'),
                    Icon(Icons.chevron_right)
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Container(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Image.network('https://www.shortmoviedb.com/wp-content/uploads/2019/02/the-jester.jpg', width: 170,),
                SizedBox(width: 10,),
                Image.network('https://i.gadgets360cdn.com/large/netflix_best_movies_may_2020_1589355119754.jpg', width: 170,),
                SizedBox(width: 10,),
                Image.network('https://akamaividz2.zee5.com/image/upload/w_599,h_337,c_scale,f_auto,q_auto/resources/0-0-198669/app_cover/1170x658withlog_1203307283.jpg', width: 170,),
                SizedBox(width: 10,),
                Image.network('https://m.economictimes.com/thumb/msid-76000214,width-1200,height-676,resizemode-4,imgsize-405086/a-popular-20-year-old-youtuber-had-just-uploaded-a-video-curiously-titled-youtube-vs-tiktok-the-end-that-was-on-course-to-become-indias-most-liked-non-music-video-on-youtube.jpg', width: 170,),
                SizedBox(width: 10,),
                Image.network('https://i.dailymail.co.uk/1s/2020/04/29/03/27777780-8267653-image-m-44_1588128633225.jpg', width: 170,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
