import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/presentor/module/sso/complex_list/complex_presenter.dart';
import 'package:sso_futurescape/presentor/module/sso/complex_list/complex_view.dart';
import 'package:sso_futurescape/ui/module/sso/complex_list/request_complex.dart';
import 'package:sso_futurescape/ui/module/sso/unit_building_setup/building.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/ui/widgets/update_profile_dialog.dart';
import 'package:sso_futurescape/utils/app_constant.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/logger.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

// import 'unitbuildingsetup.dart';

class ComplexList extends StatefulWidget {
//  String _callingType;

//  ComplexList(String callingType) {
//    _callingType = callingType;
//  }

  @override
  _ComplexListState createState() => _ComplexListState();
}

class _ComplexListState extends State<ComplexList> implements ComplexView {
  final TextEditingController _searchControl = new TextEditingController();

  ComplexPresenter _complexPresenter;

//  String _callingType;


  bool fillDetails = false;

  String _notFoundComplex = FsString.NOT_FOUND_COMPLEX;

//  _ComplexListState(String callingType) {
////    _callingType = callingType;
//  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _complexPresenter = new ComplexPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: FsColor.primaryflat,
        elevation: 0.0,
        title: new Text(
          'add new flat',
          style: FSTextStyle.appbartextlight,
        ),
        leading: FsBackButtonlight(),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
            child: Text(
              "search with your pincode or complex name",
              style: TextStyle(
                fontSize: FSTextStyle.h5size,
                fontFamily: 'Gilroy-SemiBold',
                color: FsColor.darkgrey,
                height: 1.2,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey[50],
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: TextField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: FsColor.darkgrey,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: "e.g: pincode/complex name",
                  prefixIcon: Icon(
                    FlutterIcon.building,
                    color: Colors.blueGrey[300],
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.blueGrey[300],
                  ),
                ),
                maxLines: 1,
                controller: _searchControl,
                onChanged: (text) => {searchComplex(text)},
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: ListView.builder(
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: complex == null ? 0 : complex.length,
              itemBuilder: (BuildContext context, int index) {
                Map place = complex[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: InkWell(
                    child: Container(
                      padding: const EdgeInsets.only(
                        bottom: 5.0,
                        top: 5.0,
                      ),
                      // height: 85,
                      child: Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              "images/complex.png",
                              height: 48,
                              width: 48,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 15),
                          Container(
                            alignment: Alignment.center,
                            // height: 80,
                            width: MediaQuery.of(context).size.width - 100,
                            child: ListView(
                              primary: false,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                      text: TextSpan(
                                          style:
                                          Theme
                                              .of(context)
                                              .textTheme
                                              .body1,
                                          children: [
                                            TextSpan(
                                              text: '${place["company_name"]}',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-SemiBold',
                                                fontSize: FSTextStyle.h6size,
                                                color: FsColor.basicprimary,
                                              ),
                                            ),
                                          ])),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.location_on,
                                      size: 13,
                                      color: FsColor.lightgrey,
                                    ),
                                    SizedBox(width: 2),
                                    Expanded(
                                      child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${AppUtils.mergeAddress(place)}",
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-SemiBold',
                                          fontSize: 13,
                                          color: FsColor.lightgrey,
                                        ),
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),

                                    )
                                    
                                  ],
                                ),

                                SizedBox(height: 5.0),
                                // complexjoincondition(place),
                                Row(
                                  children: <Widget>[
                                    Text(
                                        getSubscription(place)
                                            ? 'Connect'
                                            : "Not subscribed",
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-SemiBold',
                                            color: getSubscription(place)
                                                ? FsColor.primaryflat
                                                : FsColor.red)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      clickComplex(place, context);
                      ;
                    },
                  ),
                );
              },
            ),
          ),
          !fillDetails ? Container() :
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
            child: Text(
                _notFoundComplex,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: FSTextStyle.h6size,
                    color: FsColor.lightgrey,
                    fontFamily: 'Gilroy-SemiBold')),
          ),
          !fillDetails ? Container() :
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
            child: GestureDetector(
              child: RaisedButton(
                child: Text('Fill Details',
                    style: TextStyle(
                        fontSize: FSTextStyle.h6size,
                        fontFamily: 'Gilroy-SemiBold')),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(4.0),
                ),
                color: FsColor.primaryflat,
                textColor: FsColor.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RequestComplexPage()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void clickComplex(Map place, BuildContext context) {
    getSubscription(place)
        ? _checkForProfile(place)
        : Toasly.error(
        context, "Not subscribed");
  }

  var _complex;

  void _checkForProfile(place) {
    _complex = place;
    SsoStorage.getUserProfile().then((profile) {
      var _userProfiew = profile;

      bool isUnNotSet = false;
      if (_userProfiew["first_name"] == null ||
          _userProfiew["first_name"]
              .toString()
              .length <= 0) {
        isUnNotSet = true;
      }
      bool isEmailSet = false;
      if ((_userProfiew["email"] == null ||
          _userProfiew["email"]
              .toString()
              .length <= 0)) {
        isEmailSet = true;
      }
      if (isUnNotSet || isEmailSet) {
        UpdateProfileDialog(context, onUpdateProfile,
            name: isUnNotSet, email: isEmailSet);
      } else {
        setState(() {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return BuildingPage(place);
              },
            ),
          );
        });
      }
    });
  }

  onUpdateProfile() {
//    Navigator.of(context).pushNamed('/collections');
    /*  FocusScope.of(context).requestFocus(FocusNode());
    print("----------------------------_complex--------------------------$_complex");
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return BuildingPage(_complex);
        },
      ),
    );
*/
    Toasly.success(context, "Successfully updated");
    print(
        "--------------------------------onUpdateProfile---------------------------");
//    setState(() {
//      SsoStorage.getUserProfile().then((profile) {
//
//      });
//    });
  }

  List complex;

  @override
  onComplexFound(var complex1) {
    Logger.log(complex1);
    int _appAccess = 0;
    try {
      setState(() {
        complex = complex1["data"]["results"];
        if (complex == null) {
          complex = [];
        }

        for (int i = 0; i < complex.length; i++) {
          print(
              "----------------------------------------------------------------------------");
          List _comappaccess = complex[i]["comappaccess"];
          for (int j = 0;
          _comappaccess != null && j < _comappaccess.length;
          j++) {
            /*if (*/ /*_callingType == AppConstant.VIZLOG &&*/ /*
                _comappaccess[j]["app_id"] ==
                    Environment()
                        .getCurrentConfig()
                        .vizlog_app_id &&
                    _comappaccess[j]["app_id"] ==
                        Environment()
                            .getCurrentConfig()
                            .chsone_app_id
            ) {
              complex[i]["subscribed"] = "yes";
              _appAccess=AppConstant.BOTH;
            }else*/
            if (/*_callingType == AppConstant.CHSONE &&*/
            _comappaccess[j]["app_id"].toString() ==
                Environment()
                    .getCurrentConfig()
                    .chsoneAppId
                    .toString()) {
              complex[i]["subscribed"] = "yes";
              if (_appAccess == AppConstant.VIZLOG_ACCESS) {
                _appAccess = AppConstant.BOTH;
                complex[i]["app_access"] = AppConstant.BOTH;
                break;
              } else {
                _appAccess = AppConstant.CHSONE_ACCESS;
                complex[i]["app_access"] = AppConstant.CHSONE_ACCESS;
              }
            } else if (/*_callingType == AppConstant.CHSONE &&*/
            _comappaccess[j]["app_id"].toString() ==
                Environment()
                    .getCurrentConfig()
                    .vizlogAppId
                    .toString()) {
              complex[i]["subscribed"] = "yes";
              if (_appAccess == AppConstant.CHSONE_ACCESS) {
                _appAccess = AppConstant.BOTH;
                complex[i]["app_access"] = AppConstant.BOTH;
                break;
              } else {
                _appAccess = AppConstant.VIZLOG_ACCESS;
                complex[i]["app_access"] = AppConstant.VIZLOG_ACCESS;


              }
//              _appAccess=AppConstant.VIZLOG_ACCESS;

            }
          }
//          print(_comappaccess);
//          print(_appAccess);
        }

//        print(complex);
//        print(complexr.rlength);
      });
    } catch (e, s) {
//      print("ssssssssssssss $s");
    }
  }

  @override
  onError(var error) {
    clearList();
  }

  @override
  onFailure(var failed) {
    clearList();
  }

  searchComplex(String text) {
    Logger.log("Change Text --" + text);


    setState(() {
      if (text.length > 2) {
        fillDetails = true;
      } else {
        fillDetails = false;
      }
    });

    _complexPresenter.searchComplex(text);
  }

  @override
  clearList() {
    setState(() {
      if (complex != null) {
        complex.clear();
        _notFoundComplex = FsString.NOT_FOUND_COMPLEX;
        bool pinSearch = true;
        String text = _searchControl.text.toString();
        try {
          int.parse(text);
        } catch (e) {
          pinSearch = false;
        }
        if (pinSearch && text.length > 5) {
          _notFoundComplex = FsString.NOT_FOUND_COMPLEX_AREA;
        } else {
          _notFoundComplex = FsString.NOT_FOUND_COMPLEX;
        }
      }
    });
  }

  getSubscription(Map place) {
    return place["subscribed"] != null && place["subscribed"] == "yes";
  }

// Widget complexjoincondition(Map place) {
//   if (place["joincompl"]) {
//     return Row(
//       children: <Widget>[
//         Text('Join',
//             style: TextStyle(
//                 fontSize: FSTextStyle.h6size,
//                 fontFamily: 'Gilroy-SemiBold',
//                 color: FsColor.green)),
//       ],
//     );
//   } else {
//     return Row(
//       children: <Widget>[
//         Text('Waiting for Approval',
//             style: TextStyle(
//                 fontSize: FSTextStyle.h7size,
//                 fontFamily: 'Gilroy-SemiBold',
//                 color: FsColor.red)),
//       ],
//     );
//   }
// }
}
