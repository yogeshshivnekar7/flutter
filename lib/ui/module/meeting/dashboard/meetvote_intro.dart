import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:introduction_screen/introduction_screen.dart';

class MeetVoteIntroduction extends StatefulWidget { 
  @override
  _MeetVoteIntroductionState createState() => new _MeetVoteIntroductionState();
}

class _MeetVoteIntroductionState extends State<MeetVoteIntroduction> {

  @override
  Widget build(BuildContext context) {
  

return Container(
  // margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
  child: IntroductionScreen(
    pages: [ScreenOne,ScreenTwo],    
    // skip: Text("Skip", style: TextStyle(fontSize: FSTextStyle.h6size, color: FsColor.darkgrey, fontFamily: 'Gilroy-Regular')),
    done: Container(), 
    // next: Text("Next", style: TextStyle(fontSize: FSTextStyle.h6size, color: FsColor.darkgrey, fontFamily: 'Gilroy-Bold')),
    
    // globalBackgroundColor: FsColor.primarymeeting.withOpacity(0.1),
    globalBackgroundColor: FsColor.white,
    animationDuration: 100,
    showSkipButton: false,
    showNextButton: false,
    
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
    

    onDone: () {},
    
    ),
  );

  }


var ScreenOne = PageViewModel(
  titleWidget: Container(),
  // body: "Instead of having to buy an entire share, invest any amount you want.",
  bodyWidget:Container(
    child: Column(
      children: [
        Image.asset("images/meetvoteintro.png", height: 200.0, fit: BoxFit.fitHeight,),
        SizedBox(height: 20),
        Text('First Heading Intro Comes here'.toLowerCase(), textAlign: TextAlign.center, 
          style: TextStyle(fontFamily: 'Gilroy-Bold', fontSize: FSTextStyle.h4size, height: 1, letterSpacing: 1.0, color: FsColor.primarymeeting),
        ),
        SizedBox(height: 5),
        Text('Instead of having to buy an entire share, invest any amount you want.'.toLowerCase(), textAlign: TextAlign.center, 
          style: TextStyle(fontFamily: 'Gilroy-Regular', fontSize: FSTextStyle.h6size, letterSpacing: 1.0, color: FsColor.basicprimary),
        ),
      ],
    ),
  ),
  image: null,
);


var ScreenTwo = PageViewModel(
  titleWidget: Container(),
  // body: "Instead of having to buy an entire share, invest any amount you want.",
  bodyWidget:Container(
    child: Column(
      children: [
        Image.asset("images/meetvoteintro.png", height: 200.0, fit: BoxFit.fitHeight,),
        SizedBox(height: 20),
        Text('Second Heading Intro Comes here'.toLowerCase(), textAlign: TextAlign.center, 
          style: TextStyle(fontFamily: 'Gilroy-Bold', fontSize: FSTextStyle.h4size, height: 1, letterSpacing: 1.0, color: FsColor.primarymeeting),
        ),
        SizedBox(height: 5),
        Text('Instead of having to buy an entire share, invest any amount you want.'.toLowerCase(), textAlign: TextAlign.center, 
          style: TextStyle(fontFamily: 'Gilroy-Regular', fontSize: FSTextStyle.h6size, letterSpacing: 1.0, color: FsColor.basicprimary),
        ),
      ],
    ),
  ),
  image: null,
);
}
