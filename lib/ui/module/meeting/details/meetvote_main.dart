import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/ui/module/meeting/conference/conference_handler.dart';
import 'package:sso_futurescape/ui/module/meeting/details/meet_vote_details_view.dart';
import 'package:sso_futurescape/ui/module/meeting/login/meet_vote_login_view.dart';
import 'package:sso_futurescape/ui/module/meeting/login/meet_vote_profile_view.dart';
import 'package:sso_futurescape/ui/module/meeting/login/member_type_handler.dart';
import 'package:sso_futurescape/ui/module/meeting/login/member_type_view.dart';
import 'package:sso_futurescape/ui/module/meeting/login/profile_handler.dart';
import 'package:sso_futurescape/ui/module/meeting/pojo/meet_vote_pojos.dart';
import 'package:sso_futurescape/ui/module/meeting/utils/meet_vote_parser.dart';
import 'package:sso_futurescape/ui/module/meeting/utils/meet_vote_utils.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';
import 'package:sso_futurescape/utils/widget_utils.dart';
import 'meet_vote_details_presenter.dart';
import 'package:sso_futurescape/ui/module/meeting/login/login_handler.dart';

class MeetVoteMain extends StatefulWidget {

  int _meetingId;
  var societyId;

  MeetVoteMain(this._meetingId, {this.societyId});

  @override
  _MeetVoteMainState createState() => new _MeetVoteMainState();
}

class _MeetVoteMainState extends State<MeetVoteMain> implements
    MeetVoteDetailsView, MeetingLoginView, MeetingProfileView /*MemberTypeView*/ {

  MeetVoteDetailsPresenter _meetVoteDetailsPresenter;
  bool _isLoadingData = true;
  bool _errorInDataLoad = false;
  String _dataLoadMsg;
  bool _enableMockLoad = false;
  bool _isAdmin = false;
  var _meetingDetails = {};

  @override
  void initState() {
    _meetVoteDetailsPresenter = MeetVoteDetailsPresenter(this);
    _loadMeetingData();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoinBroadcast,
        onConferenceJoined: _onConferenceJoinedBroadcast,
        onConferenceTerminated: _onConferenceTerminatedBroadcast,
        onError: _onError));
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // appBar: new AppBar(
      //   elevation: 0.0,
      //   backgroundColor: Colors.transparent,
      //   title: new Text(
      //     'Join Meeting'.toLowerCase(),
      //     style: FSTextStyle.appbartext,
      //   ),
      //   leading: FsBackButton(),
      // ),
      body: _isLoadingData ? getLoaderWidget() :
      _errorInDataLoad ? getErrorWidget() : getContentWidget(),
    );
  }

  Widget getContentWidget() {
    return  Container(
      width: double.infinity,
      child: Column(
        children: [
          getAppLogoWidget(),
          getMeetingDetailsContentWidget(),
          getJoinButtonWidget(),
        ],
      ),
    );
  }

  Widget getAppLogoWidget() {
    return Container(
        height: 84,
        margin: EdgeInsets.fromLTRB(10, 42, 10, 15),
        child: Image.network(
          'https://www.cubeonebiz.com/img/logo/oneapp-logo-v.png',
          fit: BoxFit.contain,
        )
    );
  }

  Widget getMeetingDetailsContentWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4.0),),
        border: Border.all(width: 1.0, color: FsColor.primarymeeting.withOpacity(0.5),),
        color: FsColor.primarymeeting.withOpacity(0.05),
      ),
      margin: EdgeInsets.fromLTRB(10, 15, 10, 10),
      child: Column(
        children: [
          getMeetingIdWidget(),
          getMeetingDetailsWidget(),
          getMeetingTimeWidget(),
        ],
      ),
    );
  }

  Widget getMeetingIdWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Text(
            "Meeting ID : ".toUpperCase(),textAlign: TextAlign.right,
            style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-Regular', color: FsColor.darkgrey.withOpacity(0.8)),
          ),
          Text('${_meetingDetails["id"]}', textAlign: TextAlign.left,
            style: TextStyle(fontSize: FSTextStyle.h6size, color: FsColor.primarymeeting, fontFamily: 'Gilroy-SemiBold'),
          ),
        ],
      ),
    );
  }

  Widget getMeetingDetailsWidget() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [

          Text(_meetingDetails["title"], textAlign: TextAlign.left,
            style: TextStyle(fontSize: FSTextStyle.h5size, color: FsColor.basicprimary, fontFamily: 'Gilroy-SemiBold'),
          ),
          SizedBox(height: 10),
          // Divider(color: FsColor.darkgrey, height: 1),
          // SizedBox(height: 10),
          Text(_meetingDetails["description"], textAlign: TextAlign.left,
            style: TextStyle(fontSize: FSTextStyle.h6size, color: FsColor.basicprimary.withOpacity(0.75), fontFamily: 'Gilroy-SemiBold'),
          ),
        ],
      ),
    );
  }

  Widget getMeetingTimeWidget() {
    return Container(
      padding: EdgeInsets.all(10),
      color: FsColor.white,
      child: Column(
        children: [
          getMeetingStartTimeWidget(),
          SizedBox(height: 10),
          getMeetingEndTimeWidget(),
        ],
      ),
    );
  }

  Widget getMeetingStartTimeWidget() {
    return Row(
      children: [
        Container(
          width: 60,
          child: Text(
            "Starts : ".toUpperCase(),textAlign: TextAlign.right,
            style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-Regular', color: FsColor.darkgrey.withOpacity(0.8)),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _meetingDetails["start_date"].toLowerCase(),
                style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold', color: FsColor.darkgrey),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: Text(
                  ",".toLowerCase(),
                  style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-Regular', color: FsColor.darkgrey),
                ),
              ),
              Text(
                _meetingDetails["start_time"].toLowerCase(),
                style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold', color: FsColor.darkgrey),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getMeetingEndTimeWidget() {
    return Row(
      children: [
        Container(
          width: 60,
          child: Text(
            "Ends : ".toUpperCase(), textAlign: TextAlign.right,
            style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-Regular', color: FsColor.darkgrey.withOpacity(0.8)),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _meetingDetails["end_date"].toLowerCase(),
                style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold', color: FsColor.darkgrey),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: Text(
                  ",".toLowerCase(),
                  style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-Regular', color: FsColor.darkgrey),
                ),
              ),
              Text(
                _meetingDetails["end_time"].toLowerCase(),
                style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold', color: FsColor.darkgrey),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getJoinButtonWidget() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8.0),
      child: RaisedButton(
        color: FsColor.primarymeeting,
        onPressed: () {
          _joinMeeting();
        },
        child: Text('Join Meeting',
          style: TextStyle(fontSize: FSTextStyle.h6size, color: FsColor.white, fontFamily: 'Gilroy-SemiBold'),
        ),
      ),
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
          _loadMeetingData();
        },
      ),
    );
  }

  void _loadMeetingData() {
    if (_enableMockLoad) {
      _loadMeetingDataMock();
    } else {
      _loadMeetingDataReal();
    }
  }

  void _loadMeetingDataReal() {
    AppUtils.checkInternetConnection().then((value) {
      if (value) {
        _isLoadingData = true;
        _errorInDataLoad = false;
        _dataLoadMsg = null;

        _loginUser();
      } else {
        _isLoadingData = false;
        _errorInDataLoad = true;
        _dataLoadMsg = FsString.ERROR_NO_INTERNET;
      }
      setState(() {});
    });
  }

  void _loginUser() {
    MeetingLoginHandler.getInstance()
        .loginIntoMeetingModule(MeetingLoginView.CALL_TYPE_MEETING_LOGIN,
        societyId: widget.societyId, view: this);
  }

  void _loadUserProfile() {
    MeetingProfileHandler.getInstance()
        .loadUserProfile(MeetingProfileView.CALL_TYPE_USER_PROFILE,
        societyId: widget.societyId, view: this);
  }

  /*void _loadMemberType() {
    MemberTypeHandler.getInstance()
        .loadMemberTypeForMeeting(widget._meetingId, _CALL_TYPE_MEMBER_TYPE, view: this);
  }*/

  void _loadMeetingDetails() {
    _meetVoteDetailsPresenter.loadMeetingDetails(widget._meetingId, MeetVoteDetailsView.CALL_TYPE_MEETING_DETAILS);
  }



  void _loadMeetingDataMock() {
    _isLoadingData = true;
    _errorInDataLoad = false;

    Future.delayed(Duration(milliseconds: 3000), () {
      _isLoadingData = false;
      _errorInDataLoad = false;
      _meetingDetails = _getDummyMeetingDetails();
      print("Meeting Details = $_meetingDetails");
      setState(() {});
    });
  }




  void _closeMeetingDetails() {
    Navigator.of(context).pop();
  }

  void _joinMeeting() {
    SsoStorage.getUserProfile().then((value) {
      String userName, userEmail;
      if (value != null) {
        String firstName = value["first_name"];
        String lastName = value["last_name"];
        print("First Name = $firstName");
        print("Last Name = $lastName");

        userName = MeetVoteUtils.getFullName(firstName, lastName);
        userEmail = value["email"]?.trim() ?? "";
        String userMobile = value["mobile"]?.trim() ?? "";

        if ((userName == null) || (userName.trim().isEmpty)) {
          if ((userMobile != null) && (userMobile.trim().isNotEmpty)) {
            userName = userMobile;
          } else if ((userEmail != null) && (userEmail.trim().isNotEmpty)) {
            userName = userEmail;
          }
        }
      }

      print("User Name = $userName");
      print("User Email = $userEmail");

      ConferenceHandler.getInstance().joinMeeting(
          _meetingDetails["id"],
          _meetingDetails["title"],
          userName, userEmail,
      onJoined: _onConferenceJoined,
      onWillJoin: _onConferenceWillJoin,
      onTerminated: _onConferenceTerminated);
    });
  }

  void parseMeetingDetailsObj(meetingDetailsObj) {
    _isLoadingData = false;

    ApiData apiData = MeetVoteParser.parseMeetingDetails(meetingDetailsObj);
    _errorInDataLoad = apiData.errorInDataLoad;
    _dataLoadMsg = apiData.dataLoadMsg;
    _meetingDetails = apiData.data;
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }


  void _onConferenceWillJoin({message}) {
    debugPrint("_onConferenceWillJoin with message: $message");
  }

  void _onConferenceJoined({message}) {
    debugPrint("_onConferenceJoined with message: $message");
    _closeMeetingDetails();
  }

  void _onConferenceTerminated({message}) {
    debugPrint("_onConferenceTerminated with message: $message");
  }

  void _onConferenceWillJoinBroadcast({message}) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoinedBroadcast({message}) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminatedBroadcast({message}) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }

  _getDummyMeetingDetails() {
    return {
      "id": "${widget._meetingId}",
      "title": "First General Meeting",
      "description": "The first general body meeting with all the members of the society",
      "start_date": "11 Sep 2020",
      "end_date": "11 Sep 2020",
      "start_time": "4:00 PM",
      "end_time": "5:00 PM"
    };
  }

  @override
  error(error, {callingType}) {
    if (MeetVoteDetailsView.CALL_TYPE_MEETING_DETAILS == callingType) {
      _errorInDataLoad = true;
      _isLoadingData = false;
      _dataLoadMsg = FsString.ERROR_LOAD_MEETING_DETAILS;
      setState(() {});
    }
  }

  @override
  failure(failed, {callingType}) {
    if (MeetVoteDetailsView.CALL_TYPE_MEETING_DETAILS == callingType) {
      _errorInDataLoad = true;
      _isLoadingData = false;
      _dataLoadMsg = FsString.ERROR_LOAD_MEETING_DETAILS;
      setState(() {});
    }
  }

  @override
  success(success, {callingType}) {
    if (MeetVoteDetailsView.CALL_TYPE_MEETING_DETAILS == callingType) {
      parseMeetingDetailsObj(success);
      setState(() {});
    }
  }

  @override
  profileError(error, {callingType}) {
    _isLoadingData = false;
    _errorInDataLoad = true;
    _dataLoadMsg = FsString.ERROR_UNKNOWN_RETRY;

    setState(() { });
  }

  @override
  profileFailure(failed, {callingType}) {
    _isLoadingData = false;
    _errorInDataLoad = true;
    _dataLoadMsg = FsString.ERROR_UNKNOWN_RETRY;

    setState(() { });
  }

  @override
  profileSuccess(success, {societyId, callingType}) {
    ApiData apiData = MeetVoteParser.parseUserProfile(success);
    var profileObj = apiData.data;
    if (profileObj != null) {
      SsoStorage.setMeetingUserProfile(profileObj);
      _loadMeetingDetails();
    }
  }



  @override
  loginError(error, {callingType}) {
    _isLoadingData = false;
    _errorInDataLoad = true;
    _dataLoadMsg = FsString.ERROR_UNKNOWN_RETRY;

    setState(() { });
  }

  @override
  loginFailure(failed, {callingType}) {
    _isLoadingData = false;
    _errorInDataLoad = true;
    _dataLoadMsg = FsString.ERROR_UNKNOWN_RETRY;

    setState(() { });
  }

  @override
  loginSuccess(success, {societyId, callingType}) {
    ApiData apiData = MeetVoteParser.parseAccessToken(success);
    var accessTokenObj = apiData.data;
    if (accessTokenObj != null) {
      SsoStorage.setMeetingToken(accessTokenObj);
      _loadUserProfile();
    }
  }



/*  @override
  memberTypeError(error, {callingType}) {
    _isLoadingData = false;
    _errorInDataLoad = true;
    _dataLoadMsg = FsString.ERROR_UNKNOWN_RETRY;

    setState(() { });
  }

  @override
  memberTypeFailure(failed, {callingType}) {
    _isLoadingData = false;
    _errorInDataLoad = true;
    _dataLoadMsg = FsString.ERROR_UNKNOWN_RETRY;

    setState(() { });
  }

  @override
  memberTypeSuccess(success, var id, int type, {callingType}) {
    ApiData apiData = MeetVoteParser.parseMemberType(success);
    _isAdmin = apiData.data;

    _loadMeetingDetails();
  }*/
}
