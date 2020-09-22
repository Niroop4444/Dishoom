import 'package:flutter/material.dart';

class LeftPanel extends StatelessWidget {
  final String name;
  final String caption;
  final String songName;
  const LeftPanel({
    Key key,
    this.name,
    this.caption,
    this.songName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            caption,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.music_note,
                color: Colors.white,
                size: 15,
              ),
              Flexible(
                child: Text(
                  songName,
                  style: TextStyle(color: Colors.white, height: 1.5),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}