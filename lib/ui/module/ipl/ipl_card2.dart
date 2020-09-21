/*
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/ipl/api_call.dart';
import 'package:sso_futurescape/ui/module/ipl/ipl_main.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';
import 'package:common_config/utils/toast/toast.dart';
class IplCard2 extends StatefulWidget {
  String profileurl;

  IplCard2({this.profileurl});

  @override
  _IplCardState createState() => new _IplCardState();
}

class UserProfile {
  final String firstname, lastname, email, mobile;
  final int userid;

  UserProfile(
      {this.email, this.firstname, this.lastname, this.mobile, this.userid});
}

class _IplCardState extends State<IplCard2> {
  Timer timer;

  bool _notBatYet = true,
      _notbatyet1 = true,
      _notBatYet2 = true,
      _notbatyet12 = true,
      secondmatch = false;
  bool matchstart = false;
  List<UserProfile> userprofile = [];
  List teams = [];
  List livescores = [];
  String team1 = 'N/A', team2 = 'N/A';
  String secondteam1 = 'N/A', secondteam2 = 'N/A';
  int team1score = 0,
      team2score = 0,
      team1wickets = 0,
      team2wickets = 0,
      team1overs = 0;
  double team2overs = 0.0;
  int secondteam1score = 0,
      secondteam2score = 0,
      secondteam1wickets = 0,
      secondteam2wickets = 0,
      secondteam1overs = 0;
  double secondteam2overs = 0.0;

  Future getUser() async {
    await SsoStorage.getUserProfile().then((value) {
      userprofile.add(UserProfile(
        email: value['email'],
        firstname: value['first_name'],
        lastname: value['last_name'],
        mobile: value['mobile'],
        userid: value['user_id'],
      ));
    });
    if (userprofile[0].userid != null) {
      await fetchIplMainCardData(userprofile[0].userid).then((value) {
        if (value != null) {
          if (mounted) {
            setState(() {
              if (value['data']['teams'] != null) {
                teams = value['data']['teams'];
                team1 = value['data']['teams'][0]['team1_abbr'];
                team2 = value['data']['teams'][0]['team2_abbr'];
                if (value['data']['teams'].length>1) {
                  secondteam1 = value['data']['teams'][1]['team1_abbr'];
                  secondteam2 = value['data']['teams'][1]['team2_abbr'];
                }
              }

              if (value['data']['live_score'] != null) {
                matchstart = true;
                livescores = value['data']['live_score'];
                if (value['data']['live_score'][0]['localteam']['score']['score'] != null) {
                  _notBatYet = false;
                  team1score = value['data']['live_score'][0]['localteam']
                      ['score']['score'];
                  team1wickets = value['data']['live_score'][0]['localteam']
                      ['score']['wickets'];
                  team1overs = value['data']['live_score'][0]['localteam']
                      ['score']['overs'];
                }
                if (value['data']['live_score'][0]['visitorteam']['score']['score'] != null) {
                  _notbatyet1 = false;
                  team2score = value['data']['live_score'][0]['visitorteam']
                      ['score']['score'];
                  team2wickets = value['data']['live_score'][0]['visitorteam']
                      ['score']['wickets'];
                  team2overs = value['data']['live_score'][0]['visitorteam']
                      ['score']['overs'];
                }
                if (livescores.length == 2) {
                  secondmatch = true;
                  if (value['data']['live_score'][1]['localteam']['score']
                          ['score'] !=
                      null) {
                    _notBatYet2 = false;
                    team1score = value['data']['live_score'][1]['localteam']
                        ['score']['score'];
                    team1wickets = value['data']['live_score'][1]['localteam']
                        ['score']['wickets'];
                    team1overs = value['data']['live_score'][1]['localteam']
                        ['score']['overs'];
                  }
                  if (value['data']['live_score'][1]['visitorteam']['score']
                          ['score'] !=
                      null) {
                    _notbatyet12 = false;
                    team2score = value['data']['live_score'][1]['visitorteam']
                        ['score']['score'];
                    team2wickets = value['data']['live_score'][1]['visitorteam']
                        ['score']['wickets'];
                    team2overs = value['data']['live_score'][1]['visitorteam']
                        ['score']['overs'];
                  }
                }
              }
            });
          }
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 15), (Timer t) {
      Toasly.success(context, "15 sec");
      getUser();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    return GestureDetector(
      onTap: () {
        if (userprofile != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => IplMain(
                userprofile: userprofile,
              ),
            ),
          );
        }
      },
      child: Container(
        child: Card(
          elevation: 2.0,
          key: null,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "GharSeT20Jeeto",
                                style: TextStyle(
                                    fontSize: FSTextStyle.dashtitlesize,
                                    fontFamily: 'Gilroy-SemiBold',
                                    color: FsColor.primaryipl),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Participate & Win Prizes'.toLowerCase(),
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-Regular',
                                  color: FsColor.darkgrey),
                            ),
                            SizedBox(height: 5),
                            Container(
                              child: RaisedButton(
                                elevation: 1.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => IplMain(
                                      userprofile: userprofile,
                                    ),
                                  ),
                                ),
                                color: FsColor.primaryipl,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                child: Text(
                                  "Participate",
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      fontFamily: 'Gilroy-Bold',
                                      color: FsColor.white),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Image.asset("images/dash13.png",
                            height: 90, width: 90, fit: BoxFit.fitHeight),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                  width: double.infinity,
                  child: Divider(
                      color: FsColor.darkgrey.withOpacity(0.2), height: 2.0),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        color: FsColor.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: Text(
                                team1.toUpperCase(),
                                style: TextStyle(
                                    fontSize: FSTextStyle.h4size,
                                    fontFamily: 'Gilroy-SemiBold',
                                    color: FsColor.primaryipl),
                              ),
                            ),
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: FsColor.darkgrey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'VS',
                                style: TextStyle(
                                    fontSize: FSTextStyle.h7size,
                                    fontFamily: 'Gilroy-SemiBold',
                                    color: FsColor.darkgrey),
                              ),
                            ),
                            Container(
                              child: Text(
                                team2.toUpperCase(),
                                style: TextStyle(
                                    fontSize: FSTextStyle.h4size,
                                    fontFamily: 'Gilroy-SemiBold',
                                    color: FsColor.primaryipl),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Expanded(
                //       child: OutlineButton(
                //         borderSide: BorderSide(width: 2, color: FsColor.primaryipl),
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(4.0),
                //         ),
                //         onPressed: () => {
                //           Navigator.push(context,
                //           MaterialPageRoute(builder: (context) => IplMain()),
                //           ),
                //         },
                //         color: FsColor.primaryipl,
                //         padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                //         child: Text(
                //           "Leaderboard",
                //           style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-Bold', color: FsColor.primaryipl),
                //         ),
                //       ),
                //     ),
                //     SizedBox(width: 10),
                //     Expanded(
                //       child: OutlineButton(
                //         borderSide: BorderSide(width: 2, color: FsColor.primaryipl),
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(4.0),
                //         ),
                //         onPressed: () => {
                //           Navigator.push(context,
                //           MaterialPageRoute(builder: (context) => IplMain()),
                //           ),
                //         },
                //         color: FsColor.primaryipl,
                //         padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                //         child: Text(
                //           "Participate Quiz",
                //           style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-Bold', color: FsColor.primaryipl),
                //         ),
                //       ),
                //     ),

                //   ],
                // ),

                SizedBox(
                  height: 10.0,
                ),
                matchstart
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _notBatYet
                              ? Container(
                                  child: Text(
                                    'Yet to Bat'.toLowerCase(),
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        fontFamily: 'Gilroy-SemiBold',
                                        letterSpacing: 1,
                                        color: FsColor.darkgrey),
                                  ),
                                )
                              : Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        team1score.toString() +
                                            '/' +
                                            team1wickets.toString(),
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h2size,
                                            fontFamily: 'Gilroy-Bold',
                                            letterSpacing: 1,
                                            color: FsColor.basicprimary),
                                      ),
                                      Text(
                                        'overs: ' + team1overs.toString(),
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-Regular',
                                            letterSpacing: 1,
                                            color: FsColor.lightgrey),
                                      ),
                                    ],
                                  ),
                                ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 7,
                          ),
                          _notbatyet1
                              ? Container(
                                  child: Text(
                                    'Yet to Bat'.toLowerCase(),
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        fontFamily: 'Gilroy-SemiBold',
                                        letterSpacing: 1,
                                        color: FsColor.darkgrey),
                                  ),
                                )
                              : Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        team2score.toString() +
                                            '/' +
                                            team2wickets.toString(),
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h2size,
                                            fontFamily: 'Gilroy-Bold',
                                            letterSpacing: 1,
                                            color: FsColor.basicprimary),
                                      ),
                                      Text(
                                        'overs: ' + team2overs.toString(),
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-Regular',
                                            letterSpacing: 1,
                                            color: FsColor.lightgrey),
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Container(
                          child: Text(
                            'Match is not yet Started'.toLowerCase(),
                            style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                fontFamily: 'Gilroy-SemiBold',
                                letterSpacing: 1,
                                color: FsColor.darkgrey),
                          ),
                        ),
                      ),
                SizedBox(
                  height: 10,
                ),
                secondmatch
                    ? Container(
                        child: Column(
                          children: [
                            Container(
                              color: FsColor.white,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    child: Text(
                                      secondteam1.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h4size,
                                          fontFamily: 'Gilroy-SemiBold',
                                          color: FsColor.primaryipl),
                                    ),
                                  ),
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: FsColor.darkgrey.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'VS',
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h7size,
                                          fontFamily: 'Gilroy-SemiBold',
                                          color: FsColor.darkgrey),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      secondteam2.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h4size,
                                          fontFamily: 'Gilroy-SemiBold',
                                          color: FsColor.primaryipl),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                secondmatch
                    ? matchstart
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _notBatYet2
                                  ? Container(
                                      child: Text(
                                        'Yet to Bat'.toLowerCase(),
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-SemiBold',
                                            letterSpacing: 1,
                                            color: FsColor.darkgrey),
                                      ),
                                    )
                                  : Container(
                                      child: Column(
                                        children: [
                                          Text(
                                            team1score.toString() +
                                                '/' +
                                                team1wickets.toString(),
                                            style: TextStyle(
                                                fontSize: FSTextStyle.h2size,
                                                fontFamily: 'Gilroy-Bold',
                                                letterSpacing: 1,
                                                color: FsColor.basicprimary),
                                          ),
                                          Text(
                                            'overs: ' + team1overs.toString(),
                                            style: TextStyle(
                                                fontSize: FSTextStyle.h6size,
                                                fontFamily: 'Gilroy-Regular',
                                                letterSpacing: 1,
                                                color: FsColor.lightgrey),
                                          ),
                                        ],
                                      ),
                                    ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 7,
                              ),
                              _notbatyet12
                                  ? Container(
                                      child: Text(
                                        'Yet to Bat'.toLowerCase(),
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-SemiBold',
                                            letterSpacing: 1,
                                            color: FsColor.darkgrey),
                                      ),
                                    )
                                  : Container(
                                      child: Column(
                                        children: [
                                          Text(
                                            team2score.toString() +
                                                '/' +
                                                team2wickets.toString(),
                                            style: TextStyle(
                                                fontSize: FSTextStyle.h2size,
                                                fontFamily: 'Gilroy-Bold',
                                                letterSpacing: 1,
                                                color: FsColor.basicprimary),
                                          ),
                                          Text(
                                            'overs: ' + team2overs.toString(),
                                            style: TextStyle(
                                                fontSize: FSTextStyle.h6size,
                                                fontFamily: 'Gilroy-Regular',
                                                letterSpacing: 1,
                                                color: FsColor.lightgrey),
                                          ),
                                        ],
                                      ),
                                    ),
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Container(
                              child: Text(
                                'Match is not yet Started'.toLowerCase(),
                                style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    fontFamily: 'Gilroy-SemiBold',
                                    letterSpacing: 1,
                                    color: FsColor.darkgrey),
                              ),
                            ),
                          )
                    : Container(),
              ],
            ),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        alignment: Alignment.center,
      ),
    );
  }

  open() async {
    if (userprofile[0].userid != null) {
      await fetchIplMainCardData(userprofile[0].userid).then((value) {
        if (value != null) {
          if (mounted) {
            setState(() {
              print(value['data']);
              if (value['data']['teams'] != null) {
                teams = value['data']['teams'];
                team1 = value['data']['teams'][0]['team1_abbr'];
                team2 = value['data']['teams'][0]['team2_abbr'];
              }
              if (value['data']['live_score'] != null) {
                matchstart = true;
                livescores = value['data']['live_score'];
                if (value['data']['live_score']!=null&&value['data']['live_score'][0]['localteam']['score']
                        ['score'] !=
                    null) {
                  _notBatYet = false;
                  team1score = value['data']['live_score'][0]['localteam']
                      ['score']['score'];
                  team1wickets = value['data']['live_score'][0]['localteam']
                      ['score']['wickets'];
                  team1overs = value['data']['live_score'][0]['localteam']
                      ['score']['overs'];
                }
                if (value['data']['live_score'][0]['visitorteam']['score']
                        ['score'] !=
                    null) {
                  _notbatyet1 = false;
                  team2score = value['data']['live_score'][0]['visitorteam']
                      ['score']['score'];
                  team2wickets = value['data']['live_score'][0]['visitorteam']
                      ['score']['wickets'];
                  team2overs = value['data']['live_score'][0]['visitorteam']
                      ['score']['overs'];
                }
                if (livescores.length == 2) {
                  if (teams.length != null) {
                    secondteam1 = value['data']['teams'][1]['team1_abbr'];
                    secondteam2 = value['data']['teams'][1]['team2_abbr'];
                  }
                  secondmatch = true;
                  if (value['data']['live_score'][1]['localteam']['score']
                          ['score'] !=
                      null) {
                    _notBatYet2 = false;
                    team1score = value['data']['live_score'][1]['localteam']
                        ['score']['score'];
                    team1wickets = value['data']['live_score'][1]['localteam']
                        ['score']['wickets'];
                    team1overs = value['data']['live_score'][1]['localteam']
                        ['score']['overs'];
                  }
                  if (value['data']['live_score'][1]['visitorteam']['score']
                          ['score'] !=
                      null) {
                    _notbatyet12 = false;
                    team2score = value['data']['live_score'][1]['visitorteam']
                        ['score']['score'];
                    team2wickets = value['data']['live_score'][1]['visitorteam']
                        ['score']['wickets'];
                    team2overs = value['data']['live_score'][1]['visitorteam']
                        ['score']['overs'];
                  }
                }
              }
            });
          }
        }
      });
    }
  }
}
*/
