import 'package:dishoom/api/login_api.dart';
import 'package:dishoom/screens/home/popular_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'timeline_screen.dart';
import 'following_screen.dart';
import 'popular_screen.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  TabController _tabController;
  String accessToken = "";

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
    _tokenRetriever();
  }

  _tokenRetriever() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken = prefs.getString('Accesstoken') ?? 'Access token';
    });
  }

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
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          filled: true,
                          hintStyle: new TextStyle(color: Colors.grey[800]),
                          hintText: "Search...",
                          fillColor: Colors.white70),
                    )
                ),
                elevation: 0,
                backgroundColor: Colors.white,
                actions: <Widget>[
                  IconButton(icon: Icon(Icons.exit_to_app, color: Colors.grey,), onPressed: () async {
                    var resp = await logout(context);
                  },)
                ],
                leading: new IconButton(icon: Image.asset('assets/images/ic_logo.png',), onPressed: (){},),
                bottom: TabBar(
                  unselectedLabelColor: Colors.deepOrangeAccent,
                  labelColor: Colors.black38,
                  tabs: <Widget>[
                    Tab(text: 'POPULAR',),
                    Tab(text: 'FOLLOWING',),
                    Tab(text: 'TIMELINE',),
                  ],
                  controller: _tabController,
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  indicatorColor: Colors.deepOrangeAccent,
                  indicatorSize: TabBarIndicatorSize.label,
                ),
                bottomOpacity: 1,
              ),
              body: TabBarView(
                children: <Widget>[
                  PopularScreen(),
                  FollowingScreen(),
                  TimelineScreen(),
                ],
                controller: _tabController,
              )
          ),
        );
      },
    );
  }
}
