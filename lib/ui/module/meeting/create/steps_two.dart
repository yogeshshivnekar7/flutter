import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/ui/module/meeting/create/meet_vote_create_presenter.dart';
import 'package:sso_futurescape/ui/module/meeting/create/meet_vote_create_view.dart';
import 'package:sso_futurescape/ui/module/meeting/listing/meetvote_list.dart';
import 'package:sso_futurescape/ui/module/meeting/pojo/meet_vote_pojos.dart';
import 'package:sso_futurescape/ui/module/recipe/widgets/progress_dialog.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:common_config/utils/toast/toast.dart';
import 'package:sso_futurescape/utils/widget_utils.dart';

class StepsTwo extends StatefulWidget {

  var data;
  bool edit = false;
  Function onNext;

  StepsTwo({Key key, this.data, this.onNext}) : super(key: key);

  @override
  StepsTwoState createState() => new StepsTwoState();
}

class StepsTwoState extends State<StepsTwo> {
  
  String selectedType = "manual";

  TextEditingController _titleController;
  TextEditingController _descriptionController;
  TextEditingController _startDateController;
  TextEditingController _endDateController;
  TextEditingController _startTimeController;
  TextEditingController _endTimeController;
  TextEditingController _inviteDateController;
  TextEditingController _inviteTimeController;


  @override
  void initState() {
    super.initState();
      _titleController = TextEditingController(text: getDataValue("title"));
      _descriptionController = TextEditingController(text: getDataValue("description"));
      _startDateController = TextEditingController(text: getDataValue("start_date"));
      _endDateController = TextEditingController(text: getDataValue("end_date"));
      _startTimeController = TextEditingController(text: getDataValue("start_time"));
      _endTimeController = TextEditingController(text: getDataValue("end_time"));
      _inviteDateController = TextEditingController(text: getDataValue("invite_date"));
      _inviteTimeController = TextEditingController(text: getDataValue("invite_time"));
      selectedType = getDataValue("invitation_info");

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 15),
            child: Text('Fill in the details below to create a meeting', textAlign: TextAlign.center,
              style: TextStyle(fontSize: FSTextStyle.h5size, color: FsColor.secondarymeeting, fontFamily: 'Gilroy-SemiBold'),
            ),
          ),

          Container(
            margin: EdgeInsets.only(bottom: 15),
            child: TextField(
              controller: _titleController,
              style: TextStyle(fontFamily: 'Gilroy-SemiBold', fontSize: FSTextStyle.h6size, color: FsColor.darkgrey),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 5, right: 5),
                labelText: 'Enter title here',
                labelStyle: TextStyle(fontFamily: 'Gilroy-Regular', fontSize: FSTextStyle.h6size, color: FsColor.darkgrey.withOpacity(0.75)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: FsColor.primarymeeting)
                )
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15,),
            child: TextField(
              controller: _descriptionController,
              style: TextStyle(fontFamily: 'Gilroy-SemiBold', fontSize: FSTextStyle.h6size, color: FsColor.darkgrey),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 5, right: 5),
                labelText: 'Enter overview here',
                labelStyle: TextStyle(fontFamily: 'Gilroy-Regular', fontSize: FSTextStyle.h6size, color: FsColor.darkgrey.withOpacity(0.75)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: FsColor.primarymeeting)
                )
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.only(bottom: 15,),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: DateTimeField(
                      controller: _startDateController,
                      format: DateFormat(AppUtils.DATE_FORM_DD_MM_YYYY_2),
                      style: TextStyle(fontFamily: 'Gilroy-SemiBold', fontSize: FSTextStyle.h6size, color: FsColor.darkgrey),
                      onShowPicker: (context, currentValue) {
                        DateTime currentDate = DateTime.now();
                        DateTime maxDate = currentDate.add(Duration(days: 90));
                        return showDatePicker(
                            context: context,
                            firstDate: currentDate,
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: maxDate);
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.date_range, color: FsColor.lightgrey, size: 24,),
                        contentPadding: EdgeInsets.only(left: 5, right: 5),
                        labelText: "Start Date".toLowerCase(),
                        labelStyle: TextStyle(fontFamily: 'Gilroy-Regular', fontSize: FSTextStyle.h6size, color: FsColor.darkgrey.withOpacity(0.75)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: FsColor.primarymeeting)
                        )
                      ),
                    ),
                  ),
                ),
                // SizedBox(width: 10),
                Expanded(
                child:  Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: DateTimeField(
                    controller: _endDateController,
                    style: TextStyle(fontFamily: 'Gilroy-SemiBold', fontSize: FSTextStyle.h6size, color: FsColor.darkgrey),
                    format: DateFormat(AppUtils.DATE_FORM_DD_MM_YYYY_2),
                    onShowPicker: (context, currentValue) {
                      DateTime currentDate = DateTime.now();
                      DateTime maxDate = currentDate.add(Duration(days: 90));
                      return showDatePicker(
                          context: context,
                          firstDate: currentDate,
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: maxDate);
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.date_range, color: FsColor.lightgrey, size: 24,),
                      contentPadding: EdgeInsets.only(left: 5, right: 5),
                      labelText: "End Date".toLowerCase(),
                      labelStyle: TextStyle(fontFamily: 'Gilroy-Regular', fontSize: FSTextStyle.h6size, color: FsColor.darkgrey.withOpacity(0.75)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: FsColor.primarymeeting)
                      )
                    ),
                  ),
                ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15,),
            child: Row(
              children: [
                Expanded(
                child:  Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: DateTimeField(
                    controller: _startTimeController,
                    format: DateFormat("hh:mm a"),
                    style: TextStyle(fontFamily: 'Gilroy-SemiBold', fontSize: FSTextStyle.h6size, color: FsColor.darkgrey),
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.convert(time);
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.access_time, color: FsColor.lightgrey, size: 24,),
                      contentPadding: EdgeInsets.only(left: 5, right: 5),
                      labelText: "Start Time".toLowerCase(),
                      labelStyle: TextStyle(fontFamily: 'Gilroy-Regular', fontSize: FSTextStyle.h6size, color: FsColor.darkgrey.withOpacity(0.75)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: FsColor.primarymeeting)
                      )
                    ),
                  ),
                ),
                ),
                // SizedBox(width: 10),
                Expanded (
                child:  Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: DateTimeField(
                    controller: _endTimeController,
                    format: DateFormat("hh:mm a"),
                    style: TextStyle(fontFamily: 'Gilroy-SemiBold', fontSize: FSTextStyle.h6size, color: FsColor.darkgrey),
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.convert(time);
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.access_time, color: FsColor.lightgrey, size: 24,),
                      contentPadding: EdgeInsets.only(left: 5, right: 5),
                      labelText: "End Time".toLowerCase(),
                      labelStyle: TextStyle(fontFamily: 'Gilroy-Regular', fontSize: FSTextStyle.h6size, color: FsColor.darkgrey.withOpacity(0.75)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: FsColor.primarymeeting)
                      )
                    ),
                  ),
                ),
                ),
              ],
            ),
          ),
          //_getSendInvitationSectionWidget(),
          _getCreateMeetingButtonWidget(),
        ],
      ),
    );
  }

  Widget _getSendInvitationSectionWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      // padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4.0),),
        border: Border.all(width: 1.0, color: FsColor.primarymeeting.withOpacity(0.2),),
      ),
      child: Column(
        children: [

          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: FsColor.primarymeeting.withOpacity(0.2)),
              ),
              color: FsColor.primarymeeting.withOpacity(0.1),
            ),
            child: Text('Send Invitation', textAlign: TextAlign.left,
              style: TextStyle(fontSize: FSTextStyle.h6size, color: FsColor.secondarymeeting, fontFamily: 'Gilroy-SemiBold'),
            ),
          ),

          Row(
            children: <Widget>[
              Expanded(
                child: _invitationSelect(context: context, invitationoptions: "Now"),
              ),
              Expanded(
                child: _invitationSelect(context: context, invitationoptions: "Manual"),
              ),
              Expanded(
                child: _invitationSelect(context: context, invitationoptions: "Schedule"),
              ),
            ],
          ),
          SizedBox(height: 10),


          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
            decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1, color: FsColor.darkgrey.withOpacity(0.2)),
                )
            ),
            child: Row(
              children: [
                Expanded(
                  child:  DateTimeField(
                    format: DateFormat(AppUtils.DATE_FORM_DD_MM_YYYY_2),
                    style: TextStyle(fontFamily: 'Gilroy-SemiBold', fontSize: FSTextStyle.h6size, color: FsColor.darkgrey),
                    controller: _inviteDateController,
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2100));
                    },
                    decoration: InputDecoration(
                        icon: Icon(Icons.date_range, color: FsColor.lightgrey, size: 24,),
                        contentPadding: EdgeInsets.only(left: 5, right: 5),
                        labelText: "Invitation Date".toLowerCase(),
                        labelStyle: TextStyle(fontFamily: 'Gilroy-Regular', fontSize: FSTextStyle.h6size, color: FsColor.darkgrey.withOpacity(0.75)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: FsColor.primarymeeting)
                        )
                    ),
                  ),
                ),
                Expanded(
                  child:  DateTimeField(
                    format: DateFormat("hh:mm a"),
                    style: TextStyle(fontFamily: 'Gilroy-SemiBold', fontSize: FSTextStyle.h6size, color: FsColor.darkgrey),
                    controller: _inviteTimeController,
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.convert(time);
                    },
                    decoration: InputDecoration(
                        icon: Icon(Icons.access_time, color: FsColor.lightgrey, size: 24,),
                        contentPadding: EdgeInsets.only(left: 5, right: 5),
                        labelText: "Invitation Time".toLowerCase(),
                        labelStyle: TextStyle(fontFamily: 'Gilroy-Regular', fontSize: FSTextStyle.h6size, color: FsColor.darkgrey.withOpacity(0.75)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: FsColor.primarymeeting)
                        )
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _getCreateMeetingButtonWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 36, 0, 24),
      child: RaisedButton(
        elevation: 1.0,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(4.0),
        ),
        onPressed: () {
          _validateAndCreateMeeting();
        },
        color: FsColor.primarymeeting,
        padding: EdgeInsets.symmetric(
            vertical: 10.0, horizontal: 10.0),
        child: Text("Create Meeting",
          style: TextStyle(
              fontSize: FSTextStyle.h6size,
              fontFamily: 'Gilroy-Bold',
              color: FsColor.white),
        ),
      ),
    );
  }

 Widget _invitationSelect({BuildContext context, String invitationoptions,}){
    bool isActive = invitationoptions == selectedType;
    return Column(
      children: [
        Radio(
          value: invitationoptions, 
          activeColor: FsColor.primarymeeting,
          groupValue: selectedType, 
          onChanged: (String invite) {
            setState(() {
              selectedType = invite;
            });
          },
        ),
        Text(invitationoptions.toLowerCase(),
          style: TextStyle(fontSize: FSTextStyle.h6size, letterSpacing: 1, color: isActive ? FsColor.basicprimary : null, fontFamily: 'Gilroy-SemiBold'),
        ),
  
      ],
    );
  }


  String getDataValue(String dataKey) {
    if (widget.data == null) {
      return "";
    }
    return widget.data[dataKey]?.toString()?.trim() ?? "";
  }


  StepData validateAndGetStepData() {
    StepData stepData = StepData();
    var data = {};

    String title = _titleController.text?.trim();
    if (title == null || title.isEmpty) {
      stepData.dataError = true;
      stepData.errorMsg = "please enter a meeting title";
      return stepData;
    }
    data["title"] = title;

    String description = _descriptionController.text?.trim();
    data["description"] = description;

    String startDate = _startDateController.text?.trim();
    if (startDate == null || startDate.isEmpty) {
      stepData.dataError = true;
      stepData.errorMsg = "please enter meeting start date";
      return stepData;
    }

    String endDate = _endDateController.text?.trim();
    if (endDate == null || endDate.isEmpty) {
      stepData.dataError = true;
      stepData.errorMsg = "please enter meeting end date";
      return stepData;
    }

    DateTime startDateObj = DateTime.parse(AppUtils.getDateTime(startDate,
    sourceFormat: AppUtils.DATE_FORM_DD_MM_YYYY_2, requiredFormat: AppUtils.DATE_FORM_YYYY_MM_DD_2));
    DateTime endDateObj = DateTime.parse(AppUtils.getDateTime(endDate,
        sourceFormat: AppUtils.DATE_FORM_DD_MM_YYYY_2, requiredFormat: AppUtils.DATE_FORM_YYYY_MM_DD_2));

    if (startDateObj.isAfter(endDateObj)) {
      stepData.dataError = true;
      stepData.errorMsg = "meeting start date must be on or before end date";
      return stepData;
    }
    data["start_date"] = startDate;
    data["end_date"] = endDate;

    String startTime12 = _startTimeController.text?.trim();
    if (startTime12 == null || startTime12.isEmpty) {
      stepData.dataError = true;
      stepData.errorMsg = "please enter meeting start time";
      return stepData;
    }

    String endTime12 = _endTimeController.text?.trim();
    if (endTime12 == null || endTime12.isEmpty) {
      stepData.dataError = true;
      stepData.errorMsg = "please enter meeting end time";
      return stepData;
    }

    DateTime startTimeObj24 = DateFormat(AppUtils.TIME_FORM_HH_MM_A).parse(startTime12);
    DateTime endTimeObj24 = DateFormat(AppUtils.TIME_FORM_HH_MM_A).parse(endTime12);
    String startTime24 = DateFormat(AppUtils.TIME_FORM_HH_MM).format(startTimeObj24);
    String endTime24 = DateFormat(AppUtils.TIME_FORM_HH_MM).format(endTimeObj24);

    DateTime startDateTimeObj = DateTime(startDateObj.year,
    startDateObj.month,
    startDateObj.day,
    startTimeObj24.hour,
    startTimeObj24.minute,
    startTimeObj24.second);

    DateTime endDateTimeObj = DateTime(endDateObj.year,
        endDateObj.month,
        endDateObj.day,
        endTimeObj24.hour,
        endTimeObj24.minute,
        endTimeObj24.second);

    if(startDateTimeObj.isAfter(endDateTimeObj)) {
      stepData.dataError = true;
      stepData.errorMsg = "meeting start time must be before end time";
      return stepData;
    }

    data["start_time"] = startTime24;
    data["end_time"] = endTime24;

    data["invitation_info"] = selectedType;

    /*if("manual" == selectedType.toLowerCase()) {
      String inviteDate = _inviteDateController.text?.trim();
      if (inviteDate == null || inviteDate.isEmpty) {
        stepData.dataError = true;
        stepData.errorMsg = "please enter invitation date";
        return stepData;
      }

      DateTime inviteDateObj = DateTime.parse(AppUtils.getDateTime(inviteDate,
          sourceFormat: AppUtils.DATE_FORM_DD_MM_YYYY_2, requiredFormat: AppUtils.DATE_FORM_YYYY_MM_DD_2));
      if (inviteDateObj.isAfter(startDateObj)) {
        stepData.dataError = true;
        stepData.errorMsg = "invitation date must be on or before meeting start date";
        return stepData;
      }
      data["invite_date"] = inviteDate;

      String inviteTime12 = _inviteTimeController.text?.trim();
      if (inviteTime12 == null || inviteTime12.isEmpty) {
        stepData.dataError = true;
        stepData.errorMsg = "please enter invitation time";
        return stepData;
      }

      DateTime inviteTimeObj24 = DateFormat(AppUtils.TIME_FORM_HH_MM_A).parse(inviteTime12);
      String inviteTime24 = DateFormat(AppUtils.TIME_FORM_HH_MM).format(inviteTimeObj24);

      DateTime inviteDateTimeObj = DateTime(inviteDateObj.year,
          inviteDateObj.month,
          inviteDateObj.day,
          inviteTimeObj24.hour,
          inviteTimeObj24.minute,
          inviteTimeObj24.second);

      if(inviteDateTimeObj.isAfter(startDateTimeObj)) {
        stepData.dataError = true;
        stepData.errorMsg = "invitation time must be before meeting start time";
        return stepData;
      }

      data["invite_time"] = inviteTime24;
    }*/

    data["invite_date"] = startDate;
    data["invite_time"] = startTime24;

    stepData.data = data;
    stepData.errorMsg = null;
    stepData.dataError = false;

    return stepData;
  }

  void _validateAndCreateMeeting() {
    StepData stepData = validateAndGetStepData();
    if (widget.onNext != null) {
      widget.onNext(stepData);
    }
  }
}
