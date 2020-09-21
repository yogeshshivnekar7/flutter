import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/meeting/dashboard/meetvote_dashboard.dart';
import 'package:sso_futurescape/ui/module/meeting/details/meetvote_main.dart';
import 'package:sso_futurescape/ui/module/meeting/listing/meet_vote_list_presenter.dart';
import 'package:sso_futurescape/ui/module/meeting/listing/meet_vote_list_view.dart';
import 'package:sso_futurescape/ui/module/meeting/listing/meetvote_list.dart';
import 'package:sso_futurescape/ui/module/meeting/login/user_helper.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/utils/app_utils.dart';

class MyFlatsMeeting extends StatefulWidget {

  int societyId;

  MyFlatsMeeting({this.societyId});

  @override
  _MyFlatsMeetingState createState() => new _MyFlatsMeetingState();

}

class _MyFlatsMeetingState extends State<MyFlatsMeeting> implements MeetVoteListView, UserDataListener {
  static const String _CALL_TYPE_MEETING_LOGIN = "MEETING_LOGIN";
  static const String _CALL_TYPE_MEETING_LIST = "MEETINGS";

  var _meeting;
  MeetVoteListPresenter _listPresenter;
  bool _isLoadingData = true;
  bool _errorInDataLoad = false;
  bool _isAdmin = false;

  bool hasMeetingData() {
    return _meeting != null;
  }


  @override
  void initState() {
    super.initState();
    _listPresenter = MeetVoteListPresenter(this);
    _loadMeetingCardData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _openMeetingDashboard();
      },
      child: new Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Card(
                  elevation: 2.0,
                  key: null,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/dash-bg.jpg"),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                          width: 1.0, color: FsColor.darkgrey.withOpacity(0.5)),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Meeting".toLowerCase(),
                                style: TextStyle(
                                    fontSize: FSTextStyle.dashtitlesize,
                                    fontFamily: 'Gilroy-SemiBold',
                                    color: FsColor.primaryflat),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0, 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {},
                                child: RaisedButton(
                                  elevation: 1.0,
                                  shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(4.0),
                                  ),
                                  onPressed: hasMeetingData() ? () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        //builder: (context) => MeetVoteJoin(),
                                        builder: (context) => MeetVoteMain(int.parse(_meeting["id"]), societyId: widget.societyId,),
                                      ),
                                    ),
                                  } : null,
                                  color: hasMeetingData() ? FsColor.primaryflat : FsColor.darkgrey.withOpacity(0.5),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  child: Text(
                                    "Join",
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        fontFamily: 'Gilroy-Bold',
                                        color: FsColor.white),
                                  ),
                                ),
                              ),
                              _isLoadingData ?
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                  Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        "loading...",
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-SemiBold',
                                            color: FsColor.darkgrey),
                                      ),
                                    ],
                                  ),
                                    ]
                                  ) :
                              hasMeetingData() ?
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(_meeting["title"].toString().toLowerCase(),
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h4size,
                                            fontFamily: 'Gilroy-Bold',
                                            color: FsColor.darkgrey),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        "Date : ".toLowerCase(),
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-SemiBold',
                                            color: FsColor.lightgrey),
                                      ),
                                      Text(_meeting["start_date"].toString().toLowerCase(),
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-SemiBold',
                                            color: FsColor.darkgrey),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        "Time : ".toLowerCase(),
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-SemiBold',
                                            color: FsColor.lightgrey),
                                      ),
                                      Text(_meeting["start_time"].toString().toLowerCase(),
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-SemiBold',
                                            color: FsColor.darkgrey),
                                      ),
                                    ],
                                  ),
                                ],
                              ) :
                                  _errorInDataLoad ?
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () {},
                                            child: FlatButton(
                                              child: Text("Retry",
                                                style: TextStyle(
                                                    fontSize: FSTextStyle.h6size,
                                                    fontFamily: 'Gilroy-SemiBold',
                                                    color: FsColor.primaryflat),),
                                              onPressed: () {
                                                _loadMeetingCardData();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ) :
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        "no meeting schedule",
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-SemiBold',
                                            color: FsColor.darkgrey),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0, 0.0),
                          decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                    width: 1.0, color: FsColor.darkgrey.withOpacity(0.2)),
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              hasMeetingData() ?
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      "Status : ".toLowerCase(),
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h6size,
                                          fontFamily: 'Gilroy-SemiBold',
                                          color: FsColor.lightgrey),
                                    ),
                                    Text(_meeting["state"].toString().toLowerCase() ,
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h6size,
                                          fontFamily: 'Gilroy-SemiBold',
                                          color: FsColor.darkgrey),
                                    ),
                                  ],
                                ),
                              ) :
                              Container(),
                              Container(
                                child: GestureDetector(
                                  onTap: () {},
                                  child: FlatButton(
                                    onPressed: () {
                                      _openMeetingList();
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "View All",
                                          style: TextStyle(
                                              fontSize: FSTextStyle.h6size,
                                              fontFamily: 'Gilroy-SemiBold',
                                              color: FsColor.darkgrey),
                                        ),
                                        SizedBox(width: 10.0),
                                        Icon(FlutterIcon.right_big,
                                            color: FsColor.darkgrey,
                                            size: FSTextStyle.h6size),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                alignment: Alignment.center,
              ),
            ],
          )),
    );
  }

  void _loadMeetingCardData() {
    AppUtils.checkInternetConnection().then((value) {
      if (value) {
        _isLoadingData = true;
        _errorInDataLoad = false;
        setState(() {});
        _loadUserData();
      } else {
        _isLoadingData = false;
        _errorInDataLoad = true;
        setState(() {});
      }
    });
  }

  void _loadUserData() {
    UserHelper userHelper = UserHelper(this);
    userHelper.loadUserData(_CALL_TYPE_MEETING_LOGIN, societyId: widget.societyId);
  }

  void _loadMeetingList() {
    _listPresenter.loadMeetingList(1, 1, _CALL_TYPE_MEETING_LIST);
  }



  void _openMeetingDashboard() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MeetVoteDashboard(societyId: widget.societyId)));
  }

  void _openMeetingList() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MeetVoteList(societyId: widget.societyId)),
    );
  }


  void parseLatestMeetingObj(responseObj) {
    _isLoadingData = false;

    var dataObj = responseObj != null ? responseObj["data"] : null;
    List resultsArray = dataObj != null ? dataObj["results"] : null;

    if (responseObj == null || dataObj == null || resultsArray == null) {
      _errorInDataLoad = true;
      return;
    }

    if (resultsArray.isEmpty) {
      _errorInDataLoad = false;
      return;
    }

    var resultObj = resultsArray[0];
    if (resultObj == null) {
      _errorInDataLoad = true;
      return;
    }

      String startDate = resultObj["date"];
      String fStartDate = AppUtils.getConvertDate(startDate,
          date_from_format: null, date_to_formate: AppUtils.DATE_FORM_DD_MMM_YYYY);

      String endDate = resultObj["date"];
      String fEndDate = AppUtils.getConvertDate(endDate,
          date_from_format: null, date_to_formate: AppUtils.DATE_FORM_DD_MMM_YYYY);

      String startTime = resultObj["start_time_local"];
      String fStartTime = AppUtils.getConvertDate(startTime,
          date_from_format: null, date_to_formate: AppUtils.TIME_FORM_HH_MM_A);

      String endTime = resultObj["end_time_local"];
      String fEndTime = AppUtils.getConvertDate(endTime,
          date_from_format: null, date_to_formate: AppUtils.TIME_FORM_HH_MM_A);

      String meetingState = resultObj["meeting_state"]?.toString()?.trim();
      if (("ongoing" == meetingState) || ("upcoming" == meetingState)) {
        _meeting = {
          "id": resultObj["meeting_id"],
          "title": resultObj["title"],
          "description": (resultObj["description"]?.toString()?.trim() ?? ""),
          "start_date": fStartDate,
          "end_date": fEndDate,
          "start_time": fStartTime,
          "end_time": fEndTime,
          "state": resultObj["meeting_state"]
        };
      }

      _errorInDataLoad = false;
  }


  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }



  @override
  error(int page, error, {callingType}) {
    if (_CALL_TYPE_MEETING_LIST == callingType) {
      _isLoadingData = false;
      _errorInDataLoad = true;
      setState(() {});
    }
  }

  @override
  failure(int page, failed, {callingType}) {
    if (_CALL_TYPE_MEETING_LIST == callingType) {
      _isLoadingData = false;
      _errorInDataLoad = true;
      setState(() {});
    }
  }

  @override
  success(int page, success, {callingType}) {
    if (_CALL_TYPE_MEETING_LIST == callingType) {
      parseLatestMeetingObj(success);
      setState(() {});
    }
  }



  @override
  userDataError() {
    _isLoadingData = false;
    _errorInDataLoad = true;
    setState(() {});
  }

  @override
  userDataFailure() {
    _isLoadingData = false;
    _errorInDataLoad = true;
    setState(() {});
  }

  @override
  userDataSuccess(bool isAdmin) {
    _isAdmin = isAdmin;
    _loadMeetingList();
  }
}
