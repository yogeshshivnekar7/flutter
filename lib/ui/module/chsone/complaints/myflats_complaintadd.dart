import 'dart:io';

import 'package:common_config/utils/fs_navigator.dart';
import 'package:common_config/utils/toast/toast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/presentor/module/chsone/complaints/complaint_presenter.dart';
import 'package:sso_futurescape/presentor/module/chsone/complaints/complaint_view.dart';
import 'package:sso_futurescape/ui/module/chsone/myflats_dashboard.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/storage/complex.dart';

class MyFlatsComplaintsAdd extends StatefulWidget {
  var currentUnitDetails;

  MyFlatsComplaintsAdd(this.currentUnitDetails);

  @override
  _MyFlatsComplaintsAddState createState() =>
      new _MyFlatsComplaintsAddState(currentUnitDetails);
}

class _MyFlatsComplaintsAddState extends State<MyFlatsComplaintsAdd>
    implements ComplaintView, AddComplaintView {
  ComplaintPresenter presenter;
  bool isLoading = true;

  TextEditingController _complaintDetailsController =
      new TextEditingController();
  TextEditingController _complaintSubjectController =
      new TextEditingController();

  String _complaintDetailsErrorText;
  String _complaintSubjectErrorText;
  var currentUnitDetails;
  var currentUnit;
  var socId;

  _MyFlatsComplaintsAddState(currentUnitDetails) {
    this.currentUnitDetails = currentUnitDetails;
    this.currentUnit = currentUnitDetails['unit_id'];
    this.socId = currentUnitDetails['soc_id'];
  }

  File fileUploaded = null;

  //_MyFlatsComplaintsAddState(this.currentUnit);

  @override
  void initState() {
    presenter = new ComplaintPresenter(this);
    getHelpTopics();
    super.initState();
  }

  List<dynamic> _topic; // Option 1
  // HashMap<int,String> _topic;
  var _selectedtopic;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: FsColor.primaryflat,
        title: new Text(
          'Raise Complaint'.toLowerCase(),
          style: FSTextStyle.appbartextlight,
        ),
        leading: FsBackButtonlight(
//          backEvent: (context) {
//            backHandler(context);
//          },
            ),
        actions: <Widget>[],
      ),
      body: isLoading
          ? PageLoader()
          : SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                    child: Text(
                      'give us your complaint details',
                      style: TextStyle(
                        fontSize: FSTextStyle.h5size,
                        fontFamily: 'Gilroy-SemiBold',
                        color: FsColor.darkgrey,
                        height: 1.2,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Text(
                                'Choose a Topic'.toLowerCase(),
                                style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  color: FsColor.darkgrey,
                                  fontFamily: 'Gilroy-SemiBold',
                                ),
                              ),
                              value: _selectedtopic == null
                                  ? null
                                  : _selectedtopic,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedtopic = newValue;
                                  print(_selectedtopic);
                                });
                              },
                              items: _topic != null && _topic.length > 0
                                  ? _topic.map((topic) {
                                      return DropdownMenuItem(
                                        child: new Text(
                                          topic["help_topic"],
                                          style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            color: FsColor.darkgrey,
                                            fontFamily: 'Gilroy-SemiBold',
                                          ),
                                        ),
                                        value: topic,
                                      );
                                    }).toList()
                                  : null,
                            ),
                          ),
                        ]),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                    child: TextField(
                      controller: _complaintSubjectController,
                      style: TextStyle(
                          fontFamily: 'Gilroy-SemiBold',
                          fontSize: FSTextStyle.h6size,
                          color: FsColor.darkgrey),
                      decoration: InputDecoration(
                          errorText: _complaintSubjectErrorText,
                          labelText: 'Enter Complaint Subject'.toLowerCase(),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: FsColor.basicprimary))),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                    child: TextField(
                      controller: _complaintDetailsController,
                      maxLines: 3,
                      style: TextStyle(
                          fontFamily: 'Gilroy-SemiBold',
                          fontSize: FSTextStyle.h6size,
                          color: FsColor.darkgrey),
                      decoration: InputDecoration(
                          errorText: _complaintDetailsErrorText,
                          labelText: 'Enter Complaint Details'.toLowerCase(),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: FsColor.basicprimary))),
                    ),
                  ),
                  fileUploaded == null
                      ? Container(
                          margin: EdgeInsets.all(20),
                          child: Column(
                            children: <Widget>[
                              GestureDetector(
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: FsColor.lightgrey.withOpacity(0.1),
                                    border: Border.all(
                                        width: 1, color: FsColor.lightgrey),
                                  ),
                                  child: Icon(
                                    FlutterIcon.plus,
                                    color: FsColor.primaryflat,
                                  ),
                                ),
                                onTap: () {
                                  getFile();
                                },
                              ),
                              Text(
                                'upload image here',
                                style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    fontFamily: 'Gilroy-SemiBold',
                                    color: FsColor.darkgrey),
                              )
                            ],
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: ListTile(
                            title: Text(
                              fileUploaded.path,
                              style: TextStyle(),
                              overflow: TextOverflow.ellipsis,
                            ),
                            //subtitle: Text(fileUploaded.path),
                            trailing: IconButton(
                              icon: Icon(
                                FlutterIcon.cancel_1,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                fileUploaded = null;
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                  Container(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      child: RaisedButton(
                        padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(4.0),
                        ),
                        child: Text('Raise Complaint',
                            style: TextStyle(
                              fontSize: FSTextStyle.h6size,
                              fontFamily: 'Gilroy-SemiBold',
                            )),
                        onPressed: () {
                          requestApiCall();
                        },
                        color: FsColor.primaryflat,
                        textColor: FsColor.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future getFile() async {
    this.fileUploaded = await FilePicker.getFile();
    print(fileUploaded);
    if (fileUploaded != null) {}
    print(fileUploaded);
    setState(() {});
  }

  void getHelpTopics() {
    isLoading = true;
    print("=====================================>>");
    print(currentUnit);
    presenter.getHelpdeskComplaintTopic(socId);
  }

  @override
  onErrorHelpTopics(errror) {
    Toasly.error(context, "Issue has not been raised");
  }

  @override
  onFailureHelpTopics(failed) {
    isLoading = false;

    print(failed);
    Toasly.error(context, AppUtils.errorDecoder(failed));
    setState(() {});
  }

  @override
  onSuccessHelpTopics(response) {
    setState(() {
      isLoading = false;
      this._topic = response['data'];
    });
  }

  @override
  onSuccessAddComplaint(response) {
    isLoading = false;
    Toasly.success(context, response['message']);
//    Navigator.pop(context);
    backHandler(context);
  }

  void requestApiCall() {
    print("dddddd");
    String detail = _complaintDetailsController.text.trim();
    String subject = _complaintSubjectController.text.trim();
    String topic;
    bool isValid = true;
    var currentUnit = this.currentUnit;
    print("dddddd");
    if (_selectedtopic != null) {
      topic = _selectedtopic["help_topic_id"].toString();
    } else {
      topic = null;
      isValid = false;
    }
    _complaintSubjectErrorText = null;
    _complaintDetailsErrorText = null;

    if (subject.trim().isEmpty) {
      isValid = false;
      _complaintSubjectErrorText = "please enter subject";
    }
    if (detail.trim().isEmpty) {
      isValid = false;
      _complaintDetailsErrorText = "please enter deatails";
    }

    if (topic == null) {
      Toasly.error(context, "please select topic");
      isValid = false;
    }

    // var currentUnit="12";
    if (isValid) {
      print("asaasasasas");
      isLoading = true;
      presenter.addComplait(detail, subject, currentUnit, topic,
          file: fileUploaded);
    }
    setState(() {});
  }

  @override
  void onError(String response) {
    isLoading = false;
    Toasly.error(context, AppUtils.errorDecoder(response));
    setState(() {});
  }

  @override
  void onFailure(String response) {
    isLoading = false;
    Toasly.error(context, AppUtils.errorDecoder(response));
    setState(() {});
  }

  void backHandler(context) {
    print("backHandeler---------------------------");
    FsNavigator.push(context, MyFlatsDashboard(currentUnitDetails));
  }
}
