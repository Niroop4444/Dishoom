import 'package:dishoom/model/timeline_model.dart';
import 'package:dishoom/widgets/timeline_card.dart';
import 'package:flutter/material.dart';

class TimelineScreen extends StatefulWidget {
  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {

  List<TimelineModel> posts = [
    TimelineModel(
        username: "Brianne",
        userImage:
        "https://s3.amazonaws.com/uifaces/faces/twitter/felipecsl/128.jpg",
        postImage:
        "https://images.pexels.com/photos/302769/pexels-photo-302769.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        caption: "Consequatur nihil aliquid omnis consequatur."
    ),
    TimelineModel(
        username: "Henri",
        userImage:
        "https://s3.amazonaws.com/uifaces/faces/twitter/kevka/128.jpg",
        postImage:
        "https://images.pexels.com/photos/884979/pexels-photo-884979.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        caption: "Consequatur nihil aliquid omnis consequatur."
    ),
    TimelineModel(
        username: "Mariano",
        userImage:
        "https://s3.amazonaws.com/uifaces/faces/twitter/ionuss/128.jpg",
        postImage:
        "https://images.pexels.com/photos/291762/pexels-photo-291762.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        caption: "Consequatur nihil aliquid omnis consequatur."),
    TimelineModel(
        username: "Johan",
        userImage:
        "https://s3.amazonaws.com/uifaces/faces/twitter/vinciarts/128.jpg",
        postImage:
        "https://images.pexels.com/photos/1536619/pexels-photo-1536619.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        caption: "Consequatur nihil aliquid omnis consequatur."
    ),
    TimelineModel(
        username: "London",
        userImage:
        "https://s3.amazonaws.com/uifaces/faces/twitter/ssiskind/128.jpg",
        postImage:
        "https://images.pexels.com/photos/247298/pexels-photo-247298.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        caption: "Consequatur nihil aliquid omnis consequatur."
    ),
    TimelineModel(
        username: "Jada",
        userImage:
        "https://s3.amazonaws.com/uifaces/faces/twitter/areus/128.jpg",
        postImage:
        "https://images.pexels.com/photos/169191/pexels-photo-169191.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        caption: "Consequatur nihil aliquid omnis consequatur."
    ),
    TimelineModel(
        username: "Crawford",
        userImage:
        "https://s3.amazonaws.com/uifaces/faces/twitter/oskarlevinson/128.jpg",
        postImage:
        "https://images.pexels.com/photos/1252983/pexels-photo-1252983.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        caption: "Consequatur nihil aliquid omnis consequatur."
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: posts.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index){
          return Center(
            child: TimelineCard(post: posts[index],),
          );
        });
  }
}
