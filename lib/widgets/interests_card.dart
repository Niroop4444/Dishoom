import 'package:flutter/material.dart';

class InterestCard extends StatelessWidget {
  final String name;
  final String image;

  InterestCard({this.name, this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.all(10),
      child: Stack(
        children: <Widget>[
          Image.network(
            image,
            fit: BoxFit.contain,
            height: 200,
            width: MediaQuery.of(context).size.width,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black),
                ),
                RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.deepOrangeAccent)),
                  onPressed: () {},
                  color: Colors.deepOrangeAccent,
                  textColor: Colors.white,
                  icon: Icon(Icons.add),
                  label: Text("Follow",
                      style: TextStyle(fontSize: 14)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
