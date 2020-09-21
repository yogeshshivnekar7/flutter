import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/sso/signup/mobile.dart';
import 'package:sso_futurescape/ui/module/sso/signup/password.dart';


class PersonalDetailsPage extends StatefulWidget {
  @override
  _PersonalDetailsPageState createState() => new _PersonalDetailsPageState();

}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {

  int selectedRadio;

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                            child: Text('Fill your Personal Details',
                              style: TextStyle(fontFamily: 'Roboto-Medium',
                                  fontSize: 20.0,
                                  color: FsColor.darkgrey),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(
                              fontFamily: 'Roboto',
                              color: FsColor.darkgrey),
                          // hintStyle: ,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: FsColor.basicprimary))),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Surname',
                          labelStyle: TextStyle(
                              fontFamily: 'Roboto',
                              color: FsColor.darkgrey),
                          // hintStyle: ,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: FsColor.basicprimary))),
                    ),
                    SizedBox(height: 10.0),

                    ButtonBar(
                      alignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text('Gender', style: TextStyle(
                              fontFamily: 'Roboto-Medium',
                              fontSize: 16.0,
                              color: FsColor.darkgrey)),
                        ),

                        Row(
                          children: <Widget>[
                            Radio(
                              value: 1,
                              activeColor: FsColor.primary,
                              groupValue: selectedRadio,
                              onChanged: (val) {
                                setSelectedRadio(val);
                              },
                            ),
                            Text("Male"),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Radio(
                              value: 2,
                              activeColor: FsColor.primary,
                              groupValue: selectedRadio,
                              onChanged: (val) {
                                setSelectedRadio(val);
                              },
                            ),
                            Text("Female"),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 10.0),
                    TextField(

                      decoration: InputDecoration(
                          labelText: 'Date of Birth',
                          labelStyle: TextStyle(
                              fontFamily: 'Roboto',
                              color: FsColor.darkgrey),
                          // hintStyle: ,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: FsColor.basicprimary))),
                    ),

                    SizedBox(height: 50.0),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          child: FlatButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(4.0),
                                side: BorderSide(color: const Color(
                                    0xFFE53935))),
                            child: const Text(
                                'Back', style: TextStyle(fontSize: 16)),
                            color: const Color(0xFFFFFF),
                            textColor: const Color(0xFFE53935),
                            onPressed: () {
                              Navigator.push(
                                context, MaterialPageRoute(
                                  builder: (context) => PasswordPage("")),
                              );
                            },
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 8)),
                        GestureDetector(
                          child: RaisedButton(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(4.0),),
                            child: const Text(
                                'Submit', style: TextStyle(fontSize: 16)),
                            onPressed: () {
                              Navigator.push(
                                context, MaterialPageRoute(
                                  builder: (context) => MobilePage()),
                              );
                            },
                            color: const Color(0xFF212121),
                            textColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                )),

          ],
        ));
  }

  void radioChanged(double value) {}
}

class HomePage {
}
