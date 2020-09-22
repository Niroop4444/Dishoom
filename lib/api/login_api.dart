import 'package:dishoom/api/constant.dart';
import 'package:dishoom/screens/authentication/login_screen.dart';
import 'package:dishoom/screens/dashboard_screen.dart';
import 'package:dishoom/screens/video/languages_screen.dart';
import 'package:dishoom/screens/video/record_video_other_voice_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../screens/welcome/interest_screen.dart';

BuildContext context;

Future emailLogin(String email, BuildContext context) async {

  bool isLoading = false;

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String url = Constant.loginUrl;
  var jsonResponse;
  Map<String, String> headers = {'Content-Type' : 'application/json', 'Client-Id' : 'dishuumapp:dishumm:bd3c59bf-fa01-4fc7-aed1-4330d59d7bfd'};
  var body = json.encode({'email' : email, 'notificationToken' : 'mockToken:APA91bHwJIAt27jvfzeJW2ElwJne-2BC2LrtSqq1l1FFz5TwnrxzNpYnVCN1Rr-PVKJLUe21ajtWl8lZltJ29fYZ3V2R9SbAO4rHc44j7c8IzaoUatXWu'});

  final response = await http.post(url,
      headers: headers,
      body: body
  );


  if(response.statusCode == 200) {
    print('Inside body');
    jsonResponse = json.decode(response.body);
    print("Response Status : ${response.statusCode}");
    print("Response Status : ${response.body}");
    print("Token - "+jsonResponse['data']['token']['Accesstoken']);

    if(jsonResponse != null){
      sharedPreferences.setBool('isNewUser', jsonResponse['data']['isNewUser']);
      sharedPreferences.setString('UserId', jsonResponse['data']['customerUUID']);
      sharedPreferences.setString('UserName', jsonResponse['data']['userName']);
      sharedPreferences.setString('Accesstoken', jsonResponse['data']['token']['Accesstoken']);
      sharedPreferences.setString('Refreshtoken', jsonResponse['data']['token']['Refreshtoken']);
      sharedPreferences.setInt('ExpirationPeriod', jsonResponse['data']['token']['expirationperiod']);
      var user = sharedPreferences.getBool('isNewUser');
      if(user == true){
        Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=> InterestScreen()));
      } else {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => DashboardScreen()), (Route<dynamic> route) => false);
      }

    }

  }

  print("Response Status : "+response.body);

}

Future phoneLogin(String phone, BuildContext context) async {

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String url = Constant.loginUrl;
  Map<String, String> headers = {'Content-Type' : 'application/json', 'Client-Id' : 'dishuumapp:dishumm:bd3c59bf-fa01-4fc7-aed1-4330d59d7bfd'};
  var body = json.encode({'phone' : phone, 'notificationToken' : 'mockToken:APA91bHwJIAt27jvfzeJW2ElwJne-2BC2LrtSqq1l1FFz5TwnrxzNpYnVCN1Rr-PVKJLUe21ajtWl8lZltJ29fYZ3V2R9SbAO4rHc44j7c8IzaoUatXWu'});
  var jsonResponse;
  final response = await http.post(url,
      headers: headers,
      body: body
  );

  if(response.statusCode == 200) {
    print('Inside body');
    jsonResponse = json.decode(response.body);
    print("Response Status : ${response.statusCode}");
    print("Response Status : ${response.body}");

    if(jsonResponse != null){
      sharedPreferences.setBool('isNewUser', jsonResponse['data']['isNewUser']);
      sharedPreferences.setString('UserId', jsonResponse['data']['customerUUID']);
      sharedPreferences.setString('UserName', jsonResponse['data']['userName']);
      sharedPreferences.setString('Accesstoken', jsonResponse['data']['token']['Accesstoken']);
      sharedPreferences.setString('Refreshtoken', jsonResponse['data']['token']['Refreshtoken']);
      sharedPreferences.setInt('ExpirationPeriod', jsonResponse['data']['token']['expirationperiod']);
      var user = sharedPreferences.getBool('isNewUser');
      if(user == true){
        Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=> InterestScreen()));
      } else {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => DashboardScreen()), (Route<dynamic> route) => false);
      }
    }

  }

  print("Response Status : "+response.body);

}

Future logout(BuildContext context) async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString('Accesstoken');
  String url = Constant.logoutUrl;
  var jsonResponse;
  Map<String, String> headers = {'Content-Type' : 'application/json', 'Client-Id' : 'dishuumapp:dishumm:bd3c59bf-fa01-4fc7-aed1-4330d59d7bfd', 'Authorization' : 'Bearer $accessToken'};

  final response = await http.post(url, headers: headers);


  if(response.statusCode == 200){
    jsonResponse = json.decode(response.body);
    if(jsonResponse != null){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginScreen()), (Route<dynamic> route) => false);
    }
  }
  print(jsonResponse);

}