import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/ipl/api_call.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/utils/facebook_utils.dart';

class IplParticipateQuiz extends StatefulWidget {
  int userid;
  Function action;

  IplParticipateQuiz({this.userid, this.action});

  @override
  _IplParticipateQuizState createState() => new _IplParticipateQuizState();
}

class _IplParticipateQuizState extends State<IplParticipateQuiz> {
  String selectedType = "";
  bool _answerCheck = true, _submitted = false;
  bool loading = false;
  String questiontext, submitText = 'Submit';
  List options = [];
  int questiontextid;
  Map selectedAnswer;

  Future fetchdata() async {
    if (widget.userid != null) {
      await fetchTodayQuiz(widget.userid).then((value) {
        if (value != null) {
          //print(value);
          if (mounted) {
            questiontext = value['data']['question_text'];
            questiontextid = value['data']['id'];
            options = value['data']['options'];
            _submitted = value["data"]["answered"].toString() == "1";
            if (_submitted) {
              submitText = 'Submitted';
              _answerCheck = true;
              for (int i = 0; i < options.length; i++) {
                if (options[i]['id'] == value["data"]["option_id"]) {
                  selectedAnswer = options[i];
                  selectedType = options[i]["option"];
                  break;
                }
              }
            }
            setState(() {
              /*if (prefs.getBool('_submitted') != null) {
                if (prefs.getBool('_submitted') == true) {
                  _submitted = true;
                }
              }
              if (prefs.getString('selectedType') != null) {
                selectedType = prefs.getString('selectedType') ?? '';
              }*/
              loading = false;
            });
          }
        }
      });
    }
  }

  @override
  void initState() {
    FsFacebookUtils.callCartClick("ipl_participate_quiz_click", "page open");
    setState(() {
      loading = true;
    });
    fetchdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? PageLoader(
            title: 'iplQuiz',
          )
        : SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                          // border: Border(
                          //   bottom: BorderSide(width: 1, color: FsColor.lightgrey)
                          // )
                          ),
                      width: double.infinity,
                      child: Text(
                        questiontext ?? '',
                        style: TextStyle(
                            fontFamily: 'Gilroy-SemiBold',
                            fontSize: FSTextStyle.h5size,
                            color: FsColor.basicprimary),
                      )),
                  Container(
                    child: Column(
                      children: [
                        _typeSelector(context: context, iplquiz: options[0]),
                        _typeSelector(context: context, iplquiz: options[1]),
                        _typeSelector(context: context, iplquiz: options[2]),
                        _typeSelector(context: context, iplquiz: options[3]),
                        SizedBox(height: 10),
                        _submitted
                            ? Container(
                                color: Colors.green,
                                width: double.infinity,
                                margin: EdgeInsets.only(top: 15),
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                    'Your answer is submitted successfully',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Gilroy-SemiBold',
                                        letterSpacing: 1,
                                        fontSize: FSTextStyle.h6size,
                                        color: FsColor.white)),
                              )
                            : OutlineButton(
                                onPressed: selectedType == null
                                    ? () {
                                        Toasly.error(context,
                                            "please select any option");
                                      }
                                    : () async {
                                        if (_submitted != null && _submitted) {
                                          Future.delayed(Duration(seconds: 2))
                                              .whenComplete(() async {
                                            widget.action(1);
                                          });
                                        } else {
                                          FsFacebookUtils.callCartClick(
                                              "ipl_participate_quiz_open_selected_${selectedAnswer['question_id']}",
                                              "option selected");
                                          await postTodaysQuiz(
                                                  widget.userid,
                                                  selectedAnswer['question_id'],
                                                  selectedAnswer['id'])
                                              .then((value) {
                                            if (value['status_code'] == 200) {
                                              setState(() {
                                                _submitted = true;
                                                submitText = 'Submitted';
                                              });
                                            }
                                            if (value['status_code'] == 403) {
                                              setState(() {
                                                submitText = 'Submitted';
                                                _submitted = true;
                                              });
                                            }
                                          });
                                          Future.delayed(Duration(seconds: 2))
                                              .whenComplete(() async {
                                            widget.action(1);
                                          });
                                        }
                                      },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                highlightElevation: 0,
                                borderSide: BorderSide(
                                    color:
                                        _submitted ? Colors.green : Colors.red),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  child: Text(
                                    submitText,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'How to participate in oneapps #GharSeT20Jeeto Contest:',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'Gilroy-SemiBold',
                          fontSize: FSTextStyle.h6size,
                          color: FsColor.darkgrey),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '1) ' +
                                'Predict the match winning team everyday & answer 1 simple quiz question. ',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Gilroy-Regular',
                                fontSize: FSTextStyle.h6size,
                                color: FsColor.darkgrey),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '2) ' +
                                'You will win 100 points per correct answer & 100 points per correct prediction for your submissions.',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Gilroy-Regular',
                                fontSize: FSTextStyle.h6size,
                                color: FsColor.darkgrey),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '3) ' +
                                'Keep an eye on the leader-board. Top 3 winners will get gift hamper every week.',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Gilroy-Regular',
                                fontSize: FSTextStyle.h6size,
                                color: FsColor.darkgrey),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '4) ' +
                                'Grand winners at the end to win a BIG SURPRIZE gift from oneapp.',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Gilroy-Regular',
                                fontSize: FSTextStyle.h6size,
                                color: FsColor.darkgrey),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          );
  }

  Widget _typeSelector({
    BuildContext context,
    Map iplquiz,
  }) {
    bool isActive = iplquiz['option'] == selectedType;
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: isActive
            ? _answerCheck
            ? FsColor.green
            : FsColor.red
            : null,
        // border: Border.all(width:1,
        //   color: isActive ? FsColor.primarymeeting : FsColor.darkgrey,
        // ),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: RadioListTile(
        dense: true,
        activeColor: FsColor.white,
        groupValue: selectedType,
        value: iplquiz['option'].toString(),
        onChanged: _submitted && !isActive
            ? null
            : (String v) {
          setState(() {
            selectedType = v;
            selectedAnswer = iplquiz;
          });
        },
        title: Text(
          iplquiz['option'],
          style: TextStyle(
              fontSize: FSTextStyle.h6size,
              letterSpacing: 1,
              color: isActive ? FsColor.white : null,
              fontFamily: 'Gilroy-SemiBold'),
        ),
        secondary: isActive
            ? Container(
          child: _answerCheck
              ? Icon(
            Icons.check,
            color: FsColor.white,
          )
              : Icon(
            Icons.clear,
            color: FsColor.white,
          ),
        )
            : null,
      ),
    );
  }
}
