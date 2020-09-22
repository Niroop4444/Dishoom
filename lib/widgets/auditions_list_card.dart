import 'package:dishoom/model/auditions_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuditionsCard extends StatelessWidget {

  final AuditionsList auditions;

  AuditionsCard({Key key, this.auditions}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 24),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 100,
                    height: 120,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(auditions.imageUrl)
                        )
                    ),
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(auditions.title,
                        style: TextStyle (
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(auditions.description,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 4,
                        style: TextStyle (
                            color: Colors.grey,
                            fontSize: 12
                        ),
                      ),
                      SizedBox(height: 5,),
                      RichText(
                        text: TextSpan(
                            text: 'Conducted By : ',
                            style: TextStyle(color: Colors.grey),
                            children: <TextSpan>[
                              TextSpan(text: auditions.hostName, style: TextStyle(fontWeight: FontWeight.bold))
                            ]
                        ),
                      ),
                      SizedBox(height: 5,),
                      RichText(
                        text: TextSpan(
                            text: 'Venue : ',
                            style: TextStyle(color: Colors.grey),
                            children: <TextSpan>[
                              TextSpan(text: auditions.place, style: TextStyle(fontWeight: FontWeight.bold)),
                            ]
                        ),
                      ),
                      SizedBox(height: 5,),
                      RichText(
                        text: TextSpan(
                            text: 'Timing : ',
                            style: TextStyle(color: Colors.grey),
                            children: <TextSpan>[
                              TextSpan(text: auditions.date, style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: auditions.time, style: TextStyle(fontWeight: FontWeight.bold)),
                            ]
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
