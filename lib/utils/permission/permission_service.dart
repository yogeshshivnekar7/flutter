import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sso_futurescape/config/colors/color.dart';

class PermissionsService1 {
  /*Future<bool> _requestPermission(Permission permission) async {
    final Permission _permissionHandler = Permission();
    var result = await _permissionHandler.request().requestPermissions([permission]);
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }Future*/

/*  Future<bool> requestContactsPermission({Function onPermissionDenied}) async {
    var granted = await _requestPermission(PermissionGroup.contacts);
    if (!granted) {
      onPermissionDenied();
    }
    return granted;
  }*/

  Future<bool> requestStoragePermission(
      /*{Function onPermissionDenied, Function onPermissionGranted}*/) async {
    PermissionStatus hsPersmition = await Permission.storage.status;
    //bool hsPersmition = await hasPermission(PermissionGroup.storage);
    if (hsPersmition.isGranted) {
      return Future.value(true);
    } else {
      PermissionStatus hsPersmition = await Permission.storage.request();
      if (hsPersmition.isGranted) {
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    }
  }

  Future<bool> requestPhotosPermission(
      /*{Function onPermissionDenied, Function onPermissionGranted}*/) async {
    PermissionStatus hsPersmition;
    if (Platform.isIOS) {
      hsPersmition = await Permission.photos.status;
    } else {
      hsPersmition = await Permission.storage.status;
    }
    //bool hsPersmition = await hasPermission(PermissionGroup.storage);
    if (hsPersmition.isGranted) {
      return Future.value(true);
    } else {
      PermissionStatus hsPersmition;
      if (Platform.isIOS) {
        hsPersmition = await Permission.photos.request();
      } else {
        hsPersmition = await Permission.storage.request();
      }
      if (hsPersmition.isGranted) {
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    }
  }

  Future<bool> requestCameraPermission(
      /*{Function onPermissionDenied, Function onPermissionGranted}*/) async {
    PermissionStatus hsPersmition = await Permission.camera.status;
    //bool hsPersmition = await hasPermission(PermissionGroup.storage);
    if (hsPersmition.isGranted) {
      return Future.value(true);
    } else {
      PermissionStatus hsPersmition = await Permission.camera.request();
      if (hsPersmition.isGranted) {
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    }
  }

  Future<bool> requestContactPermission(
      /*{Function onPermissionDenied, Function onPermissionGranted}*/) async {
    PermissionStatus hsPersmition = await Permission.contacts.status;

    if (hsPersmition.isGranted) {
      return Future.value(true);
    } else {
      PermissionStatus hsPersmition = await Permission.contacts.request();
      if (hsPersmition.isGranted) {
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    }
  }

  Future<bool> requestLocationPermission(
      /*{Function onPermissionDenied, Function onPermissionGranted}*/) async {
    PermissionStatus hsPersmition = await Permission.location.status;
    print("cfcrfdcrtdtrdrtd--------");
    print(hsPersmition);
    //bool hsPersmition = await hasPermission(PermissionGroup.storage);
    if (hsPersmition.isGranted) {
      return Future.value(true);
    } else {
      PermissionStatus hsPersmition = await Permission.location.request();
      if (hsPersmition.isGranted) {
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    }
  }

  Future<bool> requestPhonePermission(
      /*{Function onPermissionDenied, Function onPermissionGranted}*/) async {
    PermissionStatus hsPersmition = await Permission.phone.status;
    print("cfcrfdcrtdtrdrtd--------");
    print(hsPersmition);
    //bool hsPersmition = await hasPermission(PermissionGroup.storage);
    if (hsPersmition.isGranted) {
      return Future.value(true);
    } else {
      PermissionStatus hsPersmition = await Permission.phone.request();
      if (hsPersmition.isGranted) {
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    }
  }

  Future<bool> isForverLocationPermission(
      /*{Function onPermissionDenied, Function onPermissionGranted}*/) async {
    PermissionStatus hsPersmition = await Permission.location.status;
    print("cfcrfdcrtdtrdrtd");
    print(hsPersmition);
    //bool hsPersmition = await hasPermission(PermissionGroup.storage);
    if (hsPersmition.isPermanentlyDenied ||
        hsPersmition.isRestricted ||
        (Platform.isIOS && hsPersmition.isDenied)) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  void showDeleteAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
            backgroundColor: Colors.white,
            title: new Text("Allow access to location",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Gilroy-SemiBold',
                    fontSize: FSTextStyle.h4size,
                    color: FsColor.darkgrey)),
            shape: new RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: new BorderRadius.circular(7.0),
            ),
            content: new Text(
                "Permission to detect your location is denied. "
                        "To proceed, kindly allow access by changing the permission setting."
                    .toLowerCase(),
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Gilroy-Regular',
                    fontSize: FSTextStyle.h6size,
                    color: Colors.grey[600])),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  openSetting(context);
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                },
                child: Text(
                  "Open Setting",
                  style: TextStyle(
                      fontFamily: 'Gilroy-SemiBold',
                      fontSize: FSTextStyle.h5size,
                      color: FsColor.black),
                ),
              )
            ],
          );
        });
  }

  void showPermissionPhotosAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
            backgroundColor: Colors.white,
            title: new Text("Allow access to photos",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Gilroy-SemiBold',
                    fontSize: FSTextStyle.h4size,
                    color: FsColor.darkgrey)),
            shape: new RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: new BorderRadius.circular(7.0),
            ),
            content: new Text(
                "Please allow permission to access photos. "
                    "To proceed, kindly allow access by changing the permission setting."
                    .toLowerCase(),
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Gilroy-Regular',
                    fontSize: FSTextStyle.h6size,
                    color: Colors.grey[600])),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  openSetting(context);
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                },
                child: Text(
                  "Open Settings",
                  style: TextStyle(
                      fontFamily: 'Gilroy-SemiBold',
                      fontSize: FSTextStyle.h5size,
                      color: FsColor.black),
                ),
              )
            ],
          );
        });
  }

  void showPermissionCameraAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
            backgroundColor: Colors.white,
            title: new Text("Allow access to camera",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Gilroy-SemiBold',
                    fontSize: FSTextStyle.h4size,
                    color: FsColor.darkgrey)),
            shape: new RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: new BorderRadius.circular(7.0),
            ),
            content: new Text(
                "Please allow permission to access camera. "
                    "To proceed, kindly allow access by changing the permission setting."
                    .toLowerCase(),
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Gilroy-Regular',
                    fontSize: FSTextStyle.h6size,
                    color: Colors.grey[600])),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  openSetting(context);
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                },
                child: Text(
                  "Open Settings",
                  style: TextStyle(
                      fontFamily: 'Gilroy-SemiBold',
                      fontSize: FSTextStyle.h5size,
                      color: FsColor.black),
                ),
              )
            ],
          );
        });
  }

  void showPermissionPhoneAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
            backgroundColor: Colors.white,
            title: new Text("Allow access to phone call",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Gilroy-SemiBold',
                    fontSize: FSTextStyle.h4size,
                    color: FsColor.darkgrey)),
            shape: new RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: new BorderRadius.circular(7.0),
            ),
            content: new Text(
                "Please allow permission to make a call "
                    "To proceed, kindly allow access by changing the permission setting."
                    .toLowerCase(),
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Gilroy-Regular',
                    fontSize: FSTextStyle.h6size,
                    color: Colors.grey[600])),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  openSetting(context);
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                },
                child: Text(
                  "Open Setting",
                  style: TextStyle(
                      fontFamily: 'Gilroy-SemiBold',
                      fontSize: FSTextStyle.h5size,
                      color: FsColor.black),
                ),
              )
            ],
          );
        });
  }

  void openSetting(BuildContext context) {
    AppSettings.openAppSettings();
  }

/*Future<bool> hasPermission(PermissionGroup permission) async {
    final PermissionHandler _permissionHandler = PermissionHandler();
    var permissionStatus =
    await _permissionHandler.checkPermissionStatus(permission);
    return permissionStatus == PermissionStatus.granted;
  }*/

/*Future<bool> requestContactsPermission() async {
    return _requestPermission(PermissionGroup.contacts);
  }*/

/*Future<bool> requestLocationPermission() async {
    return _requestPermission(PermissionGroup.locationWhenInUse);
  }*/
}
