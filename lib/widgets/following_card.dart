import 'package:dishoom/model/following_card_model.dart';
import 'package:dishoom/screens/home/following_user_details.dart';
import 'package:flutter/material.dart';

class FollowingCard extends StatelessWidget {

  final FollowingCardModel followingCard;

  const FollowingCard({Key key, this.followingCard}) : super (key : key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      height: 270,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image(
                      image: NetworkImage(followingCard.imageUrl),
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text(followingCard.name),
                ],
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FollowingUserDetailScreen()));
                },
                child: Row(
                  children: [
                    Text('SEE ALL'),
                    Icon(Icons.chevron_right)
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Container(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Image.network('https://i.insider.com/5e29b2bf24306a3bff2427a6?width=600&format=jpeg&auto=webp', width: 170,),
                SizedBox(width: 10,),
                Image.network('https://lh3.googleusercontent.com/proxy/MsYAe_z6WE3aUN59aPYj0BuKwlYSCQntU74ndnv7T4FuQioZ_j02hpiGFiVDlbzpzYxZEYYsY21SmOs9s6W-5-DFcpSTcC9DT7tshlo_PyshTNjjBdFGtLiDw7S7oNfJaZ59rIQrwJgeUsZ09fdNK9en8JA', width: 170,),
                SizedBox(width: 10,),
                Image.network("https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80", width: 170,),
                SizedBox(width: 10,),
                Image.network("https://myrepublica.nagariknetwork.com/uploads/media/HimaniTiktok1_20200609110512.jpg", width: 170,),
                SizedBox(width: 10,),
                Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTF5Kei9-a1m222b2pSl1gq77WffelSDO71LA&usqp=CAU", width: 170,),
              ],
            ),
          )
        ],
      ),

    );
  }
}
