/*
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sso_futurescape/config/colors/color.dart';

class IntroductionPage extends StatefulWidget { 
  @override
  _IntroductionPageState createState() => new _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IntroductionScreen(

        pages: [screenOne, ScreenTwo, screenThree],
        skip: Text("Skip", style: TextStyle(fontSize: FSTextStyle.h6size,
            color: FsColor.darkgrey,
            fontFamily: 'Gilroy-Regular')),
        done: Text("Let's Begin", style: TextStyle(fontSize: FSTextStyle.h6size,
            color: FsColor.darkgrey,
            fontFamily: 'Gilroy-Bold')),
        next: Text("Next", style: TextStyle(fontSize: FSTextStyle.h6size,
            color: FsColor.darkgrey,
            fontFamily: 'Gilroy-Bold')),

        globalBackgroundColor: FsColor.white,
        animationDuration: 500,
        showSkipButton: true,
        // curve: Curves.easeInCirc,
        curve: Curves.easeInOutSine,
        dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeColor: FsColor.darkgrey,
            color: FsColor.lightgrey,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)
            )
        ),


        onSkip: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/loading');
//    Navigator.push(context,MaterialPageRoute(
//        builder: (context) => MainDashboard()
//      ),
//    );
          // You can also override onSkip callback
        },
        onDone: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/loading');
//    Navigator.push(context,MaterialPageRoute(
//        builder: (context) => MainDashboard()
//      ),
//    );
          // When done button is press
        },


      ),);
  }


  var screenOne = PageViewModel(
    title: '',
    bodyWidget: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'CubeOne is now your trusted housing society manager'.toLowerCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Gilroy-Bold',
              fontSize: FSTextStyle.h4size,
              height: 1.5,
              letterSpacing: 1.0,
              color: FsColor.darkgrey),
        ),
        Text(
          'Now manage your life & housing society only with one app, now existing CHSONE users can link their account with CubeOne.'
              .toLowerCase(), textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Gilroy-Regular',
              fontSize: FSTextStyle.h6size,
              height: 1.5,
              letterSpacing: 1.0,
              color: FsColor.darkgrey),
        ),
      ],
    ),
    image: Center(
      child: Image.asset("images/screen01.jpg", height: 300.0,),
    ),
  );


  var ScreenTwo = PageViewModel(
    title: '',
    bodyWidget: Column(
      children: <Widget>[
        Text('Be in-charge of your business with CubeOne'.toLowerCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Gilroy-Bold',
              fontSize: FSTextStyle.h4size,
              height: 1.5,
              letterSpacing: 1.0,
              color: FsColor.darkgrey),
        ),
        Text(
          'Connecting with your customers now easier than ever before, more power to you to do more only with One App!'
              .toLowerCase(), textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Gilroy-Regular',
              fontSize: FSTextStyle.h6size,
              height: 1.5,
              letterSpacing: 1.0,
              color: FsColor.darkgrey),
        ),
      ],
    ),
    image: Center(
      child: Image.asset("images/screen02.jpg", height: 300.0,),
    ),
  );


  var screenThree = PageViewModel(
    title: '',
    bodyWidget: Column(
      children: <Widget>[
        Text('Your Safety & Security now easier to take care of!'.toLowerCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Gilroy-Bold',
              fontSize: FSTextStyle.h4size,
              height: 1.5,
              letterSpacing: 1.0,
              color: FsColor.darkgrey),
        ),
        Text(
          'No need to stress your phone with different apps for the security of your gated premise, CubeOne will take care of your safety needs.'
              .toLowerCase(), textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Gilroy-Regular',
              fontSize: FSTextStyle.h6size,
              height: 1.5,
              letterSpacing: 1.0,
              color: FsColor.darkgrey),
        ),
      ],
    ),
    image: Center(
      child: Image.asset("images/screen03.jpg", height: 300.0,),
    ),
  );

// var ScreenFour = PageViewModel(
//   title: '',
//   bodyWidget: Column(
//         children: <Widget>[
//           Text('Title Four Comes Here', textAlign: TextAlign.center,
//           style: TextStyle(
//           fontFamily: 'Gilroy-Bold', fontSize: FSTextStyle.h4size, height: 1.5, letterSpacing: 1.0, color: FsColor.darkgrey),
//           ),
//           Text('lorem ipsum dolor sit amet is a simply dummy text used for type setting', textAlign: TextAlign.center,
//             style: TextStyle(
//                   fontFamily: 'Gilroy-Regular', fontSize: FSTextStyle.h6size, height: 1.5, letterSpacing: 1.0, color: FsColor.black),
//           ),
//         ],
//   ),
//   image: Center(
//     child: Image.asset("images/pending-approval.png", height: 200.0,),
//   ),
// );


}
*/

import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/widgets/loding_page.dart';

class IntroductionPage extends StatefulWidget {
  @override
  _IntroductionPageState createState() => new _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IntroductionScreen(
        pages: [ScreenOne, ScreenTwo, ScreenThree, ScreenFour, ScreenFive],
        skip: Text("Skip",
            style: TextStyle(
                fontSize: FSTextStyle.h6size,
                color: FsColor.darkgrey,
                fontFamily: 'Gilroy-Regular')),
        done: Text("Let's Begin",
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
        animationDuration: 500,
        showSkipButton: true,
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

        onSkip: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => LoadingPage()),
                  (Route<dynamic> route) => false);

        },
        onDone: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => LoadingPage()),
                  (Route<dynamic> route) => false);
          // When done button is press
        },
      ),
    );
  }

  var ScreenOne = PageViewModel(
    title: '',
    bodyWidget: WillPopScope(
//  onWillPop: _onWillPop,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: Image.asset(
              "images/intro1.png",
              height: 250.0,
            ),
          ),
          Text(
            'CONNECT TO HOUSING SOCIETY OFFICE'.toLowerCase(),
            style: TextStyle(
              fontFamily: 'Gilroy-Bold',
              fontSize: FSTextStyle.h4size,
              height: 1,
              letterSpacing: 1.0,
              // color: FsColor.darkgrey
              color: Color(0xFF8bc751),
            ),
          ),
          SizedBox(height: 30),
          Text(
            '>   pay society bills'.toLowerCase(),
            style: TextStyle(
                fontFamily: 'Gilroy-Regular',
                fontSize: FSTextStyle.h6size,
                height: 1.5,
                letterSpacing: 1.0,
                color: FsColor.darkgrey),
          ),
          Text(
            '>   raise issues'.toLowerCase(),
            style: TextStyle(
                fontFamily: 'Gilroy-Regular',
                fontSize: FSTextStyle.h6size,
                height: 1.5,
                letterSpacing: 1.0,
                color: FsColor.darkgrey),
          ),
          Text(
            '>   take control of your visitors'.toLowerCase(),
            style: TextStyle(
                fontFamily: 'Gilroy-Regular',
                fontSize: FSTextStyle.h6size,
                height: 1.5,
                letterSpacing: 1.0,
                color: FsColor.darkgrey),
          ),
          Text(
            '>   & many more..'.toLowerCase(),
            style: TextStyle(
                fontFamily: 'Gilroy-Regular',
                fontSize: FSTextStyle.h6size,
                height: 1.5,
                letterSpacing: 1.0,
                color: FsColor.darkgrey),
          ),
        ],
      ),
      onWillPop: () {
        print("willpopwillpopwillpopwillpopwillpop");
      },
    ),
    image: null,
  );

  var ScreenTwo = PageViewModel(
    title: '',
    bodyWidget: WillPopScope(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: Image.asset(
              "images/intro2.png",
              height: 250.0,
            ),
          ),
          Text(
            'ORDER FOOD FROM HOME NEIGHBOURING RESTAURANTS'.toLowerCase(),
            style: TextStyle(
              fontFamily: 'Gilroy-Bold',
              fontSize: FSTextStyle.h4size,
              height: 1,
              letterSpacing: 1.0,
              // color: FsColor.darkgrey
              color: Color(0xFF3b56a6),
            ),
          ),
          SizedBox(height: 30),
          Text(
            '>   discover restaurants around you'.toLowerCase(),
            style: TextStyle(
                fontFamily: 'Gilroy-Regular',
                fontSize: FSTextStyle.h6size,
                height: 1.5,
                letterSpacing: 1.0,
                color: FsColor.darkgrey),
          ),
          Text(
            '>   get food delivered at your doorstep'.toLowerCase(),
            style: TextStyle(
                fontFamily: 'Gilroy-Regular',
                fontSize: FSTextStyle.h6size,
                height: 1.5,
                letterSpacing: 1.0,
                color: FsColor.darkgrey),
          ),
        ],
      ),
      onWillPop: () {
        print("will pop 22222222222222222222222222222222222222222222");
      },
    ),
    image: null,
  );

  var ScreenThree = PageViewModel(
    title: '',
    bodyWidget: WillPopScope(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: Image.asset(
              "images/intro3.png",
              height: 250.0,
            ),
          ),
          Text(
            'ORDER HOME STYLE TIFFINS'.toLowerCase(),
            style: TextStyle(
              fontFamily: 'Gilroy-Bold',
              fontSize: FSTextStyle.h4size,
              height: 1,
              letterSpacing: 1.0,
              // color: FsColor.darkgrey
              color: Color(0xFF8ca027),
            ),
          ),
          SizedBox(height: 30),
          Text(
            '>   find home-cooked meal around you'.toLowerCase(),
            style: TextStyle(
                fontFamily: 'Gilroy-Regular',
                fontSize: FSTextStyle.h6size,
                height: 1.5,
                letterSpacing: 1.0,
                color: FsColor.darkgrey),
          ),
          Text(
            '>   get subscription based food at your doorstep'.toLowerCase(),
            style: TextStyle(
                fontFamily: 'Gilroy-Regular',
                fontSize: FSTextStyle.h6size,
                height: 1.5,
                letterSpacing: 1.0,
                color: FsColor.darkgrey),
          ),
          Text(
            '>   several online payment modes'.toLowerCase(),
            style: TextStyle(
                fontFamily: 'Gilroy-Regular',
                fontSize: FSTextStyle.h6size,
                height: 1.5,
                letterSpacing: 1.0,
                color: FsColor.darkgrey),
          ),
        ],
      ),
      onWillPop: () {
        print("willpop333333333333333333333333333333333333333333333");
      },
    ),
    image: null,
  );

  var ScreenFour = PageViewModel(
    title: '',
    bodyWidget: WillPopScope(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: Image.asset(
              "images/intro4.png",
              height: 250.0,
            ),
          ),
          Text(
            'FIND BUSINESS, SCHOOLS, CLINICS IN YOUR NEIGHBOURHOOD'
                .toLowerCase(),
            style: TextStyle(
              fontFamily: 'Gilroy-Bold',
              fontSize: FSTextStyle.h4size,
              height: 1,
              letterSpacing: 1.0,
              // color: FsColor.darkgrey
              color: Color(0xFF6a89a8),
            ),
          ),
          SizedBox(height: 30),
          Text(
            '>   know your neighbourhood on your fingertips'.toLowerCase(),
            style: TextStyle(
                fontFamily: 'Gilroy-Regular',
                fontSize: FSTextStyle.h6size,
                height: 1.5,
                letterSpacing: 1.0,
                color: FsColor.darkgrey),
          ),
          Text(
            '>   find your business needs around you'.toLowerCase(),
            style: TextStyle(
                fontFamily: 'Gilroy-Regular',
                fontSize: FSTextStyle.h6size,
                height: 1.5,
                letterSpacing: 1.0,
                color: FsColor.darkgrey),
          ),
          Text(
            '>   hospitals, clinics & other information'.toLowerCase(),
            style: TextStyle(
                fontFamily: 'Gilroy-Regular',
                fontSize: FSTextStyle.h6size,
                height: 1.5,
                letterSpacing: 1.0,
                color: FsColor.darkgrey),
          ),
        ],
      ),
      onWillPop: () {
        print("wilpop4444444444444444444444444444444444444444444");
      },
    ),
    image: null,
  );

  var ScreenFive = PageViewModel(
    title: '',
    bodyWidget: WillPopScope(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: Image.asset(
              "images/intro5.png",
              height: 250.0,
            ),
          ),
          Text(
            'FIND DOMESTIC HELP, BLUE COLLARED WORKERS IN YOUR NEIGHBOURHOOD'
                .toLowerCase(),
            style: TextStyle(
              fontFamily: 'Gilroy-Bold',
              fontSize: FSTextStyle.h4size,
              height: 1,
              letterSpacing: 1.0,
              // color: FsColor.darkgrey
              color: Color(0xFF80739c),
            ),
          ),
          SizedBox(height: 30),
          Text(
            '>   find trusted housemaid, plumber, electrician'.toLowerCase(),
            style: TextStyle(
                fontFamily: 'Gilroy-Regular',
                fontSize: FSTextStyle.h6size,
                height: 1.5,
                letterSpacing: 1.0,
                color: FsColor.darkgrey),
          ),
          Text(
            '>   househelp for your day to day life'.toLowerCase(),
            style: TextStyle(
                fontFamily: 'Gilroy-Regular',
                fontSize: FSTextStyle.h6size,
                height: 1.5,
                letterSpacing: 1.0,
                color: FsColor.darkgrey),
          ),
        ],
      ),
      onWillPop: () {
        print(
            "willpop55555555555555555555555555555555555555555555555555555555");
      },
    ),
    image: null,
  );
}
