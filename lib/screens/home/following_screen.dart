import 'package:dishoom/model/following_card_model.dart';
import 'package:dishoom/widgets/following_card.dart';
import 'package:flutter/material.dart';

class FollowingScreen extends StatefulWidget {
  @override
  _FollowingScreenState createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {

  List<FollowingCardModel> cards = const [
    const FollowingCardModel(name: 'Abhishek', imageUrl: 'https://s3.amazonaws.com/uifaces/faces/twitter/felipecsl/128.jpg',),
    const FollowingCardModel(name: 'Anjana', imageUrl: 'https://s3.amazonaws.com/uifaces/faces/twitter/kevka/128.jpg',),
    const FollowingCardModel(name: 'Abhilash', imageUrl: 'https://s3.amazonaws.com/uifaces/faces/twitter/ionuss/128.jpg',),
    const FollowingCardModel(name: 'Anirudh', imageUrl: 'https://s3.amazonaws.com/uifaces/faces/twitter/vinciarts/128.jpg',),
  ];


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16),
      itemCount: cards.length,
      itemBuilder: (BuildContext context,int index){
        return Center(
          child: FollowingCard(followingCard: cards[index],),
        );
      },
    );
  }
}