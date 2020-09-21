import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/meeting/create/contacts_presenter.dart';
import 'package:sso_futurescape/ui/module/meeting/create/contacts_view.dart';
import 'package:sso_futurescape/ui/module/meeting/pojo/meet_vote_pojos.dart';
import 'package:sso_futurescape/ui/module/meeting/utils/meet_vote_utils.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:common_config/utils/toast/toast.dart';
import 'package:sso_futurescape/utils/widget_utils.dart';
import 'steps_four.dart';
import 'steps_three.dart';
import 'steps_two.dart';

class MeetVoteCreate extends StatefulWidget {

  var societyId;

  MeetVoteCreate({this.societyId});

  @override
  _MeetVoteCreateState createState() => new _MeetVoteCreateState();
}

class _MeetVoteCreateState extends State<MeetVoteCreate> implements ContactsView {

  int _currentStep = 0;
  static const int _STEPS_COUNT = 3;
  VoidCallback _onStepContinue;
  VoidCallback _onStepCancel;
  var _mainData = {};
  List _stepsData = List(_STEPS_COUNT);
  bool _isLoadingData = true;
  bool _errorInDataLoad = false;
  String _dataLoadMsg;

  ContactsPresenter _contactsPresenter;

  List<GlobalKey> _stepKeys = [
    GlobalKey<StepsTwoState>(),
    GlobalKey<StepsThreeState>(),
    GlobalKey<StepsFourState>(),
  ];

  List<Widget> getStepChildWidgets() {
    return <Widget>[
      StepsTwo(key: _stepKeys[0], data: _stepsData[0],),
      StepsThree(key: _stepKeys[1]),
      StepsFour(key: _stepKeys[2])
    ];
  }

  List<Step> getStepWidgets() {
    List<Widget> stepChildWidgets = getStepChildWidgets();
    if (stepChildWidgets == null || stepChildWidgets.isEmpty) {
      return [];
    }

    List<Step> stepWidgets = [];
    int i = 0;
    for (Widget stepChildWidget in stepChildWidgets) {
      stepWidgets.add(Step(
        title: Text('',),
        content: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: stepChildWidget,
        ),
        isActive: _currentStep >= i,
      ));
      i++;
    }

    return stepWidgets;
  }

  Widget _createEventControlBuilder(BuildContext context,
      {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
    _onStepContinue = onStepContinue;
    _onStepCancel = onStepCancel;
    return SizedBox.shrink();
  }


  @override
  void initState() {
    super.initState();
    _contactsPresenter = ContactsPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return _isLoadingData ? getLoaderWidget() :
    _errorInDataLoad ? getErrorWidget() : getContentWidget();
  }

  Widget getContentWidget() {
    List<Step> stepWidgets = getStepWidgets();

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
            child: Theme(
              data: ThemeData(primaryColor: FsColor.primarymeeting),
              child: Stack(
                children: [
                  Container(
                      padding: EdgeInsets.only(bottom: 50),
                      child: Stepper(
                        type: StepperType.horizontal,
                        currentStep: _currentStep,
                        controlsBuilder: _createEventControlBuilder,
                        onStepContinue: () {
                          setState(() {
                            if (_currentStep < stepWidgets.length - 1) {
                              StepData stepData = validateAndGetStepData(_currentStep);
                              if (stepData.dataError) {
                                Toasly.error(context, stepData.errorMsg);
                              } else {
                                saveStepData(_currentStep, stepData);
                                addStepDataToMainData(_currentStep, stepData);
                                _currentStep++;
                              }
                            } else {
                              print('complete');
                            }
                          });
                        },
                        onStepCancel: () {
                          setState(() {
                            if (_currentStep > 0) {
                              _currentStep--;
                            } else {
                              _currentStep = 0;
                            }
                          });
                        },
                        steps: stepWidgets,
                      )),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: getBottomBarWidget(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getBottomBarWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      decoration: BoxDecoration(
          // color: FsColor.red,
          border: Border(
        top: BorderSide(width: 1, color: FsColor.darkgrey.withOpacity(0.2)),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 42,
            child: FlatButton(
              onPressed: () => _onStepCancel(),
              // color: FsColor.secondarymeeting,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
                // side: BorderSide(width: 1, color: FsColor.secondarymeeting)
              ),
              color: FsColor.primarymeeting.withOpacity(0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.chevron_left,
                      color: FsColor.primarymeeting, size: 24),
                  Text(
                    'Back',
                    style: TextStyle(
                        fontFamily: 'Gilroy-SemiBold',
                        fontSize: FSTextStyle.h6size,
                        color: FsColor.primarymeeting),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 42,
            child: FlatButton(
              onPressed: () => _onStepContinue(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              color: FsColor.primarymeeting,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Next',
                    style: TextStyle(
                        fontFamily: 'Gilroy-SemiBold',
                        fontSize: FSTextStyle.h6size,
                        color: FsColor.white),
                  ),
                  Icon(Icons.chevron_right, color: FsColor.white, size: 24),
                ],
              ),
            ),
          ),
        ],
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

        },
      ),
    );
  }


  void _loadContacts() {

  }



  StepData validateAndGetStepData(int step) {
    StepData defaultStepData = StepData();
    defaultStepData.dataError = false;
    defaultStepData.data = null;
    defaultStepData.errorMsg = null;

    GlobalKey key = (_stepKeys != null) ? _stepKeys[step] : null;
    if (key == null) {
      return defaultStepData;
    }

    switch (step) {
      case 0:
        GlobalKey<StepsTwoState> stepKey = key;
        return stepKey.currentState.validateAndGetStepData();
      case 1:
        return defaultStepData;
      case 2:
        return defaultStepData;
      default:
        return defaultStepData;
    }
  }

  void saveStepData(int step, StepData stepData) {
    _stepsData[step] = stepData.data;
  }

  void addStepDataToMainData(int step, StepData stepData) {
    switch(step) {
      case 0:
        var data = stepData.data;
        if (data != null) {
          _mainData["title"] = data["title"];
          _mainData["description"] = data["description"];
          _mainData["start_date"] = data["start_date"];
          _mainData["end_date"] = data["end_date"];
          _mainData["start_time"] = data["start_time"];
          _mainData["end_time"] = data["end_time"];
          _mainData["invitation_info"] = data["invitation_info"];
          _mainData["invite_date"] = data["invite_date"];
          _mainData["invite_time"] = data["invite_time"];
        }
        break;

      case 1:
        var data = stepData.data;
        if (data != null) {
          List agendaList = data["agendas"];
          if (agendaList != null && agendaList.isNotEmpty) {
            _mainData["agendas"] = agendaList;
          }
        }
        break;
    }
  }

  @override
  contactError(error, {callingType}) {
    if (callingType == ContactsView.CALL_TYPE_LOAD_CONTACTS) {
      _isLoadingData = false;
      _errorInDataLoad = true;
      _dataLoadMsg = "Failed to load contacts. Please try again";
      setState(() {});
    } else if (callingType == ContactsView.CALL_TYPE_ADD_CONTACT) {

    }
  }

  @override
  contactFailure(failed, {callingType}) {
    if (callingType == ContactsView.CALL_TYPE_LOAD_CONTACTS) {
      _isLoadingData = false;
      _errorInDataLoad = true;
      _dataLoadMsg = "Failed to load contacts. Please try again";
      setState(() {});
    } else if (callingType == ContactsView.CALL_TYPE_ADD_CONTACT) {

    }
  }

  @override
  contactSuccess(success, var societyId, {callingType}) {
    if (callingType == ContactsView.CALL_TYPE_LOAD_CONTACTS) {

    } else if (callingType == ContactsView.CALL_TYPE_ADD_CONTACT) {

    }
  }
}
