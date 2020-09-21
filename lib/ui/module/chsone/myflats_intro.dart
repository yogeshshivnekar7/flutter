import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sso_futurescape/config/colors/color.dart';

class MyflatsIntroduction extends StatefulWidget {
  @override
  _MyflatsIntroductionState createState() => new _MyflatsIntroductionState();
}

class _MyflatsIntroductionState extends State<MyflatsIntroduction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: IntroductionScreen(
            pages: [ScreenOne, ScreenTwo],
            skip: Text("Skip",
                style: TextStyle(
                    fontSize: FSTextStyle.h6size,
                    color: FsColor.darkgrey,
                    fontFamily: 'Gilroy-Regular')),
            done: Text("Got it",
                style: TextStyle(
                    fontSize: FSTextStyle.h6size,
                    color: FsColor.darkgrey,
                    fontFamily: 'Gilroy-Bold')),
            next: Text("Next",
                style: TextStyle(
                    fontSize: FSTextStyle.h6size,
                    color: FsColor.darkgrey,
                    fontFamily: 'Gilroy-Bold')),

            globalBackgroundColor: FsColor.white,
            animationDuration: 100,
            showSkipButton: false,
            // curve: Curves.easeInCirc,
            curve: Curves.easeInOutSine,
            dotsDecorator: DotsDecorator(
                size: const Size.square(10.0),
                activeSize: const Size(20.0, 10.0),
                activeColor: FsColor.darkgrey,
                color: FsColor.lightgrey,
                spacing: const EdgeInsets.symmetric(horizontal: 3.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0))),

            // onSkip: () {
            // Navigator.push(context,MaterialPageRoute(
            //     builder: (context) => MainDashboard()
            //   ),
            // );
            //   // You can also override onSkip callback
            // },
            onDone: () {
              Navigator.pop(context);
              /*Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ComplexList(),
            ),
          );*/
              // When done button is press
            },
          ),
        ),
      ),
    );
  }

  var ScreenOne = PageViewModel(
    titleWidget: Text(
      'MY FLAT - SECURITY & cubeoneapp.com'.toLowerCase(),
      textAlign: TextAlign.center,
      style: TextStyle(
          fontFamily: 'Gilroy-Bold',
          fontSize: FSTextStyle.h4size,
          height: 1,
          letterSpacing: 1.0,
          color: FsColor.primaryflat),
    ),
    bodyWidget: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          child: Image.asset(
            "images/myflatintro1.png",
            height: 250.0,
          ),
        ),
        SizedBox(height: 20),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'HOW TO?'.toLowerCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Gilroy-Bold',
                    fontSize: FSTextStyle.h4size,
                    height: 1,
                    letterSpacing: 1.0,
                    color: FsColor.basicprimary),
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 20,
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Text(
                      '1)'.toLowerCase(),
                      style: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          fontSize: FSTextStyle.h6size,
                          height: 1.5,
                          letterSpacing: 1.0,
                          color: FsColor.darkgrey),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Link your home to your housing society in given list'
                          .toLowerCase(),
                      style: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          fontSize: FSTextStyle.h6size,
                          height: 1.2,
                          letterSpacing: 1.0,
                          color: FsColor.darkgrey),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 7),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 20,
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Text(
                      '2)'.toLowerCase(),
                      style: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          fontSize: FSTextStyle.h6size,
                          height: 1.5,
                          letterSpacing: 1.0,
                          color: FsColor.darkgrey),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Request from the App to connect home with society’s office.'
                          .toLowerCase(),
                      style: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          fontSize: FSTextStyle.h6size,
                          height: 1.2,
                          letterSpacing: 1.0,
                          color: FsColor.darkgrey),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 7),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 20,
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Text(
                      '3) '.toLowerCase(),
                      style: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          fontSize: FSTextStyle.h6size,
                          height: 1.5,
                          letterSpacing: 1.0,
                          color: FsColor.darkgrey),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'If your society is not available on the list, fill in a simple form & we’ll get them listed'
                          .toLowerCase(),
                      style: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          fontSize: FSTextStyle.h6size,
                          height: 1.2,
                          letterSpacing: 1.0,
                          color: FsColor.darkgrey),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
    image: null,
  );

  var ScreenTwo = PageViewModel(
    titleWidget: Text(
      'MY FLAT - SECURITY & cubeoneapp.com'.toLowerCase(),
      textAlign: TextAlign.center,
      style: TextStyle(
          fontFamily: 'Gilroy-Bold',
          fontSize: FSTextStyle.h4size,
          height: 1,
          letterSpacing: 1.0,
          color: FsColor.primaryflat),
    ),
    bodyWidget: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          child: Image.asset(
            "images/myflatintro2.png",
            height: 250.0,
          ),
        ),
        SizedBox(height: 20),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'WHAT WILL YOU GET?'.toLowerCase(),
                style: TextStyle(
                    fontFamily: 'Gilroy-Bold',
                    fontSize: FSTextStyle.h4size,
                    height: 1,
                    letterSpacing: 1.0,
                    color: FsColor.basicprimary),
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 20,
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Text(
                      '1)'.toLowerCase(),
                      style: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          fontSize: FSTextStyle.h6size,
                          height: 1.5,
                          letterSpacing: 1.0,
                          color: FsColor.darkgrey),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Receive Notifications & Reminders'.toLowerCase(),
                      style: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          fontSize: FSTextStyle.h6size,
                          height: 1.2,
                          letterSpacing: 1.0,
                          color: FsColor.darkgrey),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 7),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 20,
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Text(
                      '2)'.toLowerCase(),
                      style: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          fontSize: FSTextStyle.h6size,
                          height: 1.5,
                          letterSpacing: 1.0,
                          color: FsColor.darkgrey),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Control your Visitors & Safety - Security'.toLowerCase(),
                      style: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          fontSize: FSTextStyle.h6size,
                          height: 1.2,
                          letterSpacing: 1.0,
                          color: FsColor.darkgrey),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 7),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 20,
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Text(
                      '3) '.toLowerCase(),
                      style: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          fontSize: FSTextStyle.h6size,
                          height: 1.5,
                          letterSpacing: 1.0,
                          color: FsColor.darkgrey),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Raise Society Issues'.toLowerCase(),
                      style: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          fontSize: FSTextStyle.h6size,
                          height: 1.2,
                          letterSpacing: 1.0,
                          color: FsColor.darkgrey),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 7),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 20,
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Text(
                      '4) '.toLowerCase(),
                      style: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          fontSize: FSTextStyle.h6size,
                          height: 1.5,
                          letterSpacing: 1.0,
                          color: FsColor.darkgrey),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Take control of your safety & security'.toLowerCase(),
                      style: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          fontSize: FSTextStyle.h6size,
                          height: 1.2,
                          letterSpacing: 1.0,
                          color: FsColor.darkgrey),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 7),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 20,
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Text(
                      '5) '.toLowerCase(),
                      style: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          fontSize: FSTextStyle.h6size,
                          height: 1.5,
                          letterSpacing: 1.0,
                          color: FsColor.darkgrey),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Allow or Dis-allow permissions to visit'.toLowerCase(),
                      style: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          fontSize: FSTextStyle.h6size,
                          height: 1.2,
                          letterSpacing: 1.0,
                          color: FsColor.darkgrey),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 7),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 20,
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Text(
                      '6) '.toLowerCase(),
                      style: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          fontSize: FSTextStyle.h6size,
                          height: 1.5,
                          letterSpacing: 1.0,
                          color: FsColor.darkgrey),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Use “TRUE CITIZEN” Pass for express entry into building powered by cubeoneapp.com'
                          .toLowerCase(),
                      style: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          fontSize: FSTextStyle.h6size,
                          height: 1.2,
                          letterSpacing: 1.0,
                          color: FsColor.darkgrey),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
    image: null,
  );
}
