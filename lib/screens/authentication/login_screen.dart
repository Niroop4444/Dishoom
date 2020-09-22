import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dishoom/api/constant.dart';
import 'package:dishoom/api/login_api.dart';
import 'package:dishoom/screens/authentication/OtpScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dashboard_screen.dart';
import 'registration_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>  with TickerProviderStateMixin {

  SharedPreferences localStorage;

  final phoneFormKey = new GlobalKey<FormState>();
  final emailFormKey = new GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String message;
  int _state = 0;
  bool _isLoading = false;
  var countrycode;
  bool _passwordVisible;
  String countryCode = "";
  bool _isButtonDisabled;

  static Future init() async {

  }

  @override
  void initState() {
    _passwordVisible = false;
    _isButtonDisabled = true;
  }

  @override
  void dispose(){
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizingInformation) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.20,
                    child: Image.asset('assets/images/ic_icon.png'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  margin: EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(1.0, 1.0),
                          blurRadius: 6.0),
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero,
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                        ),
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 58.0, vertical: 18),
                        child: Divider(),
                      ),
                      Text(
                        'Login with',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: phoneFormKey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 7,
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                controller: _phoneController,
                                validator: (String text) {
                                  if (text.length == 0) {
                                    return 'Phone number cannot be empty';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  prefixIcon: CountryCodePicker(
                                    initialSelection: 'IN',
                                    favorite: ['+91', 'IN'],
                                    onInit: (code) => countryCode = code.dialCode,
                                    onChanged: (code) => countryCode = code.dialCode,
                                  ),
                                  hintText: "Enter Phone Number",
                                  fillColor: Color(0xFFF2F2F2),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Color(0xFFF2F2F2),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                cursorColor: Colors.deepOrangeAccent,
                                autofocus: false,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 2,
                              child: Material(
                                type: MaterialType.transparency,
                                child: Ink(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.deepOrangeAccent,
                                        width: 4.0),
                                    color: Colors.deepOrange.withOpacity(0.7),
                                    shape: BoxShape.circle,
                                  ),
                                  child: InkWell(
                                    onTap: () async {
                                      if(phoneFormKey.currentState.validate()){
                                        String phone = countryCode + _phoneController.text;

                                        Navigator.push(context, new MaterialPageRoute(builder: (context)=> OtpScreen(otpNumber: phone,)));


                                        //                                         setState(() {
                                        //   showLoaderDialog(context);
                                        // });
                                        var resp = await phoneLogin(phone, context);
                                      }
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
                          ],
                        ),
                      ),
                      new Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 2.0, color: Colors.deepOrangeAccent),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("OR", style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                      ),
                      Form(
                        key: emailFormKey,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 7,
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailController,
                                validator: (String text) {
                                  if (text.length == 0) {
                                    return 'Email cannot be empty';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email),
                                  hintText: "Enter Email Address",
                                  fillColor: Color(0xFFF2F2F2),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Color(0xFFF2F2F2),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                cursorColor: Colors.deepOrangeAccent,
                                autofocus: false,
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              flex: 2,
                              child: Material(
                                type: MaterialType.transparency,
                                child: Ink(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.deepOrangeAccent, width: 4.0),
                                    color: Colors.deepOrange.withOpacity(0.7),
                                    shape: BoxShape.circle,
                                  ),
                                  child: InkWell(
                                    onTap: () async {
                                      if(emailFormKey.currentState.validate()){
                                        var email = _emailController.text;
                                        setState(() {
                                          showLoaderDialog(context);
                                        });
                                          var resp = await emailLogin(email, context);
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(100.0),
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
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: (){},
                              child: Image.network('https://st2.depositphotos.com/1144386/7770/v/450/depositphotos_77705004-stock-illustration-original-square-with-round-corners.jpg', width: 50,)),
                          SizedBox(width: 20,),
                          GestureDetector(
                              onTap: (){},
                              child: Image.network('https://cdn4.iconfinder.com/data/icons/free-colorful-icons/360/gmail.png', width: 50,))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Text('Forgot Password?'),
                          ),
                          RichText(
                            text: TextSpan(
                                text: 'New User? ',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ' Sign up',
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RegistrationScreen()));
                                        })
                                ]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
        content: Wrap(
          children: [
            SpinKitDoubleBounce(color: Colors.deepOrangeAccent,),
            Align(
                alignment: Alignment.center,
                child: Text("Loading...", textAlign: TextAlign.center, )),
          ],
        )
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }


}
