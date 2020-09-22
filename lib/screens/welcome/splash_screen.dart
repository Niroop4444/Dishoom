import 'dart:async';
import 'package:android_intent/android_intent.dart';
import 'package:dishoom/screens/authentication/login_screen.dart';
import 'package:dishoom/screens/authentication/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dashboard_screen.dart';
import 'package:permission_handler/permission_handler.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress;

  @override
  void initState() {
    super.initState();

    requestLocationPermission();
    _gpsService();
    _getCurrentLocation();
    navigate();

    Timer(Duration(seconds: 2), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('Accesstoken');
      if(token != null){
        Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=> DashboardScreen()));
      } else {
        Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=> LoginScreen()));
      }
//      if (await FirebaseAuth.instance.currentUser() != null) {
//        Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=> DashboardScreen()));
//      } else {
//        Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=> LoginScreen()));
//      }
    });

  }

  navigate() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('Accesstoken');
    if(token != null){
      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=> DashboardScreen()));
    } else {
      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=> LoginScreen()));
    }
  }

  _getCurrentLocation() {

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
        "${place.locality}, ${place.postalCode}, ${place.country}";
        preferences.setString('location', place.locality);
        print(place.locality);
      });
    } catch (e) {
      print(e);
    }
  }


  Future<bool> _requestPermission(PermissionGroup permission) async {
    final PermissionHandler _permissionHandler = PermissionHandler();
    var result = await _permissionHandler.requestPermissions([permission]);
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  Future<bool> requestLocationPermission({Function onPermissionDenied}) async {
    var granted = await _requestPermission(PermissionGroup.location);
    if (granted != true) {
      requestLocationPermission();
    } else {
      _getCurrentLocation().then((value) async {
        if (value) {
            if (await FirebaseAuth.instance.currentUser() != null) {
              Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=> DashboardScreen()));
            } else {
              Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=> LoginScreen()));
            }
        }
      });
    }
    debugPrint('requestContactsPermission $granted');
    return granted;
  }

  Future _checkGps() async {
    if (!(await Geolocator().isLocationServiceEnabled())) {
      if (Theme.of(context).platform == TargetPlatform.android) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return WillPopScope(
                onWillPop: () {},
                child: AlertDialog(
                  title: Text("Can't get gurrent location"),
                  content: const Text(
                      'Please make sure you enable GPS and try again'),
                  actions: <Widget>[
                    FlatButton(
                        child: Text('Ok'),
                        onPressed: () {
                          final AndroidIntent intent = AndroidIntent(
                              action:
                              'android.settings.LOCATION_SOURCE_SETTINGS');
                          intent.launch();
                          Navigator.of(context, rootNavigator: true).pop();
                          _gpsService();
                        })
                  ],
                ),
              );
            });
      }
    }
  }

  Future _gpsService() async {
    if (!(await Geolocator().isLocationServiceEnabled())) {
      _checkGps();
      return null;
    } else
      return true;
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.deepOrangeAccent, Colors.deepPurple]
            ),
          ),
          child: Center(
            child: Image.asset('assets/images/ic_logo.png'),
          ),
        ),
      ),
    );
  }
}
