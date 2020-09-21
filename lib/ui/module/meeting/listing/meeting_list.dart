import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/ui/module/meeting/details/meetvote_main.dart';
import 'package:sso_futurescape/ui/module/meeting/listing/meet_vote_list_presenter.dart';
import 'package:sso_futurescape/ui/module/meeting/login/user_helper.dart';
import 'package:common_config/utils/firebase/firebase_dynamiclink.dart';
import 'package:sso_futurescape/ui/module/meeting/login/user_helper_2.dart';
import 'package:sso_futurescape/ui/module/meeting/pojo/meet_vote_pojos.dart';
import 'package:sso_futurescape/ui/module/meeting/utils/meet_vote_parser.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/facebook_utils.dart';
import 'package:sso_futurescape/utils/fsshare.dart';
import 'package:sso_futurescape/utils/widget_utils.dart';
import 'package:sso_futurescape/ui/module/meeting/utils/meet_vote_utils.dart';

import 'meet_vote_list_view.dart';

class MeetingList extends StatefulWidget {

  var societyId;

  MeetingList({this.societyId});

  @override
  _MeetingListState createState() => new _MeetingListState();
}

class _MeetingListState extends State<MeetingList> implements MeetVoteListView, UserDataListener1 /*UserDataListener*/ {

  static const _DEFAULT_PAGE_SIZE = 20;
  int _pageSize = _DEFAULT_PAGE_SIZE;
  bool _isAdmin = false;
  bool _isLoadingData = true;
  bool _errorInDataLoad = false;
  bool _showPageLoader = false;
  String _dataLoadMsg;
  List _meetingList = [];
  var metadata;
  ScrollController _scrollController;
  MeetVoteListPresenter _listPresenter;

  @override
  void initState() {
    super.initState();
    _listPresenter = MeetVoteListPresenter(this);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (!_showPageLoader) {
          if (metadata == null ||
              (metadata["last_page"] != metadata["current_page"])) {
            int page = ((metadata == null) ||
                    (metadata['current_page'].toString() == null))
                ? 1
                : (metadata['current_page'] + 1);
            _loadMeetingList(page);
          }
        }
      }
    });
    _loadInitialMeetingList();
  }

  @override
  Widget build(BuildContext context) {
    return getContentWidget();
  }

  Widget getContentWidget() {
    return _isLoadingData
        ? getLoaderWidget()
        : _dataLoadMsg == null ? getListWidget() : getErrorWidget();
  }

  Widget getListWidget() {
    return Column(children: <Widget>[
      Expanded(
        child: ListView(
          shrinkWrap: true,
          controller: _scrollController,
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: ListView.builder(
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _meetingList?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      Map meeting = _meetingList[index];
                      return getListItemWidget(meeting, index);
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      _showPageLoader ? getPageLoaderWidget() : WidgetUtils.getEmptyWidget()
    ]);
  }

  Widget getListItemWidget(var meeting, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Card(
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4.0),
          ),
          // side: BorderSide(color:
          //   meeting['state']=='ongoing'?
          //   FsColor.green.withOpacity(0.5)
          //   :
          //   meeting['state']=='upcoming'?
          //   FsColor.orange.withOpacity(0.5)
          //   :
          //   FsColor.red.withOpacity(0.5),
          // ),
        ),
        child: InkWell(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(0.0, 5.0, 0, 5.0),
                  decoration: BoxDecoration(
                    color: meeting['state'] == 'ongoing'
                        ? FsColor.green.withOpacity(0.1)
                        : meeting['state'] == 'upcoming'
                            ? FsColor.orange.withOpacity(0.1)
                            : FsColor.red.withOpacity(0.1),
                  ),
                  child: Text(
                    '${meeting["state"]}'.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: FSTextStyle.h7size,
                        letterSpacing: 3,
                        fontFamily: 'Gilroy-SemiBold',
                        color: meeting['state'] == 'ongoing'
                            ? FsColor.green
                            : meeting['state'] == 'upcoming'
                                ? FsColor.orange
                                : FsColor.red),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              '${meeting["title"]}'.toLowerCase(),
                              style: TextStyle(
                                  fontSize: FSTextStyle.h5size,
                                  fontFamily: 'Gilroy-SemiBold',
                                  color: FsColor.darkgrey),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Date : ".toLowerCase(),
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      fontFamily: 'Gilroy-SemiBold',
                                      color: FsColor.lightgrey),
                                ),
                                Text(
                                  "${meeting["start_date"]}".toLowerCase(),
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      fontFamily: 'Gilroy-SemiBold',
                                      color: FsColor.darkgrey),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Time : ".toLowerCase(),
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      fontFamily: 'Gilroy-SemiBold',
                                      color: FsColor.lightgrey),
                                ),
                                Text(
                                  "${meeting["start_time"]}".toLowerCase(),
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      fontFamily: 'Gilroy-SemiBold',
                                      color: FsColor.darkgrey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _getMeetingActionButtonsWidget(meeting),
              ],
            ),
          ),
          onTap: null,
        ),
      ),
    );
  }

  Widget _getMeetingActionButtonsWidget(meeting) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
                width: 1.0,
                color: FsColor.basicprimary.withOpacity(0.2)),
          )),
      padding: EdgeInsets.fromLTRB(10, 0.0, 10, 0.0),
      child: Column(
        children: [
          meeting['state'] == 'ongoing'
              ? _getOngoingMeetingActionButtonsWidget(meeting)
              : meeting['state'] == 'upcoming'
              ? _getUpcomingMeetingActionButtonsWidget(meeting)
              : _getExpiredMeetingActionButtonsWidget(meeting),
        ],
      ),
    );
  }

  Widget _getOngoingMeetingActionButtonsWidget(meeting) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FlatButton(
          onPressed: () {
            _shareMeetingLink(meeting);
          },
          //height: 32, minWidth: 64,
          child: Text(
            'Share',
            style: TextStyle(
                fontSize: FSTextStyle.h6size,
                fontFamily: 'Gilroy-SemiBold',
                color: FsColor.primarymeeting),
          ),
        ),
        SizedBox(width: 5,),
        FlatButton(
          onPressed: () {
            _openMeetingDetailsScreen(int.parse(meeting["id"]));
          },
          //height: 32, minWidth: 80,
          color: FsColor.primarymeeting,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            'Join Meeting',
            style: TextStyle(
                fontSize: FSTextStyle.h6size,
                fontFamily: 'Gilroy-SemiBold',
                color: FsColor.white),
          ),
        ),
      ],
    );
  }

  Widget _getUpcomingMeetingActionButtonsWidget(meeting) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /*FlatButton(
          onPressed: () {},
          //height: 32, minWidth: 64,
          child: Text(
            'Edit',
            style: TextStyle(
                fontSize: FSTextStyle.h6size,
                fontFamily: 'Gilroy-SemiBold',
                color: FsColor.primarymeeting),
          ),
        ),
        SizedBox(width: 5),
        FlatButton(
          onPressed: () {},
          //height: 32, minWidth: 64,
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(4),
              side: BorderSide(color: FsColor.red)),
          splashColor: FsColor.red.withOpacity(0.2),
          child: Text(
            'Cancel',
            style: TextStyle(
                fontSize: FSTextStyle.h6size,
                fontFamily: 'Gilroy-SemiBold',
                color: FsColor.red),
          ),
        ),
        SizedBox(width: 5),
        FlatButton(
          onPressed: () {},
          //height: 32, minWidth: 80,
          color: FsColor.primarymeeting,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            'Send',
            style: TextStyle(
                fontSize: FSTextStyle.h6size,
                fontFamily: 'Gilroy-SemiBold',
                color: FsColor.white),
          ),
        ),*/
        FlatButton(
          onPressed: () {
            _shareMeetingLink(meeting);
          },
          //height: 32, minWidth: 64,
          child: Text(
            'Share',
            style: TextStyle(
                fontSize: FSTextStyle.h6size,
                fontFamily: 'Gilroy-SemiBold',
                color: FsColor.primarymeeting),
          ),
        ),
      ],
    );
  }

  Widget _getExpiredMeetingActionButtonsWidget(meeting) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /*FlatButton(
          onPressed: () {},
          //height: 32, minWidth: 64,
          child: Text(
            'Download MOM',
            style: TextStyle(
                fontSize: FSTextStyle.h6size,
                fontFamily: 'Gilroy-SemiBold',
                color: FsColor.primarymeeting),
          ),
        ),
        SizedBox(width: 5),
        FlatButton(
          onPressed: () {},
          //height: 32, minWidth: 80,
          color: FsColor.primarymeeting,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            'Send MOM',
            style: TextStyle(
                fontSize: FSTextStyle.h6size,
                fontFamily: 'Gilroy-SemiBold',
                color: FsColor.white),
          ),
        ),*/
        Container(),
      ],
    );
  }

  Widget getLoaderWidget() {
    return WidgetUtils.getLoaderWidget();
  }

  Widget getPageLoaderWidget() {
    return WidgetUtils.getPageLoaderWidget(FsColor.primarymeeting);
  }

  Widget getErrorWidget() {
    return Center(
      child: WidgetUtils.getErrorWidget(
        errorMsg: _dataLoadMsg,
        retrytext: "try again",
        shouldRetry: _errorInDataLoad,
        onRetryPressed: () {
          _loadInitialMeetingList();
        },
      ),
    );
  }

  void _openMeetingDetailsScreen(int meetingId) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder:
        (context) => MeetVoteMain(meetingId, societyId: widget.societyId,)));
  }

  void _loadInitialMeetingList() {
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
    UserHelper1 userHelper = UserHelper1(this);
    userHelper.loadUserData(societyId: widget.societyId);
  }

  void _loadMeetingList(int page) {
    if (page == 1) {
      _isLoadingData = true;
      _dataLoadMsg = null;
      _errorInDataLoad = false;
    } else {
      _showPageLoader = true;
      _dataLoadMsg = null;
      _errorInDataLoad = false;
    }
    setState(() {});

    AppUtils.checkInternetConnection().then((value) {
      if (value) {
        _listPresenter.loadMeetingList(page, _pageSize, MeetVoteListView.CALL_TYPE_MEETING_LIST);
      } else {
        if (page == 1) {
          _isLoadingData = false;
          _dataLoadMsg = FsString.ERROR_NO_INTERNET;
          _errorInDataLoad = true;
        } else {
          _showPageLoader = false;
          _dataLoadMsg = null;
          _errorInDataLoad = false;
        }
        setState(() {});
      }
    });
  }

  void _shareMeetingLink(meeting) {
    String meetingLink = MeetVoteUtils.getMeetingLink(int.parse(meeting["id"]));
    if (meetingLink != null && meetingLink.trim().isNotEmpty) {
      FirebaseDynamicLink.getLink(
          meeting["title"], meeting["description"] ?? "", "", childLink: meetingLink).then((uri) async {
        print("Shared Meeting Link = $uri");

        String s = "Hey, you have been invited to join a meeting on 'oneapp' scheduled on ${meeting["start_date"]} at ${meeting["start_time"]}. \n"
            "Click the link below or use the Meeting ID to join the meeting \n\n"
        "Meeting Title : ${meeting["title"]} \n"
        "Meeting ID : ${meeting["id"]} \n"
        "Meeting Link : $uri \n\n"
            "Join a session with ease and collaborate from anywhere. Download 'oneapp' now!";

        FsFacebookUtils.callCartClick("SHARE_MEETING", meeting["id"]);
        FsShare().myShare(context, s, subject: "");
      });
    }
  }

  void parseMeetingsObj(int page, responseObj) {
    _isLoadingData = false;
    _showPageLoader = false;

    ApiData apiData = MeetVoteParser.parseMeetingList(page, responseObj);
    _dataLoadMsg = apiData.dataLoadMsg;
    _errorInDataLoad = apiData.errorInDataLoad;
    metadata = apiData.metadata;
    _meetingList.addAll(apiData.data ?? []);
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  error(int page, error, {callingType}) {
    if (MeetVoteListView.CALL_TYPE_MEETING_LIST == callingType) {
      if (page == 1) {
        _isLoadingData = false;
        _dataLoadMsg = FsString.ERROR_UNKNOWN_RETRY;
        _errorInDataLoad = true;
      } else {
        _showPageLoader = false;
        _dataLoadMsg = null;
        _errorInDataLoad = false;
      }
      setState(() {});
    }
  }

  @override
  failure(int page, failed, {callingType}) {
    if (MeetVoteListView.CALL_TYPE_MEETING_LIST == callingType) {
      if (page == 1) {
        _isLoadingData = false;
        _dataLoadMsg = FsString.ERROR_LOAD_MEETINGS;
        _errorInDataLoad = true;
      } else {
        _showPageLoader = false;
        _dataLoadMsg = null;
        _errorInDataLoad = false;
      }
      setState(() {});
    }
  }

  @override
  success(int page, success, {callingType}) {
    if (MeetVoteListView.CALL_TYPE_MEETING_LIST == callingType) {
      parseMeetingsObj(page, success);
      setState(() {});
    }
  }


  @override
  userDataError1() {
    _isLoadingData = false;
    _errorInDataLoad = true;
    _dataLoadMsg = FsString.ERROR_LOAD_MEETINGS;
    setState(() {});
  }

  @override
  userDataFailure1() {
    _isLoadingData = false;
    _errorInDataLoad = true;
    _dataLoadMsg = FsString.ERROR_LOAD_MEETINGS;
    setState(() {});
  }

  @override
  userDataSuccess1(meetingSocietyId) {
    _loadMeetingList(1);
  }

  /*@override
  userDataError() {
    _isLoadingData = false;
    _errorInDataLoad = true;
    _dataLoadMsg = FsString.ERROR_LOAD_MEETINGS;
    setState(() {});
  }

  @override
  userDataFailure() {
    _isLoadingData = false;
    _errorInDataLoad = true;
    _dataLoadMsg = FsString.ERROR_LOAD_MEETINGS;
    setState(() {});
  }

  @override
  userDataSuccess(bool isAdmin) {
    _isAdmin = isAdmin;
    _loadMeetingList(1);
  }*/
}
