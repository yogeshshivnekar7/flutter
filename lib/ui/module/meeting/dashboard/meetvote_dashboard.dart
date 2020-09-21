import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/ui/module/meeting/create/meetvote_create.dart';
import 'package:sso_futurescape/ui/module/meeting/create/meetvote_create_1.dart';
import 'package:sso_futurescape/ui/module/meeting/listing/meetvote_list.dart';
import 'package:sso_futurescape/ui/module/meeting/login/user_helper.dart';
import 'package:sso_futurescape/ui/module/meeting/utils/meet_vote_utils.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/widget_utils.dart';
import 'join_widget.dart';
import 'meetvote_intro.dart';
import 'meetvote_join.dart';

class MeetVoteDashboard extends StatefulWidget {

  int societyId;

  MeetVoteDashboard({this.societyId});

  @override
  _MeetVoteDashboardState createState() => new _MeetVoteDashboardState();
}

class _MeetVoteDashboardState extends State<MeetVoteDashboard> implements UserDataListener {
  static const String _CALL_TYPE_MEETING_LOGIN = "MEETING_LOGIN";

  _openMeetingList(BuildContext context) {
    // Navigator.of(context).pushReplacementNamed("/home");

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => MeetVoteList(societyId: widget.societyId)));
    
    // Navigator.push(context, 
    //   MaterialPageRoute(builder: (context) => MeetVoteList()),
    // );
  }
  
  bool _isAdmin = false;
  bool _isLoadingData = true;
  bool _errorInDataLoad = false;
  String _dataLoadMsg;

  @override
  void initState() {
    super.initState();
    _initMeetingDashboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // backgroundColor: FsColor.primarymeeting.withOpacity(0.1),
      backgroundColor: FsColor.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        // title: Text(
        //   'Meeting Dashboard'.toLowerCase(),
        //   style: FSTextStyle.appbartext,
        // ),
        leading: FsBackButton(backEvent: MeetVoteUtils.onBackPressed(context),),
      ),
      body: _isLoadingData ? getLoaderWidget() :
      _errorInDataLoad ? getErrorWidget() : getContentWidget(),
      );
  }

  Widget getLoaderWidget() {
    return WidgetUtils.getLoaderWidget();
  }

  Widget getErrorWidget() {
    return Center(
      child: WidgetUtils.getErrorWidget(
        errorMsg: _dataLoadMsg,
        retrytext: "try again",
        shouldRetry: _errorInDataLoad,
        onRetryPressed: () {
          _initMeetingDashboard();
        },
      ),
    );
  }

  Widget getContentWidget() {
    return Dismissible(
        key: new ValueKey("dismiss_key"),
        direction: DismissDirection.up,
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Container(
                child: MeetVoteIntroduction(),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  color: FsColor.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10), topRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: FsColor.secondarymeeting.withOpacity(0.15),
                      offset: Offset(0.0, -5.0), //(x,y)
                      blurRadius: 10,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 15, 10, 15),
                          child: Text('some line about lorem ipsum dolor sit amet is simply dumy text used for typesetting', textAlign: TextAlign.center,
                            style: TextStyle(fontSize: FSTextStyle.h6size, color: FsColor.secondarymeeting, fontFamily: 'Gilroy-SemiBold'),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(15, 5, 15, 64),
                            child:
                            _isAdmin ?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: RaisedButton(
                                    elevation: 0,
                                    color: FsColor.primarymeeting.withOpacity(0.1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                      side: BorderSide(color: FsColor.primarymeeting.withOpacity(0.3)),
                                    ),
                                    onPressed: (){
                                      _openCreateMeeting();
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.add_box, size: 52, color: FsColor.primarymeeting,),
                                        Text('Create'.toUpperCase(),
                                          style: TextStyle(fontSize: FSTextStyle.h5size, letterSpacing: 1, color: FsColor.basicprimary, fontFamily: 'Gilroy-Bold'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child: RaisedButton(
                                    elevation: 0,
                                    color: FsColor.primarymeeting.withOpacity(0.1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                      side: BorderSide(color: FsColor.primarymeeting.withOpacity(0.3)),
                                    ),
                                    onPressed: (){
                                      Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => MeetVoteJoin(societyId: widget.societyId)),
                                      );
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.keyboard, size: 52, color: FsColor.primarymeeting,),
                                        Text('Join'.toUpperCase(),
                                          style: TextStyle(fontSize: FSTextStyle.h5size, letterSpacing: 1, color: FsColor.basicprimary, fontFamily: 'Gilroy-Bold'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ) : JoinWidget(societyId: widget.societyId),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                        bottom: 0, left: 0, right: 0,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Icon(Icons.expand_less, size: 30, color: FsColor.secondarymeeting,),
                              Text('Swipe up to see upcoming list'.toLowerCase(), textAlign: TextAlign.center,
                                style: TextStyle(fontSize: FSTextStyle.h6size, color: FsColor.secondarymeeting, fontFamily: 'Gilroy-SemiBold'),
                              ),
                            ],
                          ),
                        )

                    )

                  ],
                ),
              ),
            ),
          ],
        ),
        onDismissed: (direction) {
          if (direction == DismissDirection.up) {
            _openMeetingList(context);
          }
        }
    );
  }

  void _initMeetingDashboard() {
    AppUtils.checkInternetConnection().then((value) {
      if (value) {
        _loadUserData();
      } else {
        _isLoadingData = false;
        _dataLoadMsg = FsString.ERROR_NO_INTERNET;
        _errorInDataLoad = true;
      }
      setState(() {});
    });
  }

  void _loadUserData() {
    UserHelper userHelper = UserHelper(this);
    userHelper.loadUserData(_CALL_TYPE_MEETING_LOGIN, societyId: widget.societyId);
  }

  void _openCreateMeeting() {
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => MeetVoteCreate(societyId: widget.societyId)),
    );
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  userDataError() {
    _isLoadingData = false;
    _errorInDataLoad = true;
    _dataLoadMsg = FsString.ERROR_UNKNOWN_RETRY;
    setState(() {});
  }

  @override
  userDataFailure() {
    _isLoadingData = false;
    _errorInDataLoad = true;
    _dataLoadMsg = FsString.ERROR_UNKNOWN_RETRY;
    setState(() {});
  }

  @override
  userDataSuccess(bool isAdmin) {
    _isAdmin = true;

    _isLoadingData = false;
    _errorInDataLoad = false;
    _dataLoadMsg = null;
    setState(() {});
  }
}
