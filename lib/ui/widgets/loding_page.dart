import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sso_futurescape/presentor/module/sso/complex_list/switch_complex.dart';
import 'package:sso_futurescape/presentor/module/sso/profile/profile_presenter.dart';
import 'package:sso_futurescape/presentor/module/sso/profile/profile_view.dart';
import 'package:sso_futurescape/ui/module/sso/dashboard/main_dashboard.dart';
import 'package:sso_futurescape/ui/module/sso/signup/username.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/utils/app_constant.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';
import 'package:sso_futurescape/utils/user_util.dart';
import 'package:facebook_analytics_plugin/facebook_analytics_plugin.dart';



class LoadingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoadingState();
  }
}

class LoadingState extends State<LoadingPage>
    implements ProfileResponseView, IUnitsDetails {
  SwitchComplexPresentor switchComplexPresentor;

  @override
  void initState() {
    super.initState();
    ProfilePresenter presenter = new ProfilePresenter(this);
    presenter.getProfileDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: PageLoader(),);
  }

  @override
  void hideProgress() {}

  @override
  void onError(String error) {
    print(error);
    print("onErroronErroronError");
  }

  @override
  void onSuccess(String success) {
    print(success);
    getSelectedUnit();
  }

  void getSelectedUnit() {
    UserUtils.getCurrentUnits().then((unit) {
      print("************************************");
      print(unit);
      if (unit == null) {
        switchComplexPresentor = SwitchComplexPresentor();
        switchComplexPresentor.getCombineUnits(this);
      } else {
//        FsSocket().connectSocket01();
        openDashboard();
      }
    });
  }

  @override
  void showProgress() {

  }

  @override
  void onFailure(String failure) {
    print("rrrrrrrrrrrrrrrrrrrrrrrr");
    var failureVar = jsonDecode(failure);
    if (failureVar["status_code"] == 401) {
      SsoStorage.setLogin("false");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => UsernamePage(null)),
              (Route<dynamic> route) => false);
    }
  }

  @override
  void onProfileProgress(String success) {

  }

  void openDashboard() {
//    Navigator.pushNamed(context, '/dashboard');
    //FacebookAnalyticsPlugin.logAchievedLevel(level: "OPENED DASHBOARD");

    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => MainDashboard()),
            (Route<dynamic> route) => false);
  }

  @override
  void unitError(data) {
    openDashboard();
  }


  @override
  void unitFailed(data) {
    openDashboard();
  }

  @override
  void unitSuccess(data, {String from}) {
    print(
        "----------------------------------------unitSuccess---------------------$data----------------------------------$from");
    print(data);
    print(from);

    if (data != null) {
      for (var u in data) {
        if (u["active"]) {
          if (from == AppConstant.CHSONE) {
            SsoStorage.setDefaultChsoneUnit(u);

            SsoStorage.getAllVizLogUnit().then((vizlogUnits) {
              if (vizlogUnits != null) {
                bool commonUnit = false;
                for (var vizUnit in vizlogUnits) {
                  if (vizUnit["active"]) {
                    if (u["building"] == vizUnit["building"]) {
                      commonUnit = true;
                      SsoStorage.setDefaultVizlogUnit(vizUnit);
                      break;
                    }
                  }
                }
                if (!commonUnit) {
                  for (var vizUnit in vizlogUnits) {
                    if (vizUnit["active"]) {
                      SsoStorage.setDefaultVizlogUnit(vizUnit);
//                      FsSocket().connectSocket01();
                      break;
                    }
                  }
                }
              }
            });
          } else {
            SsoStorage.setDefaultVizlogUnit(u);
          }
          break;
        }
//        complex.add(com);
      }

    }
    openDashboard();
  }
}
