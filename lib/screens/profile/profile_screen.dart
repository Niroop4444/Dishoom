import 'package:dishoom/api/constant.dart';
import 'package:dishoom/screens/authentication/login_screen.dart';
import 'package:dishoom/screens/video/show_user_video_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String token = "";
  var jsonResponse;
  String username = "";
  String emailId = "";
  String phoneNumber = "";
  String profileImageUrl ="";
  List data;

  @override
  void initState() {
    getToken();
    getProfile();
    super.initState();
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('Accesstoken') ?? 'Access token';
    });
  }

  getProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String url = Constant.profileUrl;
    var jsonResponse;

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Client-Id': 'dishuumapp:dishumm:bd3c59bf-fa01-4fc7-aed1-4330d59d7bfd',
      'Authorization': 'Bearer $token'
    };

    final response = await http.get(url, headers: headers);
    setState(() {
      data = json.decode(response.body)['data']['videodetails'];
    });
    print("Data in Profile Screen- "+data.toString());
    if (response.statusCode == 200) {
      print('Response in Profile Screen: ' + response.body);
      jsonResponse = json.decode(response.body);
      setState(() {
        username = jsonResponse['data']['username'];
        profileImageUrl = jsonResponse['data']['profileImageUrl'];
        phoneNumber = jsonResponse['data']['phone'];
        emailId = jsonResponse['data']['emailId'];
      });
      print("Phone number" + phoneNumber);
    }

    print("Response Status : " + response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.deepOrangeAccent),
        ),
        leading: new IconButton(
          icon: Image.asset(
            'assets/images/ic_logo.png',
          ),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.more_vert,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: Colors.white54),
          child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15))),
            child: Column(
              children: [
                _user(),
                _uploads(),
                RaisedButton(
                  child: Text('Logout'),
                  onPressed: (){

                    try {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=> LoginScreen()));
                    }catch(e){}

                  },
                ),
                SizedBox(height: 100,)
              ],
            ),
          )
      ),
    );
  }

  Widget _user() {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal : 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(child: Text('Invite', style: TextStyle(color: Colors.deepOrangeAccent, fontWeight: FontWeight.bold),)),
                  IconButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen(initUsername: username, initPhone: phoneNumber, initEmail: emailId,)));
                    },
                    icon: Icon(FontAwesomeIcons.edit, color: Colors.deepOrangeAccent,),)
                ],
              ),
            ),
            SizedBox(height: 30,),
            CircleAvatar(
              radius: 54,
              backgroundColor: Colors.deepOrangeAccent,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(profileImageUrl),
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Username : -',
                  style: TextStyle(color: Colors.black,),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  username=="" ? "Username": username,
                  style: TextStyle(color: Colors.black,),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Phone Number : -',
                  style: TextStyle(color: Colors.black,),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  phoneNumber=="" ? "XXXXXXXXXX" : phoneNumber,
                  style: TextStyle(color: Colors.black,),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Email Id : -',
                  style: TextStyle(color: Colors.black,),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  emailId =="" ? "youremailid@address.com" : emailId,
                  style: TextStyle(color: Colors.black,),
                ),
              ],
            ),
          ],
        ));
  }

  Widget _uploads(){
    return Flexible(
      child: Container(
        child: GridView.builder(
            itemCount: data == null ? 0 : data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder:  (context, index){
              return _buildImageColumn(data[index]);
            }),
      ),
    );
  }

  _buildImageColumn(dynamic item) => GestureDetector(
    onTap: (){
      print('You Tapped ${item['videopath']}');
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ShowUserVideoScreen(videoURL: item['videopath'].toString());
      }));
    },
    child: Container(
        decoration: BoxDecoration(color: Colors.white54),
        margin: const EdgeInsets.all(4),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)),
          margin: EdgeInsets.all(10),
          child: Image.network('https://theyearsproject.com/wp-content/uploads/2018/02/video-placeholder.jpg'),
        )
    ),
  );
}
