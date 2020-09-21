import 'package:common_config/utils/fs_navigator.dart';
import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/presentor/module/vizlog/my_visitor_setting/my_visitor_setting_presentor.dart';
import 'package:sso_futurescape/presentor/module/vizlog/my_visitor_setting/my_visitor_setting_view.dart';
import 'package:sso_futurescape/ui/module/recipe/widgets/progress_dialog.dart';
import 'package:sso_futurescape/ui/module/vizlog/myvisitor_trackdomestichelp.dart';
import 'package:sso_futurescape/ui/module/vizlog/myvisitors_dashboard.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class MyVisitorSettingsPage extends StatefulWidget {
  var selectedUnit;
  int abc = 1;

  MyVisitorSettingsPage(this.selectedUnit);

  @override
  _MyVisitorSettingsPageState createState() =>
      new _MyVisitorSettingsPageState(this.selectedUnit);
}

class _MyVisitorSettingsPageState extends State<MyVisitorSettingsPage>
    implements MyVisitorSettingsView {
  bool isVisitorApprovalswitch = true;
  bool isMemberLogswitch = true;
  bool _isMemberPrivacyOn = false;

  MyVisitorSettingsPresntor myVisitorSettingsPresntor;

  var selectedUnit;

  bool isLoading = true;
  String visitorId;
  static const _progressDialogTitle =
      FsString.MSG_TITLE_PROGRESS_DIALOG_UPDATE_SETTING;
  ProgressDialog _progressDialog;

  _MyVisitorSettingsPageState(this.selectedUnit);

  @override
  void initState() {
    print("initState");
    myVisitorSettingsPresntor = new MyVisitorSettingsPresntor(this);
    print(selectedUnit);
    myVisitorSettingsPresntor.getVisitorApprovals();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool useMobileLayout = shortestSide < 768.0;

    _progressDialog = spinningCubeLoadingDialog(context, _progressDialogTitle);

    return Scaffold(
        appBar: getAppBarWidget(),
        body: isLoading ? PageLoader() : getSettingsContentWidget());
  }

  Widget getAppBarWidget() {
    return AppBar(
      backgroundColor: FsColor.primaryvisitor,
      title: Text(
        "visitor settings",
        style: FSTextStyle.appbartextlight,
      ),
      leading: FsBackButtonlight(backEvent: (context) {
        backevent(context);
      }),
      actions: <Widget>[],
    );
  }

  Widget getSettingsContentWidget() {
    return ListView(
      children: getSettingsWidgetList(),
    );
  }

  List<Widget> getSettingsWidgetList() {
    return [
      getTrackDomesticHelpSettingWidget(),
      getVisitorApprovalSettingWidget(),
      getMemberLogsSettingWidget(),
      getMemberPrivacySettingsWidget()
    ];
  }

  Widget getTrackDomesticHelpSettingWidget() {
    return ListTile(
        leading: Icon(Icons.location_on),
        title: Text(
          FsString.TITLE_SETTING_TRACK_DOMESTIC_HELP.toLowerCase(),
          style: TextStyle(
            fontFamily: 'Gilroy-SemiBold',
            fontSize: FSTextStyle.h6size,
            color: FsColor.basicprimary,
          ),
        ),
        trailing: Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MyVisitorTrackDomesticHelp(selectedUnit, visitorId)),
          );
        }
        /*MyVisitorTrackDomesticHelp*/
        );
  }

  Widget getVisitorApprovalSettingWidget() {
    return SwitchListTile(
      title: Text(
        FsString.TITLE_SETTING_VISITOR_APPROVAL.toLowerCase(),
        style: TextStyle(
          fontFamily: 'Gilroy-SemiBold',
          fontSize: FSTextStyle.h6size,
          color: FsColor.basicprimary,
        ),
      ),
      subtitle: Text(isVisitorApprovalswitch
          ? FsString.INFO_SETTING_VISITOR_APPROVAL_ON
          : FsString.INFO_SETTING_VISITOR_APPROVAL_OFF),
      secondary: Icon(Icons.check_circle_outline),
      value: isVisitorApprovalswitch,
      inactiveThumbColor: FsColor.red,
      inactiveTrackColor: const Color(0xFFffb3b3),
      activeColor: FsColor.green,
      activeTrackColor: const Color(0xFF80d6aa),
      onChanged: (value) {
        isVisitorApprovalswitch = value;
        setState(() {});
        updateVisitorApprovalSetting(value);
      },
    );
  }

  Widget getMemberLogsSettingWidget() {
    return SwitchListTile(
      secondary: Icon(Icons.description),
      title: Text(
        FsString.TITLE_SETTING_MEMBER_LOGS.toLowerCase(),
        style: TextStyle(
          fontFamily: 'Gilroy-SemiBold',
          fontSize: FSTextStyle.h6size,
          color: FsColor.basicprimary,
        ),
      ),
      value: isMemberLogswitch,
      inactiveThumbColor: FsColor.red,
      inactiveTrackColor: const Color(0xFFffb3b3),
      activeColor: FsColor.green,
      activeTrackColor: const Color(0xFF80d6aa),
      onChanged: (value) {
        isMemberLogswitch = value;
        setState(() {});
        updateMembersLogSetting(value);
      },
    );
  }

  Widget getMemberPrivacySettingsWidget() {
    return SwitchListTile(
      secondary: Icon(Icons.description),
      title: Text(
        FsString.TITLE_SETTING_MEMBER_PRIVACY.toLowerCase(),
        style: TextStyle(
          fontFamily: 'Gilroy-SemiBold',
          fontSize: FSTextStyle.h6size,
          color: FsColor.basicprimary,
        ),
      ),
      subtitle: Text(_isMemberPrivacyOn
          ? FsString.INFO_SETTING_MEMBER_PRIVACY_ON
          : FsString.INFO_SETTING_MEMBER_PRIVACY_OFF),
      value: _isMemberPrivacyOn,
      inactiveThumbColor: FsColor.red,
      inactiveTrackColor: const Color(0xFFffb3b3),
      activeColor: FsColor.green,
      activeTrackColor: const Color(0xFF80d6aa),
      onChanged: (value) {
        _isMemberPrivacyOn = value;
        setState(() {});
        updateMemberPrivacySetting(value);
      },
    );
  }

  void updateVisitorApprovalSetting(bool settingValue) {
    AppUtils.checkInternetConnection().then((value) {
      if (value) {
        _progressDialog.show().then((value) {
          if (value) {
            myVisitorSettingsPresntor.setVisitorApproval(
                FsString.KEY_SETTING_VISITOR_APPROVAL,
                settingValue,
                curentVisitorUnitApproval["member_id"].toString());
          }
        });
      } else {
        Toasly.error(context, FsString.ERROR_NO_INTERNET);
      }
    });
  }

  void updateMembersLogSetting(bool settingValue) {
    AppUtils.checkInternetConnection().then((value) {
      if (value) {
        _progressDialog.show().then((value) {
          if (value) {
            myVisitorSettingsPresntor.setMemberLog(visitorId, settingValue);
          }
        });
      } else {
        Toasly.error(context, FsString.ERROR_NO_INTERNET);
      }
    });
  }

  void updateMemberPrivacySetting(bool settingValue) {
    AppUtils.checkInternetConnection().then((value) {
      if (value) {
        _progressDialog.show().then((value) {
          if (value) {
            myVisitorSettingsPresntor.setVisitorApproval(
                FsString.KEY_SETTING_MEMBER_PRIVACY,
                settingValue,
                curentVisitorUnitApproval["member_id"].toString());
          }
        });
      } else {
        Toasly.error(context, FsString.ERROR_NO_INTERNET);
      }
    });
  }

  @override
  onErrorUnitsApprovals(String error) {
    Toasly.error(context, AppUtils.errorDecoder(error));
    isLoading = false;
    setState(() {});
  }

  @override
  onFailedUnitsApprovals(failure) {
    isLoading = false;
    setState(() {});
  }

  var curentVisitorUnitApproval;

  @override
  onSuccessUnitsApprovals(List units) {
    for (var unit in units) {
      var userUnit = unit["unit"];
      if (userUnit["building_unit_id"].toString() ==
          selectedUnit["unit_id"].toString()) {
        if (unit["visitor_verify"] == 0) {
          isVisitorApprovalswitch = false;
        } else {
          isVisitorApprovalswitch = true;
        }
        _isMemberPrivacyOn = unit["privacy_config"] == 1;
        curentVisitorUnitApproval = unit;
        break;
      }
    }
    setState(() {});
    SsoStorage.getVizProfile().then((profile) {
      print(profile);
      this.visitorId = profile["data"]["users"]["visitor_id"].toString();
      myVisitorSettingsPresntor.getMemberLog(
          visitorId, selectedUnit["soc_id"].toString());
    });
  }

  @override
  void onErrorApproved(String error, String settingKey) {
    if (FsString.KEY_SETTING_VISITOR_APPROVAL == settingKey) {
      isVisitorApprovalswitch = !isVisitorApprovalswitch;
    } else if (FsString.KEY_SETTING_MEMBER_PRIVACY == settingKey) {
      _isMemberPrivacyOn = !_isMemberPrivacyOn;
    }
    Toasly.error(context, AppUtils.errorDecoder(error));
    setState(() {});
    _progressDialog.hide();
  }

  @override
  void onFailedApproved(failure, String settingKey) {
    if (FsString.KEY_SETTING_VISITOR_APPROVAL == settingKey) {
      isVisitorApprovalswitch = !isVisitorApprovalswitch;
    } else if (FsString.KEY_SETTING_MEMBER_PRIVACY == settingKey) {
      _isMemberPrivacyOn = !_isMemberPrivacyOn;
    }
    Toasly.error(context, AppUtils.errorDecoder(failure));
    setState(() {});
    _progressDialog.hide();
  }

  @override
  void onSuccessApproved(message, String settingKey) {
    _progressDialog.hide();
  }

  @override
  void onErrorMemberLog(String error) {
    Toasly.error(context, AppUtils.errorDecoder(error));
    isLoading = false;
    setState(() {});
  }

  @override
  void onFailedMemberLog(failure) {
    isLoading = false;
    Toasly.error(context, AppUtils.errorDecoder(failure));
    setState(() {});
  }

  @override
  void onSuccessMemberLog(approved) {
    isLoading = false;
    if (approved != null) {
      if (approved["is_log_visible"].toString() == "0") {
        isMemberLogswitch = false;
      } else {
        isMemberLogswitch = true;
      }
    }
    setState(() {});
  }

  @override
  void onErrorMemeberLoggedOnOff(String error) {
    isMemberLogswitch = !isMemberLogswitch;
    Toasly.error(context, AppUtils.errorDecoder(error));
    setState(() {});
    _progressDialog.hide();
  }

  @override
  void onFailedMemeberLoggedOnOff(failure) {
    print(failure);
    isMemberLogswitch = !isMemberLogswitch;
    Toasly.error(context, AppUtils.errorDecoder(failure));
    setState(() {});
    _progressDialog.hide();
  }

  @override
  void onSuccessMemeberLoggedOnOff(approved) {
    _progressDialog.hide();
  }


  backevent(BuildContext context) {
    FsNavigator.push(context, MyVisitorsDashboard());
  }
}
