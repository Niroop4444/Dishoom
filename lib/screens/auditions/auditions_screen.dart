import 'package:dishoom/screens/auditions/auditions_applied_screen.dart';
import 'package:dishoom/screens/auditions/auditions_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AuditionsScreen extends StatefulWidget {
  @override
  _AuditionsScreenState createState() => _AuditionsScreenState();
}

class _AuditionsScreenState extends State<AuditionsScreen> with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizinginformation){
        return SafeArea(
          child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                title: Text('Auditions', style: TextStyle(color: Colors.deepOrangeAccent),),
                leading: new IconButton(icon: Image.asset('assets/images/ic_logo.png',), onPressed: (){},),
                bottom: TabBar(
                  unselectedLabelColor: Colors.deepOrangeAccent,
                  labelColor: Colors.black38,
                  tabs: <Widget>[
                    Tab(text: 'AUDITIONS LIST',),
                    Tab(text: 'AUDITIONS APPLIED',),
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
                  AuditionsListScreen(),
                  AuditionsAppliedScreen(),
                ],
                controller: _tabController,
              )
          ),
        );
      },
    );
  }
}
