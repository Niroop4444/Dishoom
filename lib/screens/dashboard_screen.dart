import 'package:dishoom/screens/profile/profile_screen.dart';
import 'package:dishoom/screens/video/languages_screen.dart';
import 'package:dishoom/screens/video/record_video_other_voice_screen.dart';
import 'package:dishoom/widgets/fab_bottom_app_bar_widget.dart';
import 'package:dishoom/widgets/fab_with_icons_widget.dart';
import 'package:dishoom/widgets/layout.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicorndial/unicorndial.dart';

import 'auditions/auditions_screen.dart';
import 'explore/explore_screen.dart';
import 'home/home_screen.dart';
import 'video/record_video_own_voice_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animationIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;
  String _lastSelected = 'TAB: 0';

  void _selectedTab(int index) {
    setState(() {
      _lastSelected = 'TAB: $index';
    });
  }

  @override
  void initState()  {
    getToken();
    super.initState();
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var token = prefs.getString('Accesstoken') ?? 'Access token';
      print("Token - "+token);
    });
  }

  void _selectedFab(int index) {
    setState(() {
      _lastSelected = 'FAB: $index';
    });
  }

  int _currentTab = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen();

  bool isClicked = false;

  Widget buttonVoice() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {},
        tooltip: "Add",
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buttonAudio() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {},
        tooltip: "Add",
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buttonToggle() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: "Add",
        child: AnimatedIcon(
          icon: AnimatedIcons.add_event,
          progress: _animationIcon,
        ),
      ),
    );
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
      isOpened != isOpened;
    }
  }

  Widget _profileOption({IconData iconData, Function onPressed, String tag}) {
    return UnicornButton(
        currentButton: FloatingActionButton(
          heroTag: tag,
          backgroundColor: Colors.deepOrangeAccent,
          child: Icon(iconData),
          mini: true,
          onPressed: onPressed,
    ));
  }

  List<UnicornButton> _getProfileMenu() {
    List<UnicornButton> children = [];

    children.add(_profileOption(
      tag: 'LanguageBtn',
        iconData: Icons.videocam,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => LanguagesScreen()));
        }));
    children.add(_profileOption(
      tag: 'RecordBtn',
        iconData: Icons.mic,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RecordVideoOwnVoiceScreen()));
        }));

    return children;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical:18.0),
        child: UnicornDialer(
          parentButtonBackground: Colors.deepOrangeAccent,
          orientation: UnicornOrientation.VERTICAL,
          parentButton: Icon(Icons.add),
          childButtons: _getProfileMenu(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        notchMargin: 10,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(40))),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = HomeScreen();
                        _currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          color: _currentTab == 0
                              ? Colors.deepOrangeAccent
                              : Colors.grey,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                              color: _currentTab == 0
                                  ? Colors.deepOrangeAccent
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = ExploreScreen();
                        _currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.search,
                          color: _currentTab == 1
                              ? Colors.deepOrangeAccent
                              : Colors.grey,
                        ),
                        Text(
                          'Discover',
                          style: TextStyle(
                              color: _currentTab == 1
                                  ? Colors.deepOrangeAccent
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = AuditionsScreen();
                        _currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.videocam,
                          color: _currentTab == 2
                              ? Colors.deepOrangeAccent
                              : Colors.grey,
                        ),
                        Text(
                          'Auditions',
                          style: TextStyle(
                              color: _currentTab == 2
                                  ? Colors.deepOrangeAccent
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = ProfileScreen();
                        _currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color: _currentTab == 3
                              ? Colors.deepOrangeAccent
                              : Colors.grey,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                              color: _currentTab == 3
                                  ? Colors.deepOrangeAccent
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFab(BuildContext context) {
    final icons = [ Icons.sms, Icons.mail, Icons.phone ];
    return AnchoredOverlay(
      showOverlay: true,
      overlayBuilder: (context, offset) {
        return CenterAbout(
          position: Offset(offset.dx, offset.dy - icons.length * 35.0),
          child: FabWithIcons(
            icons: icons,
            onIconTapped: _selectedFab,
          ),
        );
      },
      child: FloatingActionButton(
        onPressed: () { },
        tooltip: 'Increment',
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
    );
  }

  Widget _bottomButtons() {
    return _currentTab == 0
        ? FloatingActionButton(
            shape: StadiumBorder(),
            onPressed: null,
            backgroundColor: Colors.redAccent,
            child: Icon(
              Icons.message,
              size: 20.0,
            ))
        : FloatingActionButton(
            shape: StadiumBorder(),
            onPressed: null,
            backgroundColor: Colors.redAccent,
            child: Icon(
              Icons.edit,
              size: 20.0,
            ),
          );
  }
}
