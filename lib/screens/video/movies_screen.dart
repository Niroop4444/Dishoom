import 'package:dishoom/api/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'audio_library_screen.dart';

class MoviesScreen extends StatefulWidget {
  final String languageId;

  MoviesScreen(this.languageId);

  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {

  List data;
  String movieId = "";
  var jsonResponse;
  String token = "";
  String movuieId = "";

  @override
  void initState() {
    getToken();
    getMovies();
    super.initState();
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('Accesstoken') ?? 'Access token';
    });
  }

  getMovies() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String url = Constant.moviesUrl+widget.languageId;
    print("URL - "+url);
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
      print('Response of Movies Screen: ' + response.body);
      jsonResponse = json.decode(response.body);
    }

    print("Response Status of Movies Screen : " + response.body);
  }


  @override
  Widget build(BuildContext context) {
    print(widget.languageId);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Movies', style: TextStyle(color: Colors.deepOrangeAccent)),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: new IconButton(
          icon: Image.asset(
            'assets/images/ic_logo.png',
          ),
          onPressed: () {},
        ),
      ),
      body: Column(
        children: [
          _buildListView(),
        ],
      ),
    );
  }

  Widget _buildListView(){
    return Flexible(
      child: Container(
        child: GridView.builder(
            itemCount: data == null ? 0 : data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index){
              return _buildImageColumn(data[index]);
            }),
      ),
    );
  }

  _buildImageColumn(dynamic item) => GestureDetector(
    onTap: () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var movie = prefs.setString('movieid', item['movieID']);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return AudioLibraryScreen();
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
              item['movieURL'],
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
