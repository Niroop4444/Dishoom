import 'package:dishoom/model/timeline_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class TimelineCard extends StatelessWidget {
  final TimelineModel post;

  TimelineCard({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image(
                        image: NetworkImage(post.userImage),
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(post.username),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(FontAwesome.send_o),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal : 18.0),
            child: FadeInImage(
              image: NetworkImage(post.postImage),
              placeholder: AssetImage('assets/images/ic_placeholder.png'),
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(FontAwesome.heart_o),
                  ),
                ],
              )
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(
              horizontal: 14,
            ),
            child: RichText(
              softWrap: true,
              overflow: TextOverflow.visible,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Liked By ",
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: "Sigmund,",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: " Yessenia,",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: " Dayana",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: " and",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: " 1263 others",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 5,
            ),
            child: RichText(
              softWrap: true,
              overflow: TextOverflow.visible,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: post.username,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: " ${post.caption}",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 14,
            ),
            alignment: Alignment.topLeft,
            child: Text(
              "August 2020",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
