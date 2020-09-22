import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ExploreDetailsScreen extends StatefulWidget {
  @override
  _ExploreDetailsScreenState createState() => _ExploreDetailsScreenState();
}

class _ExploreDetailsScreenState extends State<ExploreDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizingImformation){
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: new IconButton(icon: Image.asset('assets/images/ic_logo.png',), onPressed: (){},),
            ),
            body: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Container(
                    height: 20,
                    child: ListView(
                      children: [

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
