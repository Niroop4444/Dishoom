import 'package:country_code_picker/country_code_picker.dart';
import 'package:dishoom/screens/dashboard_screen.dart';
import 'package:dishoom/screens/welcome/interest_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_builder/responsive_builder.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizinginformation){
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
                        offset: Offset(1.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero,
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:20.0,),
                        child: Text('REGISTER', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:58.0, vertical: 18),
                        child: Divider(),
                      ),
                      Text('Register with', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network('https://st2.depositphotos.com/1144386/7770/v/450/depositphotos_77705004-stock-illustration-original-square-with-round-corners.jpg', width: 50,),
                          SizedBox(width: 20,),
                          Image.network('https://cdn4.iconfinder.com/data/icons/free-colorful-icons/360/gmail.png', width: 50,)
                        ],
                      ),
                      SizedBox(height: 20,),
                      Text('Or', style: TextStyle(color: Colors.grey, fontSize: 20),),
                      Text('What is your', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 20),),
                      Text('Registered Mobile Number', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                        child: TextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters:[
                            LengthLimitingTextInputFormatter(10),
                          ],
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                            prefixIcon: CountryCodePicker(
                              initialSelection: 'IN',
                              favorite: ['+91', 'IN'],
                              onInit: (code) => print("${code.dialCode}"),
                              onChanged: print,
                            ),
                            fillColor: Color(0xFFF2F2F2),
                            filled: true,
                            hintText: "Mobile Number",
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                          cursorColor: Colors.deepOrangeAccent,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Align(
                        alignment: Alignment.topRight,
                        child: CircleAvatar(
                          backgroundColor: Colors.deepOrangeAccent,
                          radius: 20,
                          child: IconButton(
                            icon: Icon(Icons.chevron_right, color: Colors.white,),
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => InterestScreen()));
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text('May be Later?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.only(bottom:8.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.deepOrangeAccent)),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
                            },
                            color: Colors.deepOrangeAccent,
                            textColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Text("Just let me in".toUpperCase(),
                                  style: TextStyle(fontSize: 14)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )

              ],
            ),
          ),
        );
      },
    );
  }
}
