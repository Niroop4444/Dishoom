import 'package:dishoom/api/constant.dart';
import 'package:dishoom/model/get_languages_model.dart';
import 'package:dishoom/screens/dashboard_screen.dart';
import 'package:dishoom/screens/video/movies_screen.dart';
import 'package:dishoom/widgets/interests_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagesScreen extends StatefulWidget {
  @override
  _LanguagesScreenState createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {

  String token = "";
  var jsonResponse;
  List data;
  String languageId = "";

  Future<dynamic> _getLanguagesFuture;
  @override
  void initState() {
    getToken();
    print("Token : "+token);
    _getLanguagesFuture = getLanguages();
    super.initState();
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('Accesstoken') ?? 'Access token';
    });
  }

  Future<dynamic> getLanguages() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String url = "http://dishuumdev.us-east-1.elasticbeanstalk.com/language";
    var jsonResponse;

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Client-Id': 'dishuumapp:dishumm:bd3c59bf-fa01-4fc7-aed1-4330d59d7bfd',
      'Authorization': 'Bearer $token'
    };

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      print('Response of Languages Screen: ' + response.body);
      return json.decode(response.body);
    }

    print("Response Status ofLanguages Screen: " + response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Languages',
          style: TextStyle(color: Colors.deepOrangeAccent),
        ),
        leading: new IconButton(
          icon: Image.asset(
            'assets/images/ic_logo.png',
          ),
          onPressed: () {},
        ),
      ),
      body: Material(
        color: Colors.white,
        child: Column(
          children: [
            _buildListView(),
          ],
        ),
      ),
    );
  }

  Widget _buildListView() {
    return Flexible(
        child: Container(
          child: FutureBuilder(
              future: _getLanguagesFuture,
              builder: (context, res){
                if(!res.hasData){
                  return Center(child: CircularProgressIndicator(),);
                }else{

                  GetLanguagesModel getLanguagesModel = GetLanguagesModel.fromJson(res.data);

                  return GridView.builder(
                    itemCount: getLanguagesModel.data.length,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemBuilder: (context, index) {

                      print("Language URL -"+getLanguagesModel.data[index].languageURL);
                      return _buildImageColumn(getLanguagesModel.data[index]);
                    },
                  );
                }
              }
          ),
        )
    );
  }

  Widget _buildImageColumn(Data item) =>
      GestureDetector(
        onTap: () {
          print('You Tapped ${item.languageID}');
          print("Language URL -"+item.languageURL );
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return MoviesScreen(item.languageID.toString());
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
            child: Stack(
              children: <Widget>[
                Image.network(
                  item.languageURL ?? 'https://via.placeholder.com/150',
                  fit: BoxFit.contain,
                  height: MediaQuery
                      .of(context)
                      .size.height,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                ),

              ],
            ),
          ),
        ),
      );

}
