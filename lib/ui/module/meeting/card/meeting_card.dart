import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/ui/module/meeting/card/meeting_intro.dart';
import 'package:sso_futurescape/ui/module/meeting/create/meetvote_create_1.dart';
import 'package:sso_futurescape/ui/module/meeting/dashboard/meetvote_join.dart';
import 'package:sso_futurescape/ui/module/meeting/listing/meetvote_list.dart';
import 'package:sso_futurescape/ui/module/meeting/login/user_helper_2.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class MeetingCard extends StatefulWidget {
  @override
  _MeetingCardState createState() => new _MeetingCardState();
}

class _MeetingCardState extends State<MeetingCard> implements UserDataListener1 {

  bool _isLoadingData = true;
  bool _errorInDataLoad = false;
  var _societyId;
  String _dataLoadMsg;

  @override
  void initState() {
    super.initState();
    _initMeetingCard();
  }

  @override
  Widget build(BuildContext context) {
    return _getContentWidget();
  }

  Widget _getContentWidget() {
    return GestureDetector(
      onTap: (_isLoadingData || _errorInDataLoad) ? (){} :
          () {
        _openMeetingList();
      },
      child: Container(
        child: Card(
          elevation: 2.0,
          key: null,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "Onemeet",
                                style: TextStyle(fontSize: FSTextStyle.dashtitlesize, fontFamily: 'Gilroy-SemiBold', color: FsColor.primarymeeting),
                              ),
                            ),
                            SizedBox(height: 5),
                            _isLoadingData ? _getProgressWidget() :
                            _errorInDataLoad ? _getErrorWidget() :
                            Row(
                              children: [
                                Container(
                                  child: RaisedButton(
                                    elevation: 1.0,
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                      new BorderRadius.circular(4.0),
                                    ),
                                    onPressed: () {
                                      _openCreateMeeting();
                                    },
                                    color: FsColor.primarymeeting,
                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                    child: Text("Create",
                                      style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-Bold', color: FsColor.white),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  child: OutlineButton(
                                    shape: new RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(4.0),
                                    ),
                                    borderSide: BorderSide(color: FsColor.primarymeeting, width: 1.5),
                                    onPressed: () {
                                      _openJoinMeeting();
                                    },
                                    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                                    child: Text("Join",
                                      style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-Bold', color: FsColor.primarymeeting),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Image.asset("images/dash14.png",
                            height: 90, width: 90, fit: BoxFit.fitHeight),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                  child: Divider(
                      color: FsColor.darkgrey.withOpacity(0.2), height: 2.0),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                          child: Text(
                            "virtual meeting | collaborate and celebrate from anywhere with onemeet | everyone can safely create and join high-quality video meetings".toLowerCase(),
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: FSTextStyle.dashsubtitlesize, fontFamily: FSTextStyle.dashsubtitlefont, color: FsColor.dashsubtitlecolor),
                          ))
                    ],
                  ),
                ),
                SizedBox(height: 5.0),
              ],
            ),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        alignment: Alignment.center,
      ),
    );
  }

  Widget _getProgressWidget() {
    return SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        valueColor: AlwaysStoppedAnimation(FsColor.primarymeeting),
      ),
    );;
  }

  Widget _getErrorWidget() {
    return GestureDetector(
      onTap: () {},
      child: FlatButton(
        child: Text("Retry",
          style: TextStyle(
              fontSize: FSTextStyle.h5size,
              fontFamily: 'Gilroy-SemiBold',
              color: FsColor.primarymeeting),),
        onPressed: () {
          _initMeetingCard();
        },
      ),
    );
  }

  void _initMeetingCard() {
    AppUtils.checkInternetConnection().then((value) {
      if (value) {
        _isLoadingData = true;
        _dataLoadMsg = null;
        _errorInDataLoad = false;

        _loadUserData();
      } else {
        _isLoadingData = false;
        _dataLoadMsg = null;
        _errorInDataLoad = true;
      }
      setState(() {});
    });
  }

  void _loadUserData() {
    UserHelper1 userHelper = UserHelper1(this);
    userHelper.loadUserData();
  }

  void _openCreateMeeting() async {
    bool meetingIntroShown = await isMeetingIntroShown();
    if (!meetingIntroShown) {
      _openMeetingIntro(MeetingIntroduction.CREATE_MEETING);
    } else {
      Navigator.push(context,
        MaterialPageRoute(
            builder: (context) => MeetVoteCreate1(societyId: _societyId)),
      );
    }
  }

  void _openJoinMeeting() async {
    bool meetingIntroShown = await isMeetingIntroShown();
    if (!meetingIntroShown) {
      _openMeetingIntro(MeetingIntroduction.JOIN_MEETING);
    } else {
      Navigator.push(context,
        MaterialPageRoute(
            builder: (context) => MeetVoteJoin(societyId: _societyId)),
      );
    }
  }

  void _openMeetingList() async {
    bool meetingIntroShown = await isMeetingIntroShown();
    if (!meetingIntroShown) {
      _openMeetingIntro(MeetingIntroduction.MEETING_LIST);
    } else {
      Navigator.push(context,
        MaterialPageRoute(
            builder: (context) => MeetVoteList(societyId: _societyId)),
      );
    }
  }

  void _openMeetingIntro(int navigateTo) {
      Navigator.push(context,
        MaterialPageRoute(builder: (context) =>
            MeetingIntroduction(navigateTo, societyId: _societyId,),),
      );
  }

  Future<bool> isMeetingIntroShown() {
    return Future<bool>(() async {
      String result = await SsoStorage.isMeetingIntroShown();
      return ("true" == result);
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  userDataError1() {
    _isLoadingData = false;
    _errorInDataLoad = true;
    _dataLoadMsg = null;
    setState(() {});
  }

  @override
  userDataFailure1() {
    _isLoadingData = false;
    _errorInDataLoad = true;
    _dataLoadMsg = null;
    setState(() {});
  }

  @override
  userDataSuccess1(meetingSocietyId) {
    _societyId = meetingSocietyId;

    _isLoadingData = false;
    _errorInDataLoad = false;
    _dataLoadMsg = null;
    setState(() {});
  }
}
