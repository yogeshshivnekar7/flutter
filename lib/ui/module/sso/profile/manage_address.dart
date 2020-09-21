import 'dart:convert';

import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/presentor/module/sso/profile/profile_presenter.dart';
import 'package:sso_futurescape/presentor/module/sso/profile/profile_view.dart';
import 'package:sso_futurescape/ui/module/sso/profile/add_new_address.dart';
import 'package:sso_futurescape/ui/module/sso/profile/address_list_widget.dart';
import 'package:sso_futurescape/ui/module/sso/profile/profile_view.dart';
import 'package:sso_futurescape/ui/module/veza/veza_shop_listing.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/permission/permission_service.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class ManageAddress extends StatefulWidget {
  var profileData;

  ManageAddress(profileData) {
    this.profileData = profileData;
  }

  @override
  State<StatefulWidget> createState() {
    return _ManageAddressState(profileData);
  }

  static String getFullAddress(Map tempAddress) {
    print(tempAddress["address_tag"] + tempAddress.toString());
    String fullAddress = "";
    /*if (addresstype == "home") {
      print("getFullAddress " + addresstype);
      tempAddress = home_address;
    } else if (addresstype == "office") {
      print("getFullAddress " + addresstype);
      tempAddress = office_address;
    } else if (addresstype == "other") {
      tempAddress = other_address;
    }*/

    if (tempAddress != null) {
      String address =
          tempAddress["address"] != null ? tempAddress["address"] : "";
      String landmark =
          tempAddress["landmark"] != null ? tempAddress["landmark"] : "";
      String locality =
      tempAddress["locality"] != null ? tempAddress["locality"] : "";
      String city = tempAddress["city"] != null ? tempAddress["city"] : "";
      String zipcode =
      tempAddress["zipcode"] != null ? tempAddress["zipcode"] : "";
      String state = tempAddress["state"] != null ? tempAddress["state"] : "";

      fullAddress = address +
          (address.isEmpty ? "" : ", ") +
          landmark +
          (landmark.isEmpty ? "" : ", ") +
          locality +
          (locality.isEmpty ? "\n" : ",\n") +
          city +
          (city.isEmpty ? "" : ", ") +
          state +
          (state.isEmpty ? "" : ", ") +
          zipcode;
      print("finalAddress " + fullAddress);
    } else
      fullAddress = "";

    return fullAddress;
  }

  static String getFullAddressWithoutLine(Map tempAddress) {
    print(tempAddress["address_tag"] + tempAddress.toString());
    String fullAddress = "";
    /*if (addresstype == "home") {
      print("getFullAddress " + addresstype);
      tempAddress = home_address;
    } else if (addresstype == "office") {
      print("getFullAddress " + addresstype);
      tempAddress = office_address;
    } else if (addresstype == "other") {
      tempAddress = other_address;
    }*/

    if (tempAddress != null) {
      String address =
      tempAddress["address"] != null ? tempAddress["address"] : "";
      String landmark =
      tempAddress["landmark"] != null ? tempAddress["landmark"] : "";
      String locality =
      tempAddress["locality"] != null ? tempAddress["locality"] : "";
      String city = tempAddress["city"] != null ? tempAddress["city"] : "";
      String zipcode =
      tempAddress["zipcode"] != null ? tempAddress["zipcode"] : "";
      String state = tempAddress["state"] != null ? tempAddress["state"] : "";

      fullAddress = address +
          (address.isEmpty ? "" : ", ") +
          landmark +
          (landmark.isEmpty ? "" : ", ") +
          locality +
          (locality.isEmpty ? "" : ",") +
          city +
          (city.isEmpty ? "" : ", ") +
          state +
          (state.isEmpty ? "" : ", ") +
          zipcode;
      print("finalAddress " + fullAddress);
    } else
      fullAddress = "";

    return fullAddress;
  }
}

class _ManageAddressState extends State<ManageAddress>
    implements ProfileResponseView {
  List manageaddress = null;
  var profileData;
  ProfilePresenter presenter;

  REQUEST_TYPE _requestType;

  bool isloader = false;

  _ManageAddressState(profileData) {
    this.profileData = profileData;
    presenter = new ProfilePresenter(null);
  }

  @override
  void initState() {
    print("setState");
    if (profileData != null) {
      initializeData().then((value) {
        setState(() {});
      }).catchError((e) {
        print(e);
      });
    } else {
      //todo getProfile from server
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Manage Address".toLowerCase(),
          style: FSTextStyle.appbartext,
        ),
        leading: FsBackButton(),
      ),
      body: isloader
          ? PageLoader()
          : SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  AddresList(
                    manageaddress,
                    profileData,
                    onDeleteClick: (tag) {
                      showDeleteAlertDialog(context, tag);
                      /*deleteAddress(tag, context);*/
                    },
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                    child: GestureDetector(
                      child: RaisedButton(
                        child: Text('Add New Address',
                            style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                fontFamily: 'Gilroy-SemiBold')),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(4.0),
                        ),
                        color: const Color(0xFF404040),
                        textColor: FsColor.white,
                        onPressed: () {
                          openManageAddress(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showDeleteAlertDialog(BuildContext context, String tag) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
            backgroundColor: Colors.white,
            title: new Text("Delete Address?",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Gilroy-SemiBold',
                    fontSize: FSTextStyle.h4size,
                    color: FsColor.darkgrey)),
            shape: new RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: new BorderRadius.circular(7.0),
            ),
            content: new Text("Are you sure you want to delete address $tag ?",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Gilroy-Regular',
                    fontSize: FSTextStyle.h6size,
                    color: Colors.grey[600])),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                },
                child: Text(
                  "No",
                  style: TextStyle(
                      fontFamily: 'Gilroy-SemiBold',
                      fontSize: FSTextStyle.h5size,
                      color: FsColorStepper.active),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                  deleteAddress(tag, context);
                },
                child: Text(
                  "Yes",
                  style: TextStyle(
                      fontFamily: 'Gilroy-SemiBold',
                      fontSize: FSTextStyle.h5size,
                      color: FsColorStepper.active),
                ),
              )
            ],
          );
        });
  }

  void deleteAddress(tag, BuildContext context) {
    isloader = true;
    setState(() {});
    presenter.deleteAddress(tag, (ans) {
      deleteFromPrernceAddress(tag, context);
      ProfileUtil.loadNewProfile((msg) {
        SsoStorage.getUserProfile().then((onValue) {
          profileData = onValue;
          initializeData();
          Toasly.success(context, "Address deleted Successful!".toLowerCase(),
              duration: DurationToast.SHORT, gravity: Gravity.BOTTOM);
          isloader = false;
          setState(() {});
        });
        //Navigator.pop(context);
      }, (error) {
        SsoStorage.getUserProfile().then((onValue) {
          profileData = onValue;
          isloader = false;
          setState(() {});
        });
      });
    }, (xxx) {
      isloader = false;
      setState(() {});
    });
  }

  Future<void> openManageAddress(BuildContext context) async {
    var location = new Location();
    var hasPer = await location.hasPermission();
    print("hasPer");
    print(hasPer);
    if (hasPer == PermissionStatus.denied ||
        hasPer == PermissionStatus.deniedForever) {
      //Toasly.error(context, "Location permission is denied for forever \n Please enable location from settings!");
      /* print("hasPer");
      print(hasPer);*/
      bool a = await PermissionsService1().isForverLocationPermission();
      if (a) {
        /*Toasly.error(context,
            "Sorry. We are unable to proceed further as access to detect your location is denied.");*/
        PermissionsService1().showDeleteAlertDialog(context);
        return;
      }
      var reqPer = await PermissionsService1().requestLocationPermission();
      if (reqPer /* == PermissionStatus.granted*/) {
        bool a = await location.serviceEnabled();
        if (!a) {
          setState(() {});
          bool b = await location.requestService();
          print("Permission for Location");
          print(b);
          if (b) {
            await callAddAddressPage(context);
          }
        }
      }
    } else {
      await callAddAddressPage(context);
    }

//FsNavigator.push(context, new AddressListScreen());
  }

  /*Container buildContainer() {
    return Container(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: manageaddress == null || manageaddress.isEmpty
                      ? FsNoData()
                      : ListView.builder(
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: manageaddress == null
                        ? 0
                        : manageaddress.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map address = manageaddress[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 1.0),
                        child: InkWell(
                          child: Container(
                            padding: const EdgeInsets.all(0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width -
                                        100,
                                    child: ListView(
                                      primary: false,
                                      physics:
                                      NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      children: <Widget>[
                                        Container(
                                          child: Column(
                                              children: <Widget>[
                                                ListTile(
                                                  title: Text(
                                                    "${address["address_tag"]}",
                                                    style: TextStyle(
                                                      fontFamily:
                                                      'Gilroy-Regular',
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    "${getFullAddress(
                                                        address)}",
                                                    style: TextStyle(
                                                      fontFamily:
                                                      'Gilroy-Regular',
                                                    ),
                                                  ),
                                                  leading:
                                                  Icon(Icons.home),
                                                ),
                                                Container(
                                                  padding:
                                                  EdgeInsets.all(5),
                                                  child: new Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .end,
                                                      mainAxisSize:
                                                      MainAxisSize
                                                          .max,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .center,
                                                      children: <
                                                          Widget>[
                                                        isVerify
                                                            ? new FlatButton(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                              0,
                                                              0,
                                                              0,
                                                              0),
                                                          child: new Text(
                                                              "Verify",
                                                              style:
                                                              TextStyle(
                                                                fontSize: FSTextStyle
                                                                    .h6size,
                                                                fontFamily: 'Gilroy-SemiBold',
                                                                color: FsColor
                                                                    .red,
                                                              )),
                                                          onPressed:
                                                              () {
                                                            Navigator
                                                                .push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (
                                                                      context) =>
                                                                      ProfileView()),
                                                            );
                                                          },
                                                        )
                                                            : Container(),
                                                        isEdit
                                                            ? new FlatButton(
                                                          child: new Text(
                                                              "Edit",
                                                              style:
                                                              TextStyle(
                                                                fontSize: FSTextStyle
                                                                    .h6size,
                                                                fontFamily: 'Gilroy-SemiBold',
                                                                color: FsColor
                                                                    .darkgrey,
                                                              )),
                                                          onPressed:
                                                              () {
                                                            Navigator
                                                                .push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (
                                                                      context) =>
                                                                      EditAddress(
                                                                          address,
                                                                          profileData)),
                                                            );
                                                          },
                                                        )
                                                            : Container(),
                                                        SizedBox(
                                                            width:
                                                            10.0),
                                                        */ /*new FlatButton(
                                                      child: new Text(
                                                          "Delete",
                                                          style: TextStyle(
                                                            fontSize:
                                                            FSTextStyle
                                                                .h6size,
                                                            fontFamily:
                                                            'Gilroy-SemiBold',
                                                            color: FsColor
                                                                .darkgrey,
                                                          )),
                                                      onPressed: () {
                                                        deleteAddress(address[
                                                        "address_tag"]);
                                                        */ /* */ /*Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      ProfileView()),
                                                        );*/ /* */ /*
                                                      },
                                                    ),*/ /*
                                                      ]),
                                                ),
                                                SizedBox(
                                                  height: 20.0,
                                                  child: Divider(
                                                      color: FsColor
                                                          .darkgrey
                                                          .withOpacity(
                                                          0.2),
                                                      height: 2.0),
                                                ),
                                              ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {},
                        ),
                      );
                    },
                  ),
                );
  }*/

  initializeData() async {
    if (profileData != null && profileData["addresses"] != null) {
      print("profile address" + profileData["addresses"].toString());
      manageaddress = profileData["addresses"];
      print("manageaddress" + manageaddress.toString());
    }
  }

  /* deleteAddress(String address_tag) {
    _requestType = REQUEST_TYPE.DELETE_ADDRESS;
    presenter = new ProfilePresenter(this);
    presenter.deleteAddress(address_tag);
  }*/

  @override
  void hideProgress() {
    // TODO: implement hideProgress
  }

  @override
  void onError(String error) {
    Toasly.error(context, AppUtils.errorDecoder(jsonDecode((error))));
  }

  @override
  void onFailure(String failure) {
    Toasly.error(context, AppUtils.errorDecoder(jsonDecode((failure))));
  }

  @override
  void onSuccess(String success) {
    // TODO: implement onSuccess
    print(success);
    Toasly.success(context, success,
        duration: DurationToast.SHORT, gravity: Gravity.BOTTOM);
    if (_requestType == REQUEST_TYPE.DELETE_ADDRESS) {
      Toasly.success(context, success,
          duration: DurationToast.SHORT, gravity: Gravity.BOTTOM);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileView()),
      );
    }
  }

  @override
  void showProgress() {
    // TODO: implement showProgress
  }

  @override
  void onProfileProgress(String success) {
    // TODO: implement onProfileProgress
  }

  void deleteFromPrernceAddress(tag, BuildContext context) {
    SsoStorage.getPreferredAddress().then((onValue) {
      if (onValue != null) {
        if (tag == onValue["address_tag"]) {
          SsoStorage.setPreferredAddress(null);
        }
      }
    });
  }

  callAddAddressPage(BuildContext context) async {
    var a = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddNewAddress(profileData["addresses"])),
    );
    if (a != null) {
      SsoStorage.getUserProfile().then((onValue) {
        profileData = onValue;
        if (profileData["addresses"] != null) {
          manageaddress = profileData["addresses"];
        }
      });
    }
    setState(() {});
  }
}

/*class AddresList extends StatelessWidget {
  var manageaddress;
  bool isVerify = false;
  bool isEdit = false;

  var profileData;

  var onAddressClick;

  String noAddressText;

  var onDeleteClick;

  AddresList(this.manageaddress, this.profileData,
      {this.onAddressClick, this.noAddressText, this.onDeleteClick}) {
    if (manageaddress == null) {
      if (profileData != null && profileData["addresses"] != null) {
        print("profile address" + profileData["addresses"].toString());
        manageaddress = profileData["addresses"];
        print("manageaddress" + manageaddress.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildContainer();
  }


  Container buildContainer() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: manageaddress == null || manageaddress.isEmpty
          ? FsNoData(title: "no address", message: noAddressText,)
          : ListView.builder(
        primary: false,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: manageaddress == null
            ? 0
            : manageaddress.length,
        itemBuilder: (BuildContext context, int index) {
          Map address = manageaddress[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 1.0),
            child: InkWell(
              child: Container(
                padding: const EdgeInsets.all(0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width -
                            100,
                        child: ListView(
                          primary: false,
                          physics:
                          NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                              decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(width: 1,
                                        color: FsColor.lightgrey.withOpacity(
                                            0.2)),
                                  )
                              ),
                              child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                        child: Text(
                                          "${address["address_tag"]}"
                                              .toLowerCase(),
                                          style: TextStyle(
                                              fontFamily: 'Gilroy-SemiBold',
                                              fontSize: FSTextStyle.h5size,
                                              color: FsColor.basicprimary),
                                        ),
                                      ),
                                      subtitle: Text(
                                        "${ManageAddress.getFullAddress(
                                            address)}".toLowerCase(),
                                        style: TextStyle(
                                            fontFamily: 'Gilroy-Regular',
                                            fontSize: FSTextStyle.h6size,
                                            color: FsColor.lightgrey,
                                            height: 1.3),
                                      ),
                                      onTap: () {
                                        */ /*Address*/ /*
                                        if (onAddressClick != null) {
                                          onAddressClick(address);
                                        }
                                      },
                                    ),
                                    Container(
                                      padding:
                                      EdgeInsets.all(5),
                                      child: new Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .end,
                                          mainAxisSize:
                                          MainAxisSize
                                              .max,
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .center,
                                          children: <
                                              Widget>[
                                            isVerify
                                                ? new FlatButton(
                                              padding: EdgeInsets
                                                  .fromLTRB(
                                                  0,
                                                  0,
                                                  0,
                                                  0),
                                              child: new Text(
                                                  "Verify",
                                                  style:
                                                  TextStyle(
                                                    fontSize: FSTextStyle
                                                        .h6size,
                                                    fontFamily: 'Gilroy-SemiBold',
                                                    color: FsColor
                                                        .red,
                                                  )),
                                              onPressed:
                                                  () {
                                                Navigator
                                                    .push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProfileView()),
                                                );
                                              },
                                            )
                                                : Container(),
                                            isEdit
                                                ? new FlatButton(
                                              child: new Text(
                                                  "Edit",
                                                  style:
                                                  TextStyle(
                                                    fontSize: FSTextStyle
                                                        .h6size,
                                                    fontFamily: 'Gilroy-SemiBold',
                                                    color: FsColor
                                                        .darkgrey,
                                                  )),
                                              onPressed:
                                                  () {
                                                Navigator
                                                    .push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditAddress(
                                                              address,
                                                              profileData)),
                                                );
                                              },
                                            )
                                                : Container(),
                                            SizedBox(
                                                width:
                                                10.0),
                                            onDeleteClick == null
                                                ? Container()
                                                :
                                            new FlatButton(
                                                      child: new Text(
                                                          "Delete",
                                                          style: TextStyle(
                                                            fontSize:
                                                            FSTextStyle
                                                                .h6size,
                                                            fontFamily:
                                                            'Gilroy-SemiBold',
                                                            color: FsColor
                                                                .darkgrey,
                                                          )),
                                                      onPressed: () {
                                                        onDeleteClick(address[
                                                        "address_tag"]);

                                                        */ /*Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      ProfileView()),
                                                        );*/ /*
                                                      },
                                            ),
                                          ]),
                                    ),
                                    // SizedBox(
                                    //   child: Divider( color: FsColor.darkgrey.withOpacity(0.2),height: 1.0),
                                    // ),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }

}*/

enum REQUEST_TYPE { DELETE_ADDRESS }
