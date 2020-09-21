import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sso_futurescape/ui/module/meeting/create/meetvote_create_1.dart';
import 'package:sso_futurescape/ui/module/meeting/dashboard/meetvote_join.dart';
import 'package:sso_futurescape/ui/module/meeting/listing/meetvote_list.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class MeetingIntroduction extends StatefulWidget {
  static const int MEETING_LIST = 0;
  static const int CREATE_MEETING = 1;
  static const int JOIN_MEETING = 2;

  var societyId;
  int navigateTo;

  MeetingIntroduction(this.navigateTo, {this.societyId});

  @override
  _MeetingIntroductionState createState() => new _MeetingIntroductionState();
}

class _MeetingIntroductionState extends State<MeetingIntroduction> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 42),
      child: IntroductionScreen(
        pages: [ScreenOne],
        //skip: Text("Skip", style: TextStyle(fontSize: FSTextStyle.h6size, color: FsColor.darkgrey, fontFamily: 'Gilroy-Regular')),
        done: Text("Got it",
            style: TextStyle(
                fontSize: FSTextStyle.h6size,
                color: FsColor.darkgrey,
                fontFamily: 'Gilroy-Bold')),
        //next: Text("Next", style: TextStyle(fontSize: FSTextStyle.h6size, color: FsColor.darkgrey, fontFamily: 'Gilroy-Bold')),
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
        onDone: () {
          _navigateToNext();
        },
      ),
    );
  }

  var ScreenOne = PageViewModel(
    titleWidget: Text(
      'onemeet'.toLowerCase(),
      style: TextStyle(
          fontFamily: 'Gilroy-Bold',
          fontSize: FSTextStyle.h4size,
          height: 1,
          letterSpacing: 1.0,
          color: FsColor.primarymeeting),
    ),
    bodyWidget: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          child: Image.asset(
            "images/meetingintro1.png",
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
                ''.toLowerCase(),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 20,
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Icon(
                      Icons.chevron_right,
                      size: FSTextStyle.h6size,
                      color: FsColor.basicprimary,
                    )
                  ),
                  Expanded(
                    child: Text(
                      'join a session with ease, no sign up necessary!'
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 20,
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Icon(
                      Icons.chevron_right,
                      size: FSTextStyle.h6size,
                      color: FsColor.basicprimary,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'start or join a secure meeting with flawless video and audio - for FREE!'
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 20,
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Icon(
                      Icons.chevron_right,
                      size: FSTextStyle.h6size,
                      color: FsColor.basicprimary,
                    )
                  ),
                  Expanded(
                    child: Text(
                      'the same great experience you love on your computer is now available on your mobile device'
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 20,
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Icon(
                      Icons.chevron_right,
                      size: FSTextStyle.h6size,
                      color: FsColor.basicprimary,
                    )
              ),
                  Expanded(
                    child: Text(
                      'video conference face to face no matter where you are in the world'
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

  void _navigateToNext() {
    SsoStorage.setMeetingIntroShown();
    switch (widget.navigateTo) {
      case MeetingIntroduction.MEETING_LIST:
        _openMeetingList();
        break;

      case MeetingIntroduction.CREATE_MEETING:
        _openCreateMeeting();
        break;

      case MeetingIntroduction.JOIN_MEETING:
        _openJoinMeeting();
        break;
    }
  }

  void _openCreateMeeting() {
    _openNext(MeetVoteCreate1(societyId: widget.societyId));
  }

  void _openJoinMeeting() {
    _openNext(MeetVoteJoin(societyId: widget.societyId));
  }

  void _openMeetingList() {
    _openNext(MeetVoteList(societyId: widget.societyId));
  }

  void _openNext(Widget widget) {
    int pops = 0;
    int popsRequired = 1;
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute (
      builder: (context) => widget,
    ), (Route<dynamic> route) {
      pops++;
      return pops > popsRequired;
    });
  }
}
