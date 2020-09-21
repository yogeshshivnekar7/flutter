import 'package:sso_futurescape/presentor/module/vizlog/my_visitor_setting/my_visitor_setting_model.dart';
import 'package:sso_futurescape/presentor/module/vizlog/my_visitor_setting/my_visitor_setting_view.dart';

class MyVisitorSettingsPresntor {
  MyVisitorSettingsView myVisitorSettingsView;

  MyVisitorSettingsPresntor(this.myVisitorSettingsView);

  void setVisitorApproval(
      String settingKey, bool settingValue, String memberId) {
    MyVisitorSettingsModule module = new MyVisitorSettingsModule();
    module.setVisitorApproval(
        settingKey, settingValue, memberId, myVisitorSettingsView);
  }

  void getVisitorApprovals() {
    print("getVisitorApprovals");
    MyVisitorSettingsModule module = new MyVisitorSettingsModule();
    module.getVisitorApprovals(myVisitorSettingsView);
  }

  void getMemberLog(String visitorId, String socId) {
    MyVisitorSettingsModule module = new MyVisitorSettingsModule();
    module.getMemberLog(visitorId, socId, myVisitorSettingsView);
  }

  void setMemberLog(String visitorId, bool isLogVisible) {
    MyVisitorSettingsModule module = new MyVisitorSettingsModule();
    module.setMemberLog(
        visitorId, isLogVisible ? "1" : "0", myVisitorSettingsView);
  }
}
