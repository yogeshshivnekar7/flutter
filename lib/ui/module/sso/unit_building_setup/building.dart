import 'dart:ui';

import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/presentor/module/sso/unit_building_setup/building_presenter.dart';
import 'package:sso_futurescape/presentor/module/sso/unit_building_setup/building_view.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/confirm_dialog.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/utils/app_constant.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class BuildingPage extends StatefulWidget {
  Map _complex;
  String _callingType;

  int _appAccess;

  BuildingPage(Map place, {String callingType, int appAccess}) {
    _complex = place;
    _callingType = callingType;
    _appAccess = _complex["app_access"];
//    print(_complex["app_access"]);
    print("appaccess------------------------------------------$_appAccess");
//    print("appaccess------------------------------------------$");
  }

  @override
  _BuildingPageState createState() =>
      new _BuildingPageState(_complex, _callingType, _appAccess);
}

class _BuildingPageState extends State<BuildingPage> implements BuildingView {
  TextEditingController userNameController = new TextEditingController();

  Map _complex;

  BuildingPresenter _buildingPresenter;

  List building;

  bool isFourthStep = false;
  bool isThirdStep = false;
  bool isSecondStep = false;
  bool isFirstStep = true;

  List membershipType;

  Map _selectedUnit;

  Map _selectedFloor;

  var _userProfie;

  Map _selectedBuilding;

  int _appAccess;

  var _selectedMemberType;
  bool isLoading = true;
  bool isDialogLoading = false;

  var _memberStatus;

  _BuildingPageState(Map complex, String callingType, int appAccess) {
    _complex = complex;
//    _callingType = callingType;
    _appAccess = appAccess;
  }

  @override
  void initState() {
    super.initState();
    SsoStorage.getUserProfile().then((profile) {
      _userProfie = profile;
    });
    _buildingPresenter = new BuildingPresenter(this);

    if (_appAccess == AppConstant.CHSONE_ACCESS ||
        _appAccess == AppConstant.BOTH) {
      _buildingPresenter.getBuildings(_complex["company_id"].toString());
    } else if (_appAccess == AppConstant.VIZLOG_ACCESS) {
      _buildingPresenter.getVizlogBuildings(_complex["company_id"].toString());
    }
  }

  @override
  void dispose() {
    _buildingPresenter = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          backgroundColor: FsColor.primaryflat,
          elevation: 0.0,
          title: new Text(
            _complex["company_name"],
//            'Complex Name Here',
            style: FSTextStyle.appbartextlight,
          ),
          leading: FsBackButtonlight(backEvent: (context) {
            buildSetState(context);
          }),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: 15.0, bottom: 15.0, left: 10.0, right: 10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(width: 5.0),
                    stepContainer(isFirstStep, "1"),
                    expandedView(isSecondStep),
                    stepContainer(isSecondStep, "2"),
                    expandedView(isThirdStep),
                    stepContainer(isThirdStep, "3"),
                    expandedView(isFourthStep),
                    stepContainer(isFourthStep, "4"),
                    SizedBox(width: 5.0),
                  ]),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                  child: isLoading ? Container() : setTitle(),
                ),
                isLoading /* && !isFourthStep*/
                    ? PageLoader()
                    : listContainer(),
              ],
            ),
          ],
        ));
  }

  void buildSetState(context) {
    return setState(() {
      if (isFourthStep) {
        isFourthStep = false;
      } else if (isThirdStep) {
        isThirdStep = false;
        setState(() {
          clearUnits();
        });
      } else if (isSecondStep) {
        isSecondStep = false;
      } else if (isFirstStep) {
        Navigator.pop(context);
      }
    });
  }

  void clearUnits() {
    if (unit != null) unit.clear();
  }

  Text setTitle() {
    String text;
    if (isFourthStep) {
      text = "your membership type";
    } else if (isThirdStep) {
      if (unit != null && unit.length > 0)
        text = "choose your unit";
      else
        text = "";
    } else if (isSecondStep) {
      if (floor != null && floor.length > 0)
        text = "choose your floor";
      else
        text = "";
    } else if (isFirstStep) {
      if (building != null && building.length > 0)
        text = "choose your building";
      else
        text = "";
    }
    return Text(
      text,
      style: TextStyle(
        fontSize: FSTextStyle.h5size,
        fontFamily: 'Gilroy-SemiBold',
        color: FsColor.darkgrey,
        height: 1.2,
      ),
    );
  }

  Expanded expandedView(bool isSelected) {
    return Expanded(
        child: Divider(
          color: isSelected ? FsColorStepper.active : FsColorStepper.inactive,
          height: 1,
        ));
  }

  Padding listContainer() {
    if (isFourthStep) return membershipContainer();
    if (isThirdStep) return unitContainer();
    if (isSecondStep) return floorContainer();
    if (isFirstStep) return buildingContainer();
  }

  Padding membershipContainer() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: ListView.builder(
        primary: false,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: membershipType == null ? 0 : membershipType.length,
        itemBuilder: (BuildContext context, int index) {
          Map selectedMemberType = membershipType[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: InkWell(
              child: Container(
                padding: const EdgeInsets.only(
                  bottom: 10.0,
                  top: 10.0,
                ),
                decoration: boxDecoration(
                    selectedMemberType["selected"] != null &&
                        selectedMemberType["selected"]),
                // height: 85,
                child: Row(
                  children: <Widget>[
                    // SizedBox(width: 15),
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
                            padding: const EdgeInsets.only(left: 5.0),
                            alignment: Alignment.centerLeft,
                            child: RichText(
                                text: TextSpan(
                                    style: Theme.of(context).textTheme.body1,
                                    children: [
                                  TextSpan(
                                    text:
                                    '${getMemberShipName(selectedMemberType)}',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-SemiBold',
                                      fontSize: FSTextStyle.h6size,
                                      color: FsColor.basicprimary,
                                    ),
                                  ),
                                ])),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                setState(() {
                  openConfirmDialog(selectedMemberType, context);

//                  print(place["member_type_id"]);
//                  sendUnitReuest(place["member_type_id"].toString());
                });

                //                  _confirmsetupDialog();
              },
            ),
          );
        },
      ),
    );
  }

  void openConfirmDialog(Map selectedMemberType, BuildContext context) {
    print(
        "--------------------------openConfirmDialog------------------------------------$selectedMemberType");
//    print("--------------------------_appAccess------------------------------------$_appAccess");
    print(selectedMemberType["is_taken"]);
    print(selectedMemberType["viz_is_taken"]);
    if (_appAccess != AppConstant.BOTH) {
      if (_memberStatus != null) {
        var isApproved = _memberStatus["is_approved"];
        if (isApproved != null) {
          String msg = "";
          if (isApproved == 1) {
            msg = FsString.already_member;
          } else {
            msg = FsString.already_requested;
          }
          Toasly.error(context, msg);
          return;
        }
      }
    }
    if (selectedMemberType["is_taken"] == null &&
        (_appAccess == AppConstant.CHSONE_ACCESS))
//            ||
//            _appAccess == AppConstant.BOTH))
        {
      _selectedMemberType = selectedMemberType;
      membershipType.forEach((x) {
        (x["selected"] = false);
      });
//      print("--------------------------is_taken------------------------------------");
      _selectedMemberType["selected"] = true;
      _confirmsetupDialog();
    } else if (_appAccess == AppConstant.BOTH &&
        (selectedMemberType["is_taken"] == null ||
            selectedMemberType["viz_is_taken"] == null))
//            ||
//            _appAccess == AppConstant.BOTH))
        {
      _selectedMemberType = selectedMemberType;
      membershipType.forEach((x) {
        (x["selected"] = false);
      });
//      print("--------------------------is_taken------------------------------------");
      _selectedMemberType["selected"] = true;
      _confirmsetupDialog();
    }
    else if (selectedMemberType["viz_is_taken"] == null &&
        _appAccess == AppConstant.VIZLOG_ACCESS) {
      _selectedMemberType = selectedMemberType;
      membershipType.forEach((x) {
        (x["selected"] = false);
      });
//      print("--------------------------viz_is_taken------------------------------------");
      _selectedMemberType["selected"] = true;
      _confirmsetupDialog();
    } else {
//      print("--------------------------else------------------------------------");
      String mesg;
      if (_appAccess == AppConstant.CHSONE_ACCESS ||
          _appAccess == AppConstant.BOTH) {
        mesg = selectedMemberType["is_taken"];
      } else {
        mesg = selectedMemberType["viz_is_taken"];
      }

      Toasly.error(context, mesg);
    }
  }

  String getMemberShipName(Map selectedMemberType) {
    String taken = "";
    if (_appAccess == AppConstant.CHSONE_ACCESS)
//        ||
//        _appAccess == AppConstant.BOTH)
        {
      if (selectedMemberType["is_taken"] != null) {
        taken = "(" + selectedMemberType["is_taken"] + ")";
      }
    } else if (_appAccess == AppConstant.BOTH) {
      if (selectedMemberType["is_taken"] != null &&
          selectedMemberType["viz_is_taken"] != null) {
        taken = "(" + selectedMemberType["is_taken"] + ")";
      }
    }
    else {
      if (selectedMemberType["viz_is_taken"] != null) {
        taken = "(" + selectedMemberType["viz_is_taken"] + ")";
      }
    }

    return selectedMemberType["member_type_name"] + " " + taken;
  }

  void _confirmsetupDialog() {
    // flutter defined function
    String membership = _selectedMemberType["member_type_name"].toString();
//   String memberTypeId = _selectedMemberType["member_type_id"].toString();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return new ConfirmDialog(
            this._complex,
            this._selectedBuilding,
            this._selectedFloor,
            this._selectedUnit,
            this._userProfie,
            membership,
            this._selectedMemberType,
            this._appAccess);

      },
    );
  }

  Padding unitContainer() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
          // childAspectRatio: 2.0,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 3.0),
        ),
        primary: false,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: unit == null ? 0 : unit.length,
        itemBuilder: (BuildContext context, int index) {
          Map unitPlace = unit[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: InkWell(
              child: Container(
                padding: const EdgeInsets.only(
                  bottom: 5.0,
                  top: 5.0,
                ),
                decoration: boxDecoration(
                    unitPlace["selected"] != null && unitPlace["selected"]),
                // height: 85,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        "images/unit.png",
                        height: 48,
                        width: 80,
                        fit: BoxFit.contain,
                      ),
                    ),
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
                            alignment: Alignment.center,
                            child: RichText(
                                text: TextSpan(
                                    style: Theme.of(context).textTheme.body1,
                                    children: [
                                  TextSpan(
                                    text: '${unitPlace["unit_flat_number"]}',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-SemiBold',
                                      fontSize: FSTextStyle.h6size,
                                      color: FsColor.basicprimary,
                                    ),
                                  ),
                                ])),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                _selectedUnit = unitPlace;
                print("----------------------------selectedUnit -----");
                unitSelect();
              },
            ),
          );
        },
      ),
    );
  }

  void unitSelect() {
//    _selectedUnit = place;
    print(_selectedUnit);
    unit.forEach((x) {
      x["selected"] = false;
    });
    _selectedUnit["selected"] = true;
    setState(() {
      isLoading = true;
      isFourthStep = true;

      /*if (_callingType == AppConstant.CHSONE) {
        _buildingPresenter.getMemberType(_complex["company_id"].toString());
        _buildingPresenter.getMemberStatus(
            _complex["company_id"].toString(), place["unit_id"].toString());
      } else if (_callingType == AppConstant.VIZLOG) {
        generateVizlogMembership();
      }*/
//      _buildingPresenter.getMemberType(_complex["company_id"].toString());
      if (_appAccess == AppConstant.CHSONE_ACCESS ||
          _appAccess == AppConstant.BOTH) {
        _buildingPresenter.getMemberType(_complex["company_id"].toString());
      } else if (_appAccess == AppConstant.VIZLOG_ACCESS) {
        generateVizlogMembership();
      }
    });
  }

  Padding floorContainer() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
          // childAspectRatio: 2.0,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery
                  .of(context)
                  .size
                  .height / 2.5),
        ),
        primary: false,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: floor == null ? 0 : floor.length,
        itemBuilder: (BuildContext context, int index) {
          Map selectedFloor = floor[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: InkWell(
              child: Container(
                padding: const EdgeInsets.only(
                  bottom: 5.0,
                  top: 5.0,
                ),
                decoration: boxDecoration(selectedFloor["selected"] != null &&
                    selectedFloor["selected"]),
                // height: 85,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        "images/floor.png",
//                              "${place["img"]}",
                        height: 40,
                        width: 40,
                        fit: BoxFit.contain,
                      ),
                    ),
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
                            padding: const EdgeInsets.only(
                              top: 10.0,
                            ),
                            alignment: Alignment.center,
                            child: RichText(
                                text: TextSpan(
                                    style: Theme.of(context).textTheme.body1,
                                    children: [
                                  TextSpan(
                                    text: '${selectedFloor["name"]}',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-SemiBold',
                                      fontSize: FSTextStyle.h6size,
                                      color: FsColor.basicprimary,
                                    ),
                                  ),
                                ])),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                _selectedFloor = selectedFloor;
                floorSelected();
                //                  Navigator.push(
                //                    context,
                //                    MaterialPageRoute(
                //                        builder: (context) => UnitPage()),
                //                  );
              },
            ),
          );
        },
      ),
    );
  }

  BoxDecoration boxDecoration(bool boxDecor) {
    return boxDecor
        ? BoxDecoration(
            color: FsColor.primaryflat.withOpacity(0.1),
            border: Border.all(width: 1.0, color: FsColor.primaryflat),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          )
        : BoxDecoration();
  }

  void floorSelected() {
    print(_selectedFloor);
    setState(() {
      isLoading = true;
      floor.forEach((x) => {x["selected"] = false});
      _selectedFloor["selected"] = true;
      isThirdStep = true;
//      print(place);

      if (_appAccess == AppConstant.VIZLOG_ACCESS) {
        _buildingPresenter.getVizlogUnits(
            _complex["company_id"].toString(),
            _selectedFloor["soc_building_id"].toString(),
            _selectedFloor["floor_id"].toString());
      } else if (_appAccess == AppConstant.CHSONE_ACCESS ||
          _appAccess == AppConstant.BOTH) {
        _buildingPresenter.getUnits(
            _complex["company_id"].toString(),
            _selectedFloor["soc_building_id"].toString(),
            _selectedFloor["floor_id"].toString());
      }
    });
  }

  Padding buildingContainer() {
    return Padding(
      padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
      child: ListView.builder(
        primary: false,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: building == null ? 0 : building.length,
        itemBuilder: (BuildContext context, int index) {
          Map place = building[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: InkWell(
              child: Container(
                padding: const EdgeInsets.only(
                  bottom: 5.0,
                  top: 5.0,
                ),
                decoration: boxDecoration(
                    (place["selected"] != null && place["selected"])),
                // height: 85,
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        "${"images/building.png"}",
                        height: 48,
                        width: 48,
                        fit: BoxFit.contain,
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
                                    style: Theme.of(context).textTheme.body1,
                                    children: [
                                  TextSpan(
                                    text: '${place["soc_building_name"]}',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-SemiBold',
                                      fontSize: FSTextStyle.h6size,
                                      color: FsColor.basicprimary,
                                    ),
                                  ),
                                ])),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                setState(() {
                  building.forEach((x) {
                    x["selected"] = false;
                  });
                  place["selected"] = true;
                  isSecondStep = true;
                  _selectedBuilding = place;
                  isLoading = true;
                  generateFloorList(place);
                });
              },
            ),
          );
        },
      ),
    );
  }

  Container stepContainer(bool isSelected, String text) {
    return Container(
      child: GestureDetector(
          child: Container(
            alignment: Alignment.center,
            width: 30.0,
            height: 30.0,
            decoration: BoxDecoration(
              color:
              isSelected ? FsColorStepper.active : FsColorStepper.inactive,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'Gilroy-Bold',
                fontSize: FSTextStyle.h6size,
                color: FsColor.white,
              ),
            ),
          ),
          onTap: () {
            setState(() {
              if (text == "1" && isFirstStep) {
                isFirstStep = true;
                isSecondStep = false;
                isThirdStep = false;
                isFourthStep = false;
                clearUnits();
              } else if (text == "2" && isFirstStep && isSecondStep) {
                isFirstStep = true;
                isSecondStep = true;
                isThirdStep = false;
                isFourthStep = false;
                clearUnits();
              } else if (text == "3" &&
                  isFirstStep &&
                  isSecondStep &&
                  isThirdStep) {
                isFirstStep = true;
                isSecondStep = true;
                isThirdStep = true;
                isFourthStep = false;
              }
            });
          }),
    );
  }

  @override
  onBuildingFound(buildings) {
    print(buildings);
    if (_appAccess == AppConstant.BOTH) {
      building = buildings["data"];
      _buildingPresenter.getVizlogBuildings(_complex["company_id"].toString());
      print("-------------chsone building-------------");
//      print(building);
    } else if (_appAccess == AppConstant.CHSONE_ACCESS) {
      setState(() {
        building = buildings["data"];
        isLoading = false;
      });
    }
//    setState(() {

//      if (_appAccess == AppConstant.VIZLOG_ACCESS) {
//        building = buildings["data"]["results"];
//      } else if (_appAccess== AppConstant.CHSONE_ACCESS) {
//        building = buildings["data"];
//      }
//    });
  }

  @override
  onError(error) {
    print("ddddddddddddddddddddddddddddddd");
//    print(error);
    Toasly.error(context, AppUtils.errorDecoder(error));
//    if(_appAccess !=AppConstant.BOTH){
//    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  onFailure(failure) {
    print(failure);

    Toasly.error(context, AppUtils.errorDecoder(failure));
//    if(_appAccess !=AppConstant.BOTH) {
//    }
    setState(() {
      isLoading = false;
      /*if (_sendVizlogRequest) {
        setState(() {
          isLoading = false;
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PendingApprovalPage()),
          );
        });
      }*/
    });
  }

  List floor;

  void generateFloorList(Map selectedFloor) {
    int noOfFloors = selectedFloor["soc_building_floors"];
    print("no of floor $noOfFloors");
    floor = [];
    for (int i = 0; i < noOfFloors + 1; i++) {
      var fl = {};
      if (i == 0) {
        fl["name"] = "Ground Floor";
      } else {
        fl["name"] = "$i Floor";
      }
      fl["floor_id"] = i;
      fl["soc_building_id"] = selectedFloor["soc_building_id"];
      if (_appAccess == AppConstant.BOTH) {
        fl["viz_soc_building_id"] = selectedFloor["viz_soc_building_id"];
      }
      floor.add(fl);
    }
    setState(() {
      isLoading = false;
    });
  }

  void generateVizlogMembership() {
    membershipType = [];
    var f1 = {
      "member_type_name": "Primary",
      "member_type_id": 1,
    };
//    f1["member_type_name"] = "Primary";
    var f2 = {"member_type_name": "Associate", "member_type_id": 2};
//    f2["member_type_name"] = "Associate";
    var f3 = {"member_type_name": "Tenant", "member_type_id": 3};
//    f3["member_type_name"] = "Tenant";

    membershipType.add(f1);
    membershipType.add(f2);
    membershipType.add(f3);
//    setState(() {
    _buildingPresenter.getMemberStatusVizLog(
        _complex["company_id"].toString(), _selectedUnit["unit_id"].toString());
//      isLoading = false;
//    });
  }

  List unit;

  @override
  onUnitFound(units) {
//    print(units);
    print("-----------------------chsone units------------------------");
    if (_appAccess == AppConstant.CHSONE_ACCESS) {
      setState(() {
        unit = units["data"];
        if (unit == null || unit.length <= 0) {
          Toasly.error(context, "No units found");
        }
        isLoading = false;
      });
    } else if (_appAccess == AppConstant.BOTH) {
      unit = units["data"];
      if (_selectedFloor["viz_soc_building_id"] != null) {
        _buildingPresenter.getVizlogUnits(
            _complex["company_id"].toString(),
            _selectedFloor["viz_soc_building_id"].toString(),
            _selectedFloor["floor_id"].toString());
      } else {
        setState(() {
          isLoading = false;
        });
      }
    }
    print("chsone -------------------------------------- $unit");

    /* if (_appAccess== AppConstant.VIZLOG_ACCESS) {
        unit = units["data"]["results"];
        for (int i = 0; unit != null && i < unit.length; i++) {
          unit[i]["unit_flat_number"] = unit[i]["unit_number"];
          unit[i]["unit_id"] = unit[i]["building_unit_id"];
          unit[i]["soc_building_id"] = unit[i]["fk_building_id"];
        }*/
  }

  @override
  onMemberTypeFound(memberType) {
    print(memberType);
    membershipType = memberType["data"];
    if (_appAccess == AppConstant.CHSONE_ACCESS ||
        _appAccess == AppConstant.BOTH) {
      _buildingPresenter.getMemberStatus(_complex["company_id"].toString(),
          _selectedUnit["unit_id"].toString());
    }
    /*else {
      _buildingPresenter.getMemberStatusVizLog(
          _complex["company_id"].toString(),
          _selectedUnit["unit_id"].toString());
    }
*/
//    setState(() {
//    });
  }

  @override
  onMemberStatus(memberStatus) {
    print(
        "-----------------memberStatus--------------------------------------------");
    print(memberStatus);
//    setState(() {
//      bool onlyPrimary = true;
//      var primaryType;
//      for (int i = 0;
//      membershipType != null && i < membershipType.length;
//      i++) {
//        if (membershipType[i]["member_type_name"].toString().toLowerCase() ==
//            "primary") {
//          _memberStatus = memberStatus["data"];
////          print(_whichShow(_memberStatus));
//          primaryType = membershipType[i];
//          if (!_whichShow(_memberStatus)) {
//            membershipType.removeAt(i);
//            onlyPrimary = false;
//            break;
//          }
//        }
//      }
//      if (onlyPrimary) {
//        membershipType.clear();
//        membershipType.add(primaryType);
//      }
//      isLoading = false;
//    });

//    _memberStatus = [];
    setState(() {
      populateMemberStatus(memberStatus, AppConstant.CHSONE);
//      print(
//          "-------------------------------memberStatustype----------------------------");
//      print(membershipType);
    });
  }

  void populateMemberStatus(memberStatus, String from) {
    _memberStatus = null;
    print(
        "-----------------------------memberStatus-------------------------------$memberStatus");
    if (memberStatus == null &&
        from != AppConstant.VIZLOG &&
        (_appAccess == AppConstant.BOTH ||
            _appAccess == AppConstant.CHSONE_ACCESS)) {
      var primary;
      for (int i = 0; i < membershipType.length; i++) {
        if (membershipType[i]["member_type_id"] == 1) {
          membershipType[i]["selected"] = true;
          primary = membershipType[i];
          break;
        }
      }
      membershipType.clear();
      membershipType.add(primary);
    } else if (memberStatus == null &&
        _appAccess == AppConstant.VIZLOG_ACCESS) {
      print("-------------vizlog-------------------------");
      var primary;
      for (int i = 0; i < membershipType.length; i++) {
        if (membershipType[i]["member_type_id"] == 1) {
          membershipType[i]["selected"] = true;
          primary = membershipType[i];
          break;
        }
      }
      membershipType.clear();
      membershipType.add(primary);
    } else if (memberStatus != null) {
      for (var unit in memberStatus) {
        if (unit["user_id"] != null &&
            unit["user_id"] == _userProfie["user_id"]) {
          _memberStatus = {
            "is_approved": unit["approved"],
            "member_type_id": unit["member_type_id"],
          };
        }
        print(
            "----------------inside----------------------------$membershipType");
        for (int i = 0; i < membershipType.length; i++) {
          if (membershipType[i]["member_type_id"] == unit["member_type_id"]) {
            print(unit["is_primary"]);
            print(unit["user_id"]);
            print(_userProfie["user_id"]);
            if (unit["is_primary"] != null &&
                unit["is_primary"].toString() == "true") {
              if (unit["user_id"] != null &&
                  unit["user_id"] == _userProfie["user_id"]) {
                if (unit["approved"] != null && unit["approved"] == 1) {
                  if (from == AppConstant.CHSONE) {
                    membershipType[i]["is_approved"] = "yes";
                    membershipType[i]["is_taken"] = "taken";
                  } else {
                    membershipType[i]["viz_is_taken"] = "taken";
                  }
                } else {
                  if (from == AppConstant.CHSONE) {
                    membershipType[i]["is_approved"] = "yes";
                    membershipType[i]["is_taken"] = "already requested";
                  } else {
                    membershipType[i]["viz_is_taken"] = "already requested";
                  }
                }
              } else {
                if (unit["approved"] != null && unit["approved"] == 1 &&
                    unit["user_id"] != null && unit["user_id"] != 0) {
                  if (from == AppConstant.CHSONE) {
                    membershipType[i]["is_approved"] = "yes";
                    membershipType[i]["is_taken"] = "taken";
                  } else {
                    membershipType[i]["viz_is_taken"] = "taken";
                  }
                }
              }
            }
            else if (unit["user_id"] != null &&
                unit["user_id"] == _userProfie["user_id"]) {
              if (unit["approved"] != null && unit["approved"] == 1) {
                membershipType[i]["is_approved"] = "already member";
              } else {
                membershipType[i]["is_approved"] = "already requested";
              }
            }
          }
        }
      }
    }
    print(membershipType);
    if (_appAccess == AppConstant.BOTH && from == AppConstant.CHSONE) {
      print(
          "---------------------getMemberStatusVizLog---------------------------------");
//      _buildingPresenter.getMemberStatusVizLog(
//          _complex["company_id"].toString(),
//          _selectedUnit["unit_id"].toString());
      _buildingPresenter.getMemberStatusVizLog(
          _complex["company_id"].toString(),
          _selectedUnit["viz_unit_id"].toString());
    } else {
      isLoading = false;
    }
  }

  /*

  bool _whichShow(var memberStatus) {
    bool canPrimaryAdd = false;
    int condition = memberStatus["type"];
    switch (condition) {
      case 1:
        //Account not connected and and may be primary added
      //Account not connected and and may be primary added
        //Added new Code to handle type 1 with primary un approved
        bool hasUserz = memberStatus["user_id"] == null;
        */ /*memberStatus["user_id"] != 0;
            */ /*
        canPrimaryAdd = memberStatus["user_id"] == null;

        break;
      case 2:
        */ /*  unApprovedDialog();*/ /*
        //Account not created and and may be primary added
        bool hasUserz =
            memberStatus["user_id"] != null && memberStatus["user_id"] != 0;
        canPrimaryAdd = memberStatus["approved"] == 0 || !hasUserz;
        break;
      case 3:
        //No memeber in
        canPrimaryAdd = true;
        break;
      default:
    }
    print("canPrimaryAdd  -- $canPrimaryAdd");
    return canPrimaryAdd;
  }
*/

  @override
  onRequestSent(requestSent) {}

  @override
  onVizlogBuildingFound(buildings) {
    if (_appAccess == AppConstant.VIZLOG_ACCESS) {
      setState(() {
        building = buildings["data"]["results"];
        isLoading = false;
      });
    } else if (_appAccess == AppConstant.BOTH) {
      var b = buildings["data"]["results"];
      print("-------------onVizlogBuildingFound------------- $b");
      combineBuildings(b);
//      print(b);
    }

//    building = buildings["data"]["results"];
  }

  void combineBuildings(List vizlogBuildings) {
    List combineList = [];

    for (int i = 0; i < building.length; i++) {
      for (int j = 0;
      vizlogBuildings != null && j < vizlogBuildings.length;
      j++) {
        if (building[i]["soc_building_name"].toString().trim() ==
            vizlogBuildings[j]["soc_building_name"].toString().trim()) {
          building[i]["viz_soc_building_id"] =
          vizlogBuildings[j]["soc_building_id"];
          combineList.add(building[i]);
          break;
        }
      }
    }
    setState(() {
      building.clear();
      building.addAll(combineList);
      combineList = null;
      isLoading = false;
    });
  }

  @override
  onVizlogUnitFound(units) {
    if (_appAccess == AppConstant.VIZLOG_ACCESS) {
      setState(() {
        unit = units["data"]["results"];
        for (int i = 0; unit != null && i < unit.length; i++) {
          unit[i]["unit_flat_number"] = unit[i]["unit_number"];
          unit[i]["unit_id"] = unit[i]["building_unit_id"];
          unit[i]["soc_building_id"] = unit[i]["fk_building_id"];
        }
        isLoading = false;
      });
    } else if (_appAccess == AppConstant.BOTH) {
      var a = units["data"]["results"];
//      var a = units["data"]["results"];
      print("-----------------vizlog unit------------------------------- $a");
      combineUnits(a);
    }
  }

  void combineUnits(List vizLogUnits) {
    List combineUnits = [];
    for (int i = 0; i < unit.length; i++) {
      for (int j = 0; vizLogUnits != null && j < vizLogUnits.length; j++) {
        if (unit[i]["unit_flat_number"].toString().trim() ==
            vizLogUnits[j]["unit_number"].toString().trim()) {
          unit[i]["viz_unit_id"] = vizLogUnits[j]["building_unit_id"];
          unit[i]["viz_soc_building_id"] = vizLogUnits[j]["fk_building_id"];
//            print("------------------------------------------same---------------------------------------------");
          combineUnits.add(unit[i]);
          break;
        }
      }
    }
    setState(() {
      unit.clear();
      unit.addAll(combineUnits);
      combineUnits = null;
      isLoading = false;
    });
  }

  @override
  onVizRequestSent(requestSent) {}

  @override
  onMemberStatusVizlog(memberStatus) {
    setState(() {
      populateMemberStatus(memberStatus, AppConstant.VIZLOG);
    });
  }
}
