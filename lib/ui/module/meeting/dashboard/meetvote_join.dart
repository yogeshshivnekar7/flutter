import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/ui/module/meeting/details/meet_vote_details_presenter.dart';
import 'package:sso_futurescape/ui/module/meeting/details/meet_vote_details_view.dart';
import 'package:sso_futurescape/ui/module/meeting/details/meetvote_main.dart';
import 'package:sso_futurescape/ui/module/meeting/pojo/meet_vote_pojos.dart';
import 'package:sso_futurescape/ui/module/meeting/utils/meet_vote_parser.dart';
import 'package:sso_futurescape/ui/module/recipe/widgets/progress_dialog.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/widget_utils.dart';
import 'package:common_config/utils/toast/toast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'join_widget.dart';

class MeetVoteJoin extends StatefulWidget {

  var societyId;

  MeetVoteJoin({this.societyId});

  @override
  _MeetVoteJoinState createState() => new _MeetVoteJoinState();
}

class _MeetVoteJoinState extends State<MeetVoteJoin> implements MeetVoteDetailsView {

  ProgressDialog _progressDialog;
  MeetVoteDetailsPresenter _meetVoteDetailsPresenter;

  @override
  void initState() {
    super.initState();
    _meetVoteDetailsPresenter = MeetVoteDetailsPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    _progressDialog = customizedLoadingDialog(context,
        FsString.MSG_TITLE_PROGRESS_DIALOG_VERIFY_MEETING,
        progressWidget: Center(child: WidgetUtils.getMeetingCircularProgressWidget()));

    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: new Text(
          'Join Meeting'.toLowerCase(),
          style: FSTextStyle.appbartext,
        ),
        leading: FsBackButton(),
      ),
      body:Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Text('Enter the Meeting ID to join a meeting', textAlign: TextAlign.center,
              style: TextStyle(fontSize: FSTextStyle.h6size, color: FsColor.secondarymeeting, fontFamily: 'Gilroy-SemiBold'),
            ),
          ),
          JoinWidget(onJoin: (stepData) {
            if (stepData.dataError) {
              Toasly.error(context, stepData.errorMsg);
              return;
            }
            var data = stepData.data;
            _verifyMeeting(data);
          },),
        ],
      )
    );
  }

  void _verifyMeeting(int meetingId) {
    AppUtils.checkInternetConnection().then((value) {
      if (value) {
        _progressDialog.show();
        _loadMeetingDetails(meetingId);
      } else {
        Toasly.error(context, FsString.ERROR_NO_INTERNET);
      }
    });
  }

  void _loadMeetingDetails(int meetingId) {
    _meetVoteDetailsPresenter.loadMeetingDetails(meetingId, MeetVoteDetailsView.CALL_TYPE_MEETING_DETAILS);
  }

  void _openMeetingDetails(int meetingId) {
    int pops = 0;
    int popsRequired = 2; //had to be 1 but it is 2 for the progress dialog to pop out
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute (
      builder: (context) => MeetVoteMain(meetingId, societyId: widget.societyId),
    ), (Route<dynamic> route) {
      pops++;
      return pops > popsRequired;
    });
  }

  void parseMeetingDetailsObj(meetingDetailsObj) {
    ApiData apiData = MeetVoteParser.parseMeetingDetails(meetingDetailsObj);
    var _meetingDetails = apiData.data;

    _openMeetingDetails(int.parse(_meetingDetails["id"]));
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  error(error, {callingType}) {
    if (MeetVoteDetailsView.CALL_TYPE_MEETING_DETAILS == callingType) {
      Toasly.error(context, FsString.ERROR_UNKNOWN_RETRY);
      _progressDialog.hide();
    }
  }

  @override
  failure(failed, {callingType}) {
    if (MeetVoteDetailsView.CALL_TYPE_MEETING_DETAILS == callingType) {
      Toasly.error(context, FsString.ERROR_VERIFY_MEETING);
      _progressDialog.hide();
    }
  }

  @override
  success(success, {callingType}) {
    if (MeetVoteDetailsView.CALL_TYPE_MEETING_DETAILS == callingType) {
      _progressDialog.hide();
      parseMeetingDetailsObj(success);
    }
  }
}
