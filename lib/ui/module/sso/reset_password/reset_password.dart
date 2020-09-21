import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';

class ResetPasswordPage extends StatefulWidget {
  String userName;

  ResetPasswordPage(String userName) {
    this.userName = userName;
  }

  @override
  _ResetPasswordPageState createState() =>
      new _ResetPasswordPageState(userName);
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  String userName;

  _ResetPasswordPageState(String userName) {
    this.userName = userName;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Icon(Icons.arrow_back, color: FsColor.darkgrey, size: 18.0),
        ),
        resizeToAvoidBottomPadding: false,
        body: Container(
          decoration: BoxDecoration(
            image: new DecorationImage(
              image: new ExactAssetImage('images/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      padding:
                      EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding:
                                  EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 20.0),
                                  child: Text(
                                    'enter your username to \nchange password',
                                    style: TextStyle(
                                        fontFamily: 'Gilroy-Bold',
                                        fontSize: 18.0,
                                        height: 1.5,
                                        letterSpacing: 1.0,
                                        color: FsColor.darkgrey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Username",
                                  labelStyle: TextStyle(
                                      fontFamily: 'Gilroy-Regular',
                                      color: FsColor.darkgrey),
                                  // hintStyle: ,
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: FsColor.basicprimary))),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
              Positioned(
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 8)),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20.0, left: 20.0),
                      child: GestureDetector(
                        child: RaisedButton(
                          padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(4.0),
                          ),
                          child: const Text('Reset Password',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Roboto-Medium',
                              )),
                          onPressed: () {
                            /*
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => */ /*ChangePasswordPage()*/ /*),
                            );*/
                          },
                          color: FsColor.basicprimary,
                          textColor: FsColor.white,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
