import 'package:dishoom/model/explore_card_model.dart';
import 'package:dishoom/widgets/explore_card.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {



  List<ExploreCardModel> cards = const [
    const ExploreCardModel(name: 'Comedy', imageUrl: 'assets/images/ic_profile_1.png',),
    const ExploreCardModel(name: 'Drama', imageUrl: 'assets/images/ic_profile_1.png',),
    const ExploreCardModel(name: 'Romance', imageUrl: 'assets/images/ic_profile_1.png',),
    const ExploreCardModel(name: 'Traditional', imageUrl: 'assets/images/ic_profile_1.png',),
  ];


  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizinginformation){
        return SafeArea(
          child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Color(0xFFCCD1D1),
                  ),
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.search),
                      hintText: "Search...",
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
                elevation: 0,
                backgroundColor: Colors.white,
                actions: <Widget>[
                  IconButton(icon: Icon(Icons.more_vert,), onPressed: (){},)
                ],
                leading: new IconButton(icon: Image.asset('assets/images/ic_logo.png',), onPressed: (){},),
              ),
              body: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: cards.length,
                itemBuilder: (BuildContext context,int index){
                  return Center(
                    child: ExploreCard(exploreCard: cards[index],),
                  );
                },
              )
          ),
        );
      },
    );
  }
}
