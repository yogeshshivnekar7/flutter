import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/meeting/pojo/meet_vote_pojos.dart';

class JoinWidget extends StatefulWidget {
  var societyId;
  var onJoin;

  JoinWidget({this.societyId, this.onJoin});

  @override
  _JoinWidgetState createState() => new _JoinWidgetState();
}

class _JoinWidgetState extends State<JoinWidget> {
  TextEditingController _meetingIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 15, 10, 15),
            decoration: BoxDecoration(
              color: Colors.blueGrey[50],
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            child: TextField(
              controller: _meetingIdController,
              style: TextStyle(
                fontSize: 15.0,
                color: FsColor.darkgrey,
              ),
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: FsColor.primarymeeting,
                )),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                hintText: "XXX-XXX-XXXX",
                prefixIcon: Icon(
                  Icons.vpn_key,
                  color: Colors.blueGrey[300],
                ),
                hintStyle: TextStyle(
                  fontSize: 15.0,
                  color: Colors.blueGrey[300],
                ),
              ),
              maxLines: 1,
            ),
          ),
          RaisedButton(
            color: FsColor.primarymeeting,
            onPressed: () {
              _validateAndVerifyMeetingId();
            },
            child: Text(
              'Join Meeting',
              style: TextStyle(
                  fontSize: FSTextStyle.h6size,
                  color: FsColor.white,
                  fontFamily: 'Gilroy-SemiBold'),
            ),
          ),
        ],
      ),
    );
  }

  void _validateAndVerifyMeetingId() {
    StepData stepData = StepData();

    String meetingIdStr = _meetingIdController.text?.trim();
    if (meetingIdStr == null || meetingIdStr.trim().isEmpty) {
      stepData.data = null;
      stepData.dataError = true;
      stepData.errorMsg = "please enter meeting id";
    }

    stepData.data = int.parse(meetingIdStr);
    stepData.dataError = false;
    stepData.errorMsg = null;

    if (widget.onJoin != null) {
      widget.onJoin(stepData);
    }
  }
}
