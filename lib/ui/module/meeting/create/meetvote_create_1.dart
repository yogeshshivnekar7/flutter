import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/ui/module/meeting/create/meet_vote_create_presenter.dart';
import 'package:sso_futurescape/ui/module/meeting/create/meet_vote_create_view.dart';
import 'package:sso_futurescape/ui/module/meeting/create/steps_two.dart';
import 'package:sso_futurescape/ui/module/meeting/listing/meetvote_list.dart';
import 'package:sso_futurescape/ui/module/meeting/utils/meet_vote_utils.dart';
import 'package:sso_futurescape/ui/module/recipe/widgets/progress_dialog.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:common_config/utils/toast/toast.dart';
import 'package:sso_futurescape/utils/widget_utils.dart';

class MeetVoteCreate1 extends StatefulWidget {

  bool edit = false;
  var societyId;

  MeetVoteCreate1({this.societyId});

  @override
  _MeetVoteCreate1State createState() => _MeetVoteCreate1State();
}

class _MeetVoteCreate1State extends State<MeetVoteCreate1> implements MeetVoteCreateView {

  MeetVoteCreatePresenter _createMeetVotePresenter;
  ProgressDialog _progressDialog;


  @override
  void initState() {
    super.initState();
    _createMeetVotePresenter = MeetVoteCreatePresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    _progressDialog = customizedLoadingDialog(context, widget.edit ?
    FsString.MSG_TITLE_PROGRESS_DIALOG_UPDATE_MEETING : FsString.MSG_TITLE_PROGRESS_DIALOG_CREATE_MEETING,
        progressWidget: Center(child: WidgetUtils.getMeetingCircularProgressWidget()));

    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: new Text(
          'Create Meeting'.toLowerCase(),
          style: FSTextStyle.appbartext,
        ),
        leading: FsBackButton(
          backEvent: MeetVoteUtils.onBackPressed(context),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: StepsTwo(onNext: (stepData) {
                if (stepData.dataError) {
                  Toasly.error(context, stepData.errorMsg);
                  return;
                }
                var data = stepData.data;
                _createMeeting(data);
              },),
            ),
          ),
        ],
      ),
    );
  }

  void _createMeeting(var data) {
    AppUtils.checkInternetConnection().then((value) {
      if (value) {
        _progressDialog.show();
        _createMeetVotePresenter.createMeeting(data,
            MeetVoteCreateView.CALL_TYPE_CREATE_MEETING, societyId: widget.societyId);
      } else {
        Toasly.error(context, FsString.ERROR_NO_INTERNET);
      }
    });
  }

  void _openMeetingList() {
    if (!widget.edit) {
      int pops = 0;
      int popsRequired = 2; //had to be 1 but it is 2 for the progress dialog to pop out
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute (
        builder: (context) => MeetVoteList(societyId: widget.societyId),
      ), (Route<dynamic> route) {
        pops++;
        return pops > popsRequired;
      });
    }
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }


  @override
  createMeetVoteError(error, {callingType}) {
    if (callingType == MeetVoteCreateView.CALL_TYPE_CREATE_MEETING) {
      _progressDialog.hide();
      Toasly.error(context, FsString.ERROR_CREATE_MEETING);
    }
  }

  @override
  createMeetVoteFailure(failed, {callingType}) {
    if (callingType == MeetVoteCreateView.CALL_TYPE_CREATE_MEETING) {
      _progressDialog.hide();
      Toasly.error(context, FsString.ERROR_CREATE_MEETING);
    }
  }

  @override
  createMeetVoteSuccess(success, {callingType}) {
    if (callingType == MeetVoteCreateView.CALL_TYPE_CREATE_MEETING) {
      Toasly.success(context, FsString.SUCCESS_CREATE_MEETING);
      _progressDialog.hide();
      _openMeetingList();
    }
  }
}
