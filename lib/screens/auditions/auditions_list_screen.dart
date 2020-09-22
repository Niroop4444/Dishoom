import 'package:dishoom/model/auditions_list_model.dart';
import 'package:dishoom/widgets/auditions_list_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuditionsListScreen extends StatefulWidget {
  @override
  _AuditionsListScreenState createState() => _AuditionsListScreenState();
}

class _AuditionsListScreenState extends State<AuditionsListScreen> {

  List<AuditionsList> auditions = [
    AuditionsList(title: 'Audition 1', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.', imageUrl: 'https://i0.wp.com/www.socialnews.xyz/wp-content/uploads/2019/04/21/KGF-Chapter-2-Audition-Details-Poster-.png?fit=960%2C1280&quality=90&zoom=1&ssl=1', hostName: 'Nikhil Forrest', place: 'Mysuru', date: '30th Aug 2020, ', time: '10 AM'),
    AuditionsList(title: 'Audition 2', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.', imageUrl: 'https://i.pinimg.com/736x/e7/6e/fd/e76efd3c4ccb2d3d4ed4db61caddb2cf.jpg', hostName: 'Nikhil Forrest', place: 'Mysuru', date: '30th Aug 2020, ', time: '10 AM'),
    AuditionsList(title: 'Audition 3', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.', imageUrl: 'https://pub-static.haozhaopian.net/assets/projects/pages/bdb5d00b-1561-40bf-8d9c-7fedd8fd6155_b8d1c9a0-48d2-449f-afd9-c95b28a36af4_thumb.jpg', hostName: 'Nikhil Forrest', place: 'Mysuru', date: '30th Aug 2020, ', time: '10 AM'),
    AuditionsList(title: 'Audition 4', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.', imageUrl: 'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/f696922e-c6a4-4c79-9581-543908d6e04b/d2mm3p7-4a18849e-2b88-4e51-b201-ba8233cba033.jpg/v1/fill/w_900,h_1243,q_75,strp/music_madness_audition_poster_by_stella08_d2mm3p7-fullview.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOiIsImlzcyI6InVybjphcHA6Iiwib2JqIjpbW3siaGVpZ2h0IjoiPD0xMjQzIiwicGF0aCI6IlwvZlwvZjY5NjkyMmUtYzZhNC00Yzc5LTk1ODEtNTQzOTA4ZDZlMDRiXC9kMm1tM3A3LTRhMTg4NDllLTJiODgtNGU1MS1iMjAxLWJhODIzM2NiYTAzMy5qcGciLCJ3aWR0aCI6Ijw9OTAwIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmltYWdlLm9wZXJhdGlvbnMiXX0.CtGK5S9wKB3IQ7Iyk9BgHkvLw98jgsjvQVnaOtz1-sw', hostName: 'Nikhil Forrest', place: 'Mysuru', date: '30th Aug 2020, ', time: '10 AM'),
    AuditionsList(title: 'Audition 5', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTkGL4kGGjVIwl4DUpneAkEr1ivCl1q2ZsSxw&usqp=CAU', hostName: 'Nikhil Forrest', place: 'Mysuru', date: '30th Aug 2020, ', time: '10 AM'),
    AuditionsList(title: 'Audition 6', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.', imageUrl: 'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/casting-call-design-template-937cf8e2e57640cab696db7e014f84a3.jpg?ts=1561400145', hostName: 'Nikhil Forrest', place: 'Mysuru', date: '30th Aug 2020, ', time: '10 AM'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: auditions.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index){
          return Center(
            child: AuditionsCard(auditions: auditions[index],),
          );
        });
  }
}
