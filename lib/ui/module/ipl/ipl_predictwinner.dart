import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/ipl/api_call.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/utils/facebook_utils.dart';

class IplPredictWinner extends StatefulWidget {
  int userid;
  Function action;

  IplPredictWinner({this.userid, this.action});

  @override
  _IplPredictWinnerState createState() => new _IplPredictWinnerState();
}

class _IplPredictWinnerState extends State<IplPredictWinner> {
  String selectedMatch1 = "";
  String selectedMatch2 = "";
  Map selectedAnswer1 = {};
  Map selectedAnswer2 = {};
  String selectbtn1 = 'Submit', selectbtn2 = 'Submit';
  List _match = [];
  bool loading = false, _submitted1 = false, _submitted2 = false;
  int questionid1, questionid2;

  Future fetchdata() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    await fetchTeamQuiz(widget.userid).then((value) {
      if (value != null) {
        if (mounted) {
          setState(() {
            _match = value['data'];
            /*print("_match_match_match_match_match_match_match_match");
            print(_match);*/
            if (_match.length == 2) {
              questionid1 = _match[0]['id'];
              questionid2 = _match[1]['id'];
            }
            if (_match.length > 0) {
              questionid1 = _match[0]['id'];
              _submitted1 = _match[0]['answered'].toString() == "1";
              if (_submitted1) {
                selectbtn1 = 'Submitted';
                List teams = _match[0]["teams"];
                for (int i = 0; i < teams.length; i++) {
                  if (teams[i]["id"] == _match[0]["guess_team"])
                    selectedMatch1 = teams[i]["name"];
                  selectedAnswer1 = teams[i];
                }
              }
              if (_match.length > 1) {
                _submitted2 = _match[1]['answered'].toString() == "1";
                if (_submitted2) {
                  selectbtn2 = 'Submitted';
                  List teams = _match[1]["teams"];
                  for (int i = 0; i < teams.length; i++) {
                    if (teams[i]["id"] == _match[1]["guess_team"])
                      selectedMatch2 = teams[i]['name'];
                    selectedAnswer2 = teams[i];
                  }
                }
              }
            }

            /*if (prefs.getBool('_submitted1') != null) {
              if (prefs.getBool('_submitted1')) {
                _submitted1 = true;
              }
            }
            if (prefs.getString('selectbtn1') != null) {
              selectedMatch1 = prefs.getString('selectbtn1');
              selectbtn1 = 'Submitted';
            }*/
            /*if (prefs.getBool('_submitted2') != null) {
              if (prefs.getBool('_submitted2')) {
                _submitted2 = true;
              }
            }
            if (prefs.getString('selectbtn2') != null) {
              selectedMatch2 = prefs.getString('selectbtn2');
              selectbtn2 = 'Submitted';
            }*/
            loading = false;
          });
        }
      }
    });
  }

  @override
  void initState() {
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
            title: '',
          )
        : _match.length == 0
            ? Text("No Record found!")
            : _match.length == 1
                ? SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                            // padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: FsColor.primaryipl.withOpacity(0.1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(4.0),
                              ),
                              border: Border.all(
                                width: 1.0,
                                color: FsColor.primaryipl.withOpacity(0.5),
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: FsColor.primaryipl.withOpacity(0.1),
                                    // borderRadius: BorderRadius.all(Radius.circular(4.0),),
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 1.0,
                                        color:
                                            FsColor.primaryipl.withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    'Match 1'.toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Gilroy-SemiBold',
                                        fontSize: FSTextStyle.h5size,
                                        color: FsColor.primaryipl),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  // margin: EdgeInsets.only(bottom: 15),
                                  width: double.infinity,
                                  child: Center(
                                    child: Text(
                                      _match[0]['question_text'],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontFamily: 'Gilroy-Regular',
                                          fontSize: FSTextStyle.h4size,
                                          color: FsColor.basicprimary),
                                    ),
                                  ),
                                ),
                                Container(
                                  color: FsColor.white,
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      _match1Selector(
                                          context: context,
                                          iplquiz: _match[0]['teams'][0]),
                                      SizedBox(height: 5),
                                      _match1Selector(
                                          context: context,
                                          iplquiz: _match[0]['teams'][1]),
                                    ],
                                  ),
                                ),
                                _submitted1
                                    ? Container(
                                        color: Colors.green,
                                        padding:
                                            EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        width: double.infinity,
                                        child: Text(
                                            'Your vote is submitted successfully',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Gilroy-SemiBold',
                                                letterSpacing: 1,
                                                fontSize: FSTextStyle.h6size,
                                                color: FsColor.white)),
                                      )
                                    : OutlineButton(
                                        onPressed: () async {
                                          //SharedPreferences prefs = await SharedPreferences.getInstance();
                                          /* await prefs.setBool('_submitted1', true);
                                    await prefs.setString(
                                        'selectbtn1', selectedMatch1);*/
                                          FsFacebookUtils.callCartClick(
                                              "ipl_predict_winner_${questionid1}",
                                              "predict winner");
                                          await postTeamQuiz(
                                                  widget.userid,
                                                  questionid1,
                                                  selectedAnswer1['id'])
                                              .then((value) {
                                            if (value['status_code'] == 200) {
                                              setState(() {
                                                _submitted1 = true;
                                                selectbtn1 = 'Submitted';
                                              });
                                            }
                                            if (value['status_code'] == 403) {
                                              setState(() {
                                                selectbtn1 = 'Submitted';
                                                _submitted1 = true;
                                              });
                                            }
                                          });
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        highlightElevation: 0,
                                        borderSide: BorderSide(
                                            color: _submitted1
                                                ? Colors.green
                                                : Colors.red),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 10, 20, 10),
                                          child: Text(
                                            selectbtn1,
                                            style: TextStyle(
                                                fontFamily: 'Gilroy-Regular',
                                                fontSize: FSTextStyle.h4size,
                                                color: FsColor.basicprimary),
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
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                            // padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: FsColor.primaryipl.withOpacity(0.1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(4.0),
                              ),
                              border: Border.all(
                                width: 1.0,
                                color: FsColor.primaryipl.withOpacity(0.5),
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: FsColor.primaryipl.withOpacity(0.1),
                                    // borderRadius: BorderRadius.all(Radius.circular(4.0),),
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 1.0,
                                        color:
                                            FsColor.primaryipl.withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    'Match 1'.toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Gilroy-SemiBold',
                                        fontSize: FSTextStyle.h5size,
                                        color: FsColor.primaryipl),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  // margin: EdgeInsets.only(bottom: 15),
                                  width: double.infinity,
                                  child: Center(
                                    child: Text(
                                      _match[0]['question_text'],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontFamily: 'Gilroy-Regular',
                                          fontSize: FSTextStyle.h4size,
                                          color: FsColor.basicprimary),
                                    ),
                                  ),
                                ),
                                Container(
                                  color: FsColor.white,
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      _match1Selector(
                                          context: context,
                                          iplquiz: _match[0]['teams'][0]),
                                      SizedBox(height: 5),
                                      _match1Selector(
                                          context: context,
                                          iplquiz: _match[0]['teams'][1]),
                                    ],
                                  ),
                                ),
                                _submitted1
                                    ? Container(
                                        color: Colors.green,
                                        padding:
                                            EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        width: double.infinity,
                                        child: Text(
                                            'Your vote is submitted successfully',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Gilroy-SemiBold',
                                                letterSpacing: 1,
                                                fontSize: FSTextStyle.h6size,
                                                color: FsColor.white)),
                                      )
                                    : OutlineButton(
                                        onPressed: selectedAnswer1 == null
                                            ? () {
                                                Toasly.error(context,
                                                    "please select any option");
                                              }
                                            : () async {
                                          //   SharedPreferences prefs = await SharedPreferences.getInstance();
                                          /*await prefs.setBool('_submitted1', true);
                                    await prefs.setString(
                                        'selectbtn1', selectedMatch1);*/
                                          FsFacebookUtils.callCartClick(
                                              "ipl_predict_winner_${questionid1}",
                                              "predict winner");
                                          await postTeamQuiz(
                                              widget.userid,
                                              questionid1,
                                              selectedAnswer1['id'])
                                              .then((value) {
                                            if (value['status_code'] ==
                                                200) {
                                              setState(() {
                                                _submitted1 = true;
                                                selectbtn1 = 'Submitted';
                                              });
                                            }
                                            if (value['status_code'] ==
                                                403) {
                                              setState(() {
                                                selectbtn1 = 'Submitted';
                                                _submitted1 = true;
                                              });
                                            }
                                          });
                                              },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        highlightElevation: 0,
                                        borderSide: BorderSide(
                                            color: _submitted1
                                                ? Colors.green
                                                : Colors.red),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 10, 20, 10),
                                          child: Text(
                                            selectbtn1,
                                            style: TextStyle(
                                                fontFamily: 'Gilroy-Regular',
                                                fontSize: FSTextStyle.h4size,
                                                color: FsColor.basicprimary),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                            // padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: FsColor.primaryipl.withOpacity(0.1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(4.0),
                              ),
                              border: Border.all(
                                width: 1.0,
                                color: FsColor.primaryipl.withOpacity(0.5),
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: FsColor.primaryipl.withOpacity(0.1),
                                    // borderRadius: BorderRadius.all(Radius.circular(4.0),),
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 1.0,
                                        color:
                                            FsColor.primaryipl.withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    'Match 2'.toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Gilroy-SemiBold',
                                        fontSize: FSTextStyle.h5size,
                                        color: FsColor.primaryipl),
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.all(10),
                                    // margin: EdgeInsets.only(bottom: 15),
                                    width: double.infinity,
                                    child: Center(
                                      child: Text(
                                        _match[1]['question_text'],
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily: 'Gilroy-Regular',
                                            fontSize: FSTextStyle.h4size,
                                            color: FsColor.basicprimary),
                                      ),
                                    )),
                                Container(
                                  color: FsColor.white,
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      _match2Selector(
                                          context: context,
                                          iplquiz: _match[1]['teams'][0]),
                                      SizedBox(height: 5),
                                      _match2Selector(
                                          context: context,
                                          iplquiz: _match[1]['teams'][1]),
                                    ],
                                  ),
                                ),
                                _submitted2
                                    ? Container(
                                        color: Colors.green,
                                        padding:
                                            EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        width: double.infinity,
                                        child: Text(
                                            'Your vote is submitted successfully',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Gilroy-SemiBold',
                                                letterSpacing: 1,
                                                fontSize: FSTextStyle.h6size,
                                                color: FsColor.white)),
                                      )
                                    : OutlineButton(
                                        onPressed: selectedAnswer2 == null
                                            ? () {
                                                Toasly.error(context,
                                                    "please select any option");
                                              }
                                            : () async {
                                          FsFacebookUtils.callCartClick(
                                              "ipl_predict_winner_${questionid2}",
                                              "predict winner");
                                          //              SharedPreferences prefs = await SharedPreferences.getInstance();
                                          if (_submitted2 != null &&
                                              _submitted2) {
                                            if (_submitted2) {
                                              Future.delayed(Duration(
                                                  seconds: 2))
                                                  .whenComplete(() async {
                                                widget.action(1);
                                              });
                                            }
                                          } else {
                                            /* await prefs.setBool('_submitted2', true);
                                      await prefs.setString(
                                          'selectbtn2', selectedMatch2);*/
                                            await postTeamQuiz(
                                                widget.userid,
                                                questionid2,
                                                selectedAnswer2['id'])
                                                .then((value) {
                                              if (value['status_code'] ==
                                                  200) {
                                                setState(() {
                                                  _submitted2 = true;
                                                  selectbtn2 =
                                                  'Submitted';
                                                });
                                              }
                                              if (value['status_code'] ==
                                                  403) {
                                                setState(() {
                                                  selectbtn2 =
                                                  'Submitted';
                                                  _submitted2 = true;
                                                });
                                              }
                                            });
                                            Future.delayed(
                                                Duration(seconds: 2))
                                                .whenComplete(() async {
                                              widget.action(1);
                                            });
                                          }
                                              },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        highlightElevation: 0,
                                        borderSide: BorderSide(
                                            color: _submitted2
                                                ? Colors.green
                                                : Colors.red),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 10, 20, 10),
                                          child: Text(
                                            selectbtn2,
                                            style: TextStyle(
                                                fontFamily: 'Gilroy-Regular',
                                                fontSize: FSTextStyle.h4size,
                                                color: FsColor.basicprimary),
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

  Widget _match1Selector({
    BuildContext context,
    Map iplquiz,
  }) {
    bool isActive = iplquiz['name'] == selectedMatch1;
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: isActive ? FsColor.green : null,

        // border: Border.all(width:1,
        //   color: isActive ? FsColor.primarymeeting : FsColor.darkgrey,
        // ),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: RadioListTile(
        dense: true,
        value: iplquiz['name'].toString(),
        activeColor: FsColor.white,
        groupValue: selectedMatch1,
        onChanged: _submitted1 && !isActive
            ? null
            : (String v) {
          setState(() {
            selectedMatch1 = v;
            selectedAnswer1 = iplquiz;
          });
        },
        title: Text(
          iplquiz['name'],
          style: TextStyle(
              fontSize: FSTextStyle.h6size,
              letterSpacing: 1,
              color: isActive ? FsColor.white : null,
              fontFamily: 'Gilroy-SemiBold'),
        ),
        /*secondary: isActive
              ? Container(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'voted',
                      style: TextStyle(
                          fontSize: FSTextStyle.h7size,
                          letterSpacing: 1,
                          color: isActive ? FsColor.white : null,
                          fontFamily: 'Gilroy-SemiBold'),
                    ),
                    Text(
                      '252',
                      style: TextStyle(
                          fontSize: FSTextStyle.h5size,
                          letterSpacing: 1,
                          color: isActive ? FsColor.white : null,
                          fontFamily: 'Gilroy-SemiBold'),
                    ),
                  ],
                ))
              : null*/
      ),
    );
  }

  Widget _match2Selector({
    BuildContext context,
    Map iplquiz,
  }) {
    bool isActive = iplquiz['name'] == selectedMatch2;
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: isActive ? FsColor.green : null,

        // border: Border.all(width:1,
        //   color: isActive ? FsColor.primarymeeting : FsColor.darkgrey,
        // ),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: RadioListTile(
        dense: true,
        value: iplquiz['name'].toString(),
        activeColor: FsColor.white,
        groupValue: selectedMatch2,
        onChanged: _submitted2 && !isActive
            ? null
            : (String v) {
          setState(() {
            selectedMatch2 = v;
            selectedAnswer2 = iplquiz;
          });
        },
        title: Text(
          iplquiz['name'],
          style: TextStyle(
              fontSize: FSTextStyle.h6size,
              letterSpacing: 1,
              color: isActive ? FsColor.white : null,
              fontFamily: 'Gilroy-SemiBold'),
        ),
        /*secondary: isActive
              ? Container(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'voted',
                      style: TextStyle(
                          fontSize: FSTextStyle.h7size,
                          letterSpacing: 1,
                          color: isActive ? FsColor.white : null,
                          fontFamily: 'Gilroy-SemiBold'),
                    ),
                    Text(
                      '252',
                      style: TextStyle(
                          fontSize: FSTextStyle.h5size,
                          letterSpacing: 1,
                          color: isActive ? FsColor.white : null,
                          fontFamily: 'Gilroy-SemiBold'),
                    ),
                  ],
                ))
              : null*/
      ),
    );
  }
}
