import 'package:cached_network_image/cached_network_image.dart';
import 'package:dishoom/api/constant.dart';
import 'package:dishoom/model/interest_model.dart';
import 'package:dishoom/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class InterestScreen extends StatefulWidget {
  @override
  _InterestScreenState createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  String token = "";
  var jsonResponse;
  List data;
  String interestId = "";
  String textHolder = 'Follow';
  Map<int, bool> isSelectedMap = new Map();
  List<String> inter = [];
  var selectedInterest = new InterestsModel();

  List<InterestsModel> interests;
  List<InterestsModel> selectedInterests;

  @override
  void initState() {
    getToken();
    getInterests();
    super.initState();
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('Accesstoken') ?? 'Access token';
    });
  }

  getInterests() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String url = Constant.interestUrl;
    var jsonResponse;

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Client-Id': 'dishuumapp:dishumm:bd3c59bf-fa01-4fc7-aed1-4330d59d7bfd',
      'Authorization': 'Bearer $token'
    };

    final response = await http.get(url, headers: headers);
    setState(() {
      data = json.decode(response.body)['data'];
    });
    if (response.statusCode == 200) {
      print('Response : ' + response.body);
      jsonResponse = json.decode(response.body);
    }

    print("Response Status : " + response.body);
  }

  postInterests() async {
    print('asdasdas');
    String url = Constant.interestUrl;
    var jsonResponse;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Client-Id': 'dishuumapp:dishumm:bd3c59bf-fa01-4fc7-aed1-4330d59d7bfd',
      'Authorization': 'Bearer $token'
    };

    print('interest inside api functions: '+inter.toString());
    var body = json.encode({'intrestarray': inter});

    final response = await http.put(url, headers: headers, body: body);
    print(response);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print("Response Status of Interest Screen: ${response.body}");
      if (jsonResponse != null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DashboardScreen()));
      }
    }
    print("Response Status of Interest Screen: " + response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Interests',
          style: TextStyle(color: Colors.deepOrangeAccent),
        ),
        leading: new IconButton(
          icon: Image.asset(
            'assets/images/ic_logo.png',
          ),
          onPressed: () {},
        ),
      ),
      body: Column(
        children: [
//          SizedBox(height: 30,),
//          _appBar(),
          _buildListView(),
          _buttonNext(),
        ],
      ),
    );
  }

  Widget _appBar(){
    return Container(
      height: 40,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:15.0),
        child: Row(
          children: [
          Image.asset(
                'assets/images/ic_logo.png',
              ),
            SizedBox(width: 20,),
            Text('Interests',
          style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 25),)
          ],
        ),
      ),
    );
  }

  Widget _buildListView() {
    return Flexible(
      child: Container(
        child: GridView.builder(
          itemCount: data == null ? 0 : data.length,
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {

            isSelectedMap.putIfAbsent(index, () => false);

            return _buildImageColumn(data[index], index);
          },
        ),
      ),
    );
  }

  Widget _buildImageColumn(dynamic item, int index) => GestureDetector(
//        onTap: () {
//          setState(() {
//            inter.add(item['intrestID']);
//            isSelectedMap.update(index, (value) => !value);
//          });
//          print('You Added ${item['intrestID']}');
//        },
//        onDoubleTap: () {
//          setState(() {
//            inter.remove(item['intrestID']);
//            isSelectedMap.update(index, (value) => !value);
//          });
//          print('You Removed ${item['intrestID']}');
//        },
    child: Container(
      decoration: BoxDecoration(color: Colors.white54),
      margin: const EdgeInsets.all(4),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.all(10),
        child: Stack(
          children: <Widget>[
            Image.network(
              item['intrestURL'],
              height: 120,
              width: MediaQuery.of(context).size.width,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: <Widget>[
                  Text(
                    item['intrest'],
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  isSelectedMap[index]
                      ? RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(
                            color: Colors.deepOrangeAccent)),
                    onPressed: () {
                      setState(() {
                        inter.remove(item['intrestID']);
                        isSelectedMap.update(index, (value) => !value);
                      });
                    },
                    color: Colors.deepOrangeAccent,
                    textColor: Colors.white,
                    icon: Icon(Icons.add),
                    label: Text('Followed',
                        style: TextStyle(fontSize: 14)),
                  )
                      : RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(
                            color: Colors.deepOrangeAccent)),
                    onPressed: () {
                      setState(() {
                        inter.add(item['intrestID']);
                        isSelectedMap.update(index, (value) => !value);
                      });
                    },
                    color: Colors.deepOrangeAccent,
                    textColor: Colors.white,
                    icon: Icon(Icons.add),
                    label: Text('Follow',
                        style: TextStyle(fontSize: 14)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _buttonNext() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Material(
          type: MaterialType.transparency,
          child: Ink(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.deepOrangeAccent, width: 4.0),
              color: Colors.deepOrange.withOpacity(0.7),
              shape: BoxShape.circle,
            ),
            child: InkWell(
              onTap: () {
                setState(() {
                  showLoaderDialog(context);
                });
                postInterests();
                print('Selected Interests : ' + inter.toString());
              },
              borderRadius: BorderRadius.circular(100.0),
              //Something large to ensure a circle
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
        content: Wrap(
          children: [
            SpinKitDoubleBounce(
              color: Colors.deepOrangeAccent,
            ),
            Align(
                alignment: Alignment.center,
                child: Text(
                  "Loading...",
                  textAlign: TextAlign.center,
                )),
          ],
        ));
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
