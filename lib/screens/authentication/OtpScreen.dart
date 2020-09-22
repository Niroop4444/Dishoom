import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dishoom/screens/dashboard_screen.dart';
import 'package:dishoom/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Widgets/OtpInput.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({this.otpNumber});
  String otpNumber;

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Control the input text field.
  TextEditingController _pinEditingController = TextEditingController();
  String otpstatus = "";
  bool otpbutton = false;

  PinDecoration _pinDecoration = UnderlineDecoration(
    enteredColor: Colors.black,
  );
  bool isCodeSent = false;
  String _verificationId;

  /// Decorate the outside of the Pin.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _onVerifyCode();
  }

  @override
  Widget build(BuildContext context) {
    print("isValid - $isCodeSent");
    print("mobile ${widget.otpNumber}");
    return Scaffold(
      appBar:  AppBar(
        title: Text('OTP', style: TextStyle(color: Colors.deepOrangeAccent)),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: new IconButton(
          icon: Image.asset(
            'assets/images/ic_logo.png',
          ),
          onPressed: () {},
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: EdgeInsets.all(50),
                          child: PinInputTextField(
                            pinLength: 6,
                            decoration: _pinDecoration,
                            controller: _pinEditingController,
                            autoFocus: true,
                            textInputAction: TextInputAction.done,
                            onSubmit: (pin) {
                              if (pin.length == 6) {
                                _onFormSubmitted();
                              }
                            },
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: isCodeSent == true
                            ? Text('waiting for OTP')
                            : RaisedButton(
                          child: Text('Resend OTP'),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(10),
                          child: isCodeSent == true
                              ? RaisedButton(
                            child: Text('Verify OTP'),
                            onPressed: () {
                              if (_pinEditingController.text.length ==
                                  6) {
                                _onFormSubmitted();
                              } else {
                                showToast("Invalid OTP", Colors.red);
                              }
                            },
                          )
                              : null),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void showToast(message, Color color) {
    print(message);
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _onVerifyCode() async {
    setState(() {
      isCodeSent = true;
    });
    final PhoneVerificationCompleted verificationCompleted = (AuthCredential phoneAuthCredential) {
      _firebaseAuth
          .signInWithCredential(phoneAuthCredential)
          .then((AuthResult value) async {
        if (value.user != null) {
          // Handle loogged in state
          print(value.user.phoneNumber);

          //todo: login user and send to corresponding screen

          //

          // user verified
          Navigator.push(context, new MaterialPageRoute(builder: (context)=> DashboardScreen()));


        } else {
          showToast("Error validating OTP, try again", Colors.red);
        }
      }).catchError((error) {
        showToast("Try again in sometime", Colors.red);
      });
    };
    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      showToast(authException.message, Colors.red);
      setState(() {
        isCodeSent = false;
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      _verificationId = verificationId;
      setState(() {
        otpstatus = "Waiting for OTP";

        _verificationId = verificationId;
      });
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };

    // TODO: Change country code

    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "${widget.otpNumber}",
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void _onFormSubmitted() async {
    AuthCredential _authCredential = PhoneAuthProvider.getCredential(
        verificationId: _verificationId, smsCode: _pinEditingController.text);

    _firebaseAuth
        .signInWithCredential(_authCredential)
        .then((AuthResult value) async {
      if (value.user != null) {
        // Handle loogged in state
        print(value.user.phoneNumber);

        //todo: login user and send to corresponding screen
        // user verified

        Navigator.push(context, new MaterialPageRoute(builder: (context)=> DashboardScreen()));


      } else {
        showToast("Error validating OTP, try again", Colors.red);
      }
    }).catchError((error) {
      showToast("Something went wrong", Colors.red);
    });
  }
}
