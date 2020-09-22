import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Wrap(
          children: [
            SpinKitDoubleBounce(color: Colors.deepOrangeAccent,),
            Align(
                alignment: Alignment.center,
                child: Text("Loading...", textAlign: TextAlign.center, )),
          ],
        )
    );
  }
}
