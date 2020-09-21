import 'package:flutter/material.dart';
import 'package:sso_futurescape/ui/widgets/SocialIcons.dart';
import 'package:sso_futurescape/ui/widgets/horizontalline.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var passwordController = new TextEditingController();
    var mobileController = new TextEditingController();
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(15.0, 50.0, 0.0, 0.0),
                    child: new Image.network(
                      'https://www.futurescapetech.com/assets/img/FuturescapeTechnologyLogo.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(15.0, 30.0, 0.0, 0.0),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(35.0, 20.0, 20.0, 20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: mobileController,
                      decoration: InputDecoration(
                          labelText: 'Mobile',
                          labelStyle: TextStyle(
                              fontFamily: 'Roboto', color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue))),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                              fontFamily: 'Roboto', color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue))),
                      obscureText: true,
                    ),
                    Container(
                      alignment: Alignment(1.0, 0.0),
                      padding: EdgeInsets.only(top: 15.0, left: 20.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('/signup');
                        },
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                              color: Colors.grey[900],
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto',
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () => pressedCall(
                          mobileController.text, passwordController.text),
                      child: Container(
                        height: 54.0,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
                            borderRadius: BorderRadius.circular(6.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFF6078ea).withOpacity(.3),
                                  offset: Offset(0.0, 8.0),
                                  blurRadius: 8.0)
                            ]),
                        child: Material(
                          borderRadius: BorderRadius.circular(6.0),
                          shadowColor: Colors.grey[900],
                          color: Colors.transparent,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: () => pressedCall(
                                mobileController.text, passwordController.text),
//                          onForcePressEnd: pressedCall(mobileController.text,passwordController.text),
                            child: Center(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CommonWidgets.horizontalLine(),
                        Text("OR",
                            style: TextStyle(
                                fontSize: 16.0, fontFamily: "Roboto")),
                        CommonWidgets.horizontalLine(),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SocialIcon(
                          colors: [
                            Color(0xFF3B5998),
                            Color(0xFF6889CE),
                          ],
                          iconData: FlutterIcon.facebook,
                          onPressed: () {},
                        ),
                        SocialIcon(
                          colors: [
                            Color(0xFFff4f38),
                            Color(0xFFff355d),
                          ],
                          iconData: FlutterIcon.google,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                )),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Not Yet Registered ?',
                  style: TextStyle(fontFamily: 'Roboto'),
                ),
                SizedBox(width: 5.0),
                InkWell(
                  onTap: () {
                    //Navigator.of(context).pushNamed('../signup/signup');
//                     Navigator.push(
//                        context,
//                        MaterialPageRoute(builder: (context) => SignupPage()),
//                      );
                  },
                  child: Text(
                    'Register Now !',
                    style: TextStyle(
                        color: Colors.grey[900],
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            )
          ],
        ));
  }

  pressedCall(String mobile, String password) {

  }


}
