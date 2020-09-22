import 'package:dishoom/screens/profile/profile_screen.dart';
import 'package:dishoom/widgets/style_constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:dishoom/api/constant.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_builder/responsive_builder.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({this.initUsername, this.initEmail, this.initPhone});

  final String initUsername;
  final String initEmail;
  final String initPhone;

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final usernameFormKey = new GlobalKey<FormState>();
  final phoneFormKey = new GlobalKey<FormState>();
  final emailFormKey = new GlobalKey<FormState>();

  TextEditingController usernameCont;
  TextEditingController emailCont;
  TextEditingController phoneCont;

  String token = "";

  bool showSpinner = false;

  @override
  void initState() {
    getToken();

    usernameCont = TextEditingController(text: widget.initUsername);
    emailCont = TextEditingController(text: widget.initEmail);
    phoneCont = TextEditingController(text: widget.initPhone);

    super.initState();
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('Accesstoken') ?? 'Access token';
    });
  }

  updateProfile() async {
    String url = Constant.profileUrl;

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Client-Id': 'dishuumapp:dishumm:bd3c59bf-fa01-4fc7-aed1-4330d59d7bfd',
      'Authorization': 'Bearer $token'
    };

    var body = json.encode({
      'username': usernameCont.text,
      'profileImageUrl':
          "https://cdn.dnaindia.com/sites/default/files/styles/full/public/2020/08/03/917249-amitabh-bachchan.jpg",
      'phone': phoneCont.text,
      'email': emailCont.text,
    });

    final response = await http.put(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('Response in Edit Profile: ' + response.body);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProfileScreen()));
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProfileScreen()));
    print("Response Status in Edit Profile : " + response.body);
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
              SizedBox(height: 20,),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.20,
                  child: CircleAvatar(
                    radius: 85,
                    backgroundImage: NetworkImage(
                        'http://www.faceresearch.org/uploads/base/white_male'),
                  ),
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
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: usernameFormKey,
                      child: TextFormField(
                        controller: usernameCont,
                        validator: (String text) {
                          if (text.length == 0) {
                            return 'Username cannot be empty';
                          } else {
                            return null;
                          }
                        },
                        textAlign: TextAlign.center,
                        onChanged: (value) {},
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          height: 1.3,
                        ),
                        decoration: InputDecoration(
                          hintText: "Enter Username",
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
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: emailFormKey,
                      child: TextFormField(
                        controller: emailCont,
                        validator: (String text) {
                          if (text.length == 0) {
                            return 'Email address cannot be empty';
                          } else {
                            return null;
                          }
                        },
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {},
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          height: 1.3,
                        ),
                        decoration: InputDecoration(
                          hintText: "Enter Email",
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
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: phoneFormKey,
                      child: TextFormField(
                        controller: phoneCont,
                        validator: (String text) {
                          if (text.length == 0) {
                            return 'Phone number cannot be empty';
                          } else {
                            return null;
                          }
                        },
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {},
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          height: 1.3,
                        ),
                        decoration: InputDecoration(
                          hintText: "Enter Phone number",
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
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RoundedButton(
                      color: Colors.deepOrangeAccent,
                      onTap: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        try {
                          // FirebaseUser user = (await _auth.signInWithEmailAndPassword(
                          //         email: email, password: password))
                          //     .user;
                          // if (user != null) {
                          //   Navigator.pushNamed(context, ChatScreen.id);
                          // }
                          if (phoneFormKey.currentState.validate() &&
                              emailFormKey.currentState.validate() &&
                              usernameFormKey.currentState.validate()) {
                            await updateProfile();
                            Navigator.pop(context);
                          }
                        } catch (e) {
                          print(e);
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      },
                      text: 'Submit',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
//          body: SafeArea(
//            child: ModalProgressHUD(
//              inAsyncCall: showSpinner,
//              child: Padding(
//                padding: EdgeInsets.symmetric(horizontal: 24.0),
//                child: SingleChildScrollView(
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    crossAxisAlignment: CrossAxisAlignment.stretch,
//                    children: <Widget>[
//                      Align(
//                        alignment: Alignment.topRight,
//                        child: IconButton(
//                          icon: Icon(Icons.cancel),
//                          onPressed: () => Navigator.pop(context),
//                        ),
//                      ),
//                      Center(
//                        child: Text(
//                          "Edit your profile.",
//                          style: TextStyle(color: Colors.grey),
//                        ),
//                      ),
//                      SizedBox(height: 20),
//                      Center(
//                        child: Stack(
//                          children: [
//                            Container(
//                              height: 100,
//                              width: 100,
//                            ),
//                            Positioned(
//                              bottom: 0,
//                              child: CircleAvatar(
//                                radius: 35,
//                                backgroundImage: NetworkImage(
//                                    'http://www.faceresearch.org/uploads/base/white_male'),
//                              ),
//                            ),
//                            Positioned(
//                              right: 5,
//                              top: 5,
//                              child: IconButton(
//                                  icon: Icon(
//                                    Icons.photo_library,
//                                    color: Colors.deepOrangeAccent,
//                                  ),
//                                  onPressed: null),
//                            )
//                          ],
//                        ),
//                      ),
//                      SizedBox(height: 40),
//                      Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: Text(
//                          "Your Username",
//                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                        ),
//                      ),
//                      Form(
//                        key: usernameFormKey,
//                        child: TextFormField(
//                          controller: usernameCont,
//                          validator: (String text) {
//                            if (text.length == 0) {
//                              return 'Username cannot be empty';
//                            } else {
//                              return null;
//                            }
//                          },
//                          textAlign: TextAlign.center,
//                          onChanged: (value) {
//                          },
//                          style: TextStyle(
//                            color: Colors.black,
//                            fontSize: 13,
//                            height: 1.3,
//                          ),
//                          decoration: kInputDecoration.copyWith(
//                              hintText: 'Enter your new username'),
//                        ),
//                      ),
//                      SizedBox(
//                        height: 30,
//                      ),
//                      Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: Text(
//                          "Email Address",
//                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                        ),
//                      ),
//                      Form(
//                        key: emailFormKey,
//                        child: TextFormField(
//                          controller: emailCont,
//                          validator: (String text) {
//                            if (text.length == 0) {
//                              return 'Email address cannot be empty';
//                            } else {
//                              return null;
//                            }
//                          },
//                          textAlign: TextAlign.center,
//                          keyboardType: TextInputType.emailAddress,
//                          onChanged: (value) {
//                          },
//                          style: TextStyle(
//                            color: Colors.black,
//                            fontSize: 13,
//                            height: 1.3,
//                          ),
//                          decoration: kInputDecoration.copyWith(
//                              hintText: 'Enter your new email'),
//                        ),
//                      ),
//                      SizedBox(
//                        height: 30,
//                      ),
//                      Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: Text(
//                          "Mobile Number",
//                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                        ),
//                      ),
//                      Form(
//                        key: phoneFormKey,
//                        child: TextFormField(
//                          controller: phoneCont,
//                          validator: (String text) {
//                            if (text.length == 0) {
//                              return 'Phone number cannot be empty';
//                            } else {
//                              return null;
//                            }
//                          },
//                          textAlign: TextAlign.center,
//                          keyboardType: TextInputType.number,
//                          onChanged: (value) {
//                          },
//                          style: TextStyle(
//                            color: Colors.black,
//                            fontSize: 13,
//                            height: 1.3,
//                          ),
//                          decoration: kInputDecoration.copyWith(
//                              hintText: 'Enter your new mobile number'),
//                        ),
//                      ),
//                      SizedBox(
//                        height: 40,
//                      ),
//                      RoundedButton(
//                        color: Colors.deepOrangeAccent,
//                        onTap: () async {
//                          setState(() {
//                            showSpinner = true;
//                          });
//                          try {
//                            // FirebaseUser user = (await _auth.signInWithEmailAndPassword(
//                            //         email: email, password: password))
//                            //     .user;
//                            // if (user != null) {
//                            //   Navigator.pushNamed(context, ChatScreen.id);
//                            // }
//                            if (phoneFormKey.currentState.validate() &&
//                                emailFormKey.currentState.validate() &&
//                                usernameFormKey.currentState.validate()) {
//                              await updateProfile();
//                              Navigator.pop(context);
//                            }
//                          } catch (e) {
//                            print(e);
//                          }
//                          setState(() {
//                            showSpinner = false;
//                          });
//                        },
//                        text: 'Submit',
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//            ),
//          ),
      );
    });
  }
}

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {@required this.color, @required this.text, @required this.onTap});

  final Color color;
  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: this.color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: this.onTap,
          minWidth: 200.0,
          height: 40.0,
          child: Text(
            this.text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
