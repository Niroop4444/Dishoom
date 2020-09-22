import 'package:dishoom/screens/authentication/login_screen.dart';
import 'package:dishoom/screens/authentication/registration_screen.dart';
import 'package:dishoom/screens/video/record_video_other_voice_screen.dart';
import 'package:dishoom/screens/video/watch_recorded_video_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/dashboard_screen.dart';
import 'screens/video/show_user_video_screen.dart';
import 'screens/welcome/splash_screen.dart';

void main() => runApp(MyApp());

//Future <void> main() async {
//  WidgetsFlutterBinding.ensureInitialized();
//  SharedPreferences prefs = await SharedPreferences.getInstance();
//  var user = prefs.getBool('isNewUser');
//  print(user);
//  runApp(MaterialApp(home: user == 'true' ? LoginScreen() : DashboardScreen(),));
//}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
      statusBarIconBrightness: Brightness.dark, // status bar icons' color
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepOrangeAccent
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}