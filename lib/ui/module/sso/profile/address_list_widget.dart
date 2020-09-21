import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/sso/profile/edit_address.dart';
import 'package:sso_futurescape/ui/module/sso/profile/manage_address.dart';
import 'package:sso_futurescape/ui/module/sso/profile/profile_view.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/ui/widgets/no_data.dart';
import 'package:sso_futurescape/utils/fsshare.dart';

class AddresList extends StatelessWidget {
  var manageaddress;
  bool isVerify = false;
  bool isEdit = false;

  var profileData;

  var onAddressClick;

  String noAddressText;

  var onDeleteClick;
  bool isLatLongMendory;

  AddresList(
    this.manageaddress,
    this.profileData, {
    this.onAddressClick,
    this.noAddressText,
    this.onDeleteClick,
    this.isLatLongMendory,
  }) {
    if (manageaddress == null) {
      if (profileData != null && profileData["addresses"] != null) {
        print("profile address" + profileData["addresses"].toString());
        manageaddress = profileData["addresses"];
        manageaddress = manageaddress
            .where((element) =>
                element["latitude"] != null && element["latitude"] != "null")
            .toList();
        print("manageaddress" + manageaddress.toString());
      }
    } else {
      manageaddress = manageaddress
          .where((element) =>
              element["latitude"] != null && element["latitude"] != "null")
          .toList();
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
          ? FsNoData(
              title: false,
              message:
                  "no addresses found \n save addresses to make home delivery more convenient.",
            )
          : ListView.builder(
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: manageaddress == null ? 0 : manageaddress.length,
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
                              width: MediaQuery.of(context).size.width - 100,
                              child: ListView(
                                primary: false,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                                    decoration: BoxDecoration(
                                        border: Border(
                                      bottom: BorderSide(
                                          width: 1,
                                          color: FsColor.lightgrey
                                              .withOpacity(0.2)),
                                    )),
                                    child: Column(children: <Widget>[
                                      ListTile(
                                        leading: Container(
                                          child: Icon(
                                            getIconForTag(
                                                address["address_tag"]),
                                            size: FSTextStyle.h2size,
                                            color: FsColor.lightgrey,
                                          ),
                                          padding:
                                              EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        ),
                                        title: Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 0, 0, 5),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                "${address["address_tag"]}"
                                                    .toLowerCase(),
                                                style: TextStyle(
                                                    fontFamily:
                                                        'Gilroy-SemiBold',
                                                    fontSize:
                                                        FSTextStyle.h5size,
                                                    color:
                                                        FsColor.basicprimary),
                                              )
                                            ],
                                          ),
                                        ),
                                        subtitle: Text(
                                          "${ManageAddress.getFullAddress(address)}"
                                              .toLowerCase(),
                                          style: TextStyle(
                                              fontFamily: 'Gilroy-Regular',
                                              fontSize: FSTextStyle.h6size,
                                              color: FsColor.lightgrey,
                                              height: 1.3),
                                        ),
                                        onTap: () {
                                          /*Address*/
                                          if (onAddressClick != null) {
                                            onAddressClick(address);
                                          }
                                        },
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        child: new Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              isVerify
                                                  ? new FlatButton(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              0, 0, 0, 0),
                                                      child: new Text("Verify",
                                                          style: TextStyle(
                                                            fontSize:
                                                                FSTextStyle
                                                                    .h6size,
                                                            fontFamily:
                                                                'Gilroy-SemiBold',
                                                            color: FsColor.red,
                                                          )),
                                                      onPressed: () {
                                                        Navigator.push(
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
                                                      child: new Text("Edit",
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
                                                        Navigator.push(
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
                                              SizedBox(width: 10.0),
                                              onDeleteClick == null
                                                  ? Container()
                                                  : new FlatButton(
                                                      child: new Text("Share",
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
                                                        shareAddress(
                                                            context, address);
                                                        /*onDeleteClick(address[
                                                        "address_tag"]);*/
                                                        /* Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      ProfileView()),
                                                        );*/
                                                      },
                                                    ),
                                              onDeleteClick == null
                                                  ? Container()
                                                  : new FlatButton(
                                                      child: new Text("Delete",
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
                                                        /* Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      ProfileView()),
                                                        );*/
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

  IconData getIconForTag(String tag) {
    if (tag.trim().contains("home")) {
      return FlutterIcon.home;
    } else if (tag.trim().contains("work")) {
      return FlutterIcon.building;
    } else {
      return FlutterIcon.location_1;
    }
  }

  void shareAddress(BuildContext context, Map<dynamic, dynamic> address) {
    String addressFull = ManageAddress.getFullAddress(address).toLowerCase();
    addressFull= addressFull +
        "\n https://www.google.com/maps/search/?api=1&query=${address["latitude"]},${address["longitude"]}";
    FsShare().myShare(context, addressFull, subject: "");
  }
}
