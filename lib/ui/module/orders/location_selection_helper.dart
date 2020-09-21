import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/restaurant/online_order_webview.dart';
import 'package:sso_futurescape/ui/module/sso/profile/add_new_address.dart';
import 'package:sso_futurescape/ui/module/sso/profile/address_list_widget.dart';
import 'package:sso_futurescape/ui/module/sso/profile/select_current_location.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/utils/permission/permission_service.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class LocationSelectionHelper {
  void locationPermission(BuildContext context, bool locationMen,
      {Function onSuccess,
      Function permissionDined,
      Function deniedForever,
      Function serviceEnabled}) async {
    var location = new Location();
    var hasPer = await location.hasPermission();
    print("hasPer");
    print(hasPer);
    if (hasPer == PermissionStatus.denied ||
        hasPer == PermissionStatus.deniedForever) {
      permissionDined();
      bool a = await PermissionsService1().isForverLocationPermission();
      if (a) {
        deniedForever();
        if (locationMen) {
          PermissionsService1().showDeleteAlertDialog(context);
        }
      } else {
        var reqPer = await PermissionsService1().requestLocationPermission();
        if (reqPer) {
          onSuccess();
          bool a = await location.serviceEnabled();
          if (!a) {
            bool b = await location.requestService();
            serviceEnabled(b);
          } else {
            serviceEnabled(a);
          }
        } else {
          bool a = await PermissionsService1().isForverLocationPermission();
          if (a) {
            deniedForever();
          } else {
            permissionDined();
          }
        }
      }
    } else {
      onSuccess();
      var reqPer = await PermissionsService1().requestLocationPermission();
      if (reqPer) {
        onSuccess();
        bool a = await location.serviceEnabled();
        if (!a) {
          bool b = await location.requestService();
          serviceEnabled(b);
        } else {
          serviceEnabled(a);
        }
      } else {
        bool a = await PermissionsService1().isForverLocationPermission();
        if (a) {
          deniedForever();
        } else {
          permissionDined();
        }
      }
    }
  }

  void getLocationBottomSheeOrCurrentLocation(
      BuildContext context,
      bool isLocationMen,
      Function onSuccessAddressFound,
      Function failedAddress,
      {var businessAppMode,
      bool isOnlyLocationSelection = false,
      var addresses,
      bool cancelable = true,
      Function getTypeNameFound,
      bool isCurrentSelectionAddressRequred = true}) {
    locationPermission(
      context,
      isLocationMen,
      onSuccess: () {},
      permissionDined: () {},
      deniedForever: () {},
      serviceEnabled: (bool b) async {
        if (b) {
          if (!isOnlyLocationSelection) {
            locationModalBottomSheet(context, (var address) {
              //SUcesss
              onSuccessAddressFound(address);
            }, () {
              //failed
              failedAddress();
            },
                businessAppMode: businessAppMode,
                addresses: addresses,
                cancelable: cancelable,
                getTypeNameFound: getTypeNameFound,
                isCurrentSelectionAddressRequred:
                    isCurrentSelectionAddressRequred);
          } else {
            var result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SelectCurrentLocation(
                      OnlineOrderWebViewState.backgroundColor(
                          businessAppMode))),
            );
            if (result != null && result.containsKey('selection')) {
              onSuccessAddressFound(result['selection']);
            } else {
              failedAddress();
            }
          }
        }
      },
    );
  }

  void locationModalBottomSheet(context, Function onSuccess, Function onFailed,
      {cancelable = true,
      isCurrentSelectionAddressRequred = true,
      Function getTypeNameFound,
      var addresses,
      var businessAppMode}) {
    SsoStorage.getUserProfile().then((_userProfie) {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          isDismissible: cancelable ? false : true,
          builder: (BuildContext context) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Location',
                          style: TextStyle(
                            fontSize: FSTextStyle.h5size,
                            fontFamily: 'Gilroy-SemiBold',
                            color: FsColor.darkgrey,
                          ),
                        ),
                        Container(
                          width: 50,
                          child: FlatButton(
                              onPressed: () {
                                if (cancelable == false) {
                                  Toasly.warning(
                                      context, "add at least one address");
                                } else {
                                  onFailed();
                                  Navigator.pop(context);
                                }
                              },
                              child: Icon(
                                FlutterIcon.cancel_1,
                                size: FSTextStyle.h6size,
                                color: FsColor.basicprimary,
                              )),
                        ),
                      ],
                    ),
                  ),
                  isCurrentSelectionAddressRequred
                      ? Container(
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                                width: 1,
                                color: FsColor.lightgrey.withOpacity(0.2)),
                          )),
                          // margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          height: 40,
                          child: FlatButton(
                            onPressed: () async {
                              var result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SelectCurrentLocation(
                                        OnlineOrderWebViewState.backgroundColor(
                                            businessAppMode))),
                              );
                              if (result != null &&
                                  result.containsKey('selection')) {
                                onSuccess(result['selection']);
                                Navigator.pop(context);
                              } else {
                                onFailed();
                                Navigator.pop(context);
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.my_location,
                                  size: FSTextStyle.h4size,
                                  color: FsColor.primaryvisitor,
                                ),
                                SizedBox(width: 15),
                                Text(
                                  'Use Current Location'.toLowerCase(),
                                  style: TextStyle(
                                      fontFamily: 'Gilroy-SemiBold',
                                      fontSize: FSTextStyle.h5size,
                                      color: FsColor.primaryvisitor),
                                ),
                              ],
                            ),
                          ))
                      : Container(),
                  Container(
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                            width: 1,
                            color: FsColor.lightgrey.withOpacity(0.2)),
                      )),
                      // margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      height: 40,
                      child: FlatButton(
                        onPressed: () {
                          addAddress(context, _userProfie, onSuccess);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.add,
                              size: FSTextStyle.h3size,
                              color: FsColor.primaryvisitor,
                            ),
                            SizedBox(width: 15),
                            Text(
                              'add address'.toLowerCase(),
                              style: TextStyle(
                                  fontFamily: 'Gilroy-SemiBold',
                                  fontSize: FSTextStyle.h5size,
                                  color: FsColor.primaryvisitor),
                            ),
                          ],
                        ),
                      )),
                  Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                    children: <Widget>[
                      AddresList(null, _userProfie, onAddressClick: (address1) {
                        onSuccess(address1);
                        Navigator.pop(context);
                      },
                          noAddressText: getTypeNameFound != null
                              ? "add address to search ${getTypeNameFound()} you"
                              : "no addresses found \n save addresses to make home delivery more convenient."),
                    ],
                  )))
                ],
              ),
            );
          });
    });
  }

  Future<void> addAddress(
      BuildContext context, Map _userProfie, Function onSuccess) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddNewAddress(_userProfie["addresses"])),
    );
    if (result != null) {
      SsoStorage.getUserProfile().then((onValue) {
        _userProfie = onValue;
        if (_userProfie["addresses"] != null) {
          List addresses = _userProfie["addresses"]
              .where((element) =>
                  element["latitude"] != null && element["latitude"] != "null")
              .toList();
          if (addresses.length > 0) {
            onSuccess(addresses[addresses.length - 1]);
          }
          Navigator.pop(context);
        }
      });
    }
  }
}
