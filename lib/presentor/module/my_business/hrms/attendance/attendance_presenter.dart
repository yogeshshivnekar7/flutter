import 'dart:collection';

import 'package:sso_futurescape/presentor/module/my_business/hrms/attendance/attendance_module.dart';
import 'package:sso_futurescape/presentor/module/my_business/hrms/attendance/attendance_view.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class AttendancePresenter extends RequestAttendanceModelResponse {
  AttendanceView _hrmsLoginView;

  AttendancePresenter(this._hrmsLoginView);

  punchAttendance(String type) async {
    AttendanceModel model = new AttendanceModel(this);
    HashMap<String, String> hashMap = new HashMap();
    hashMap["access_token"] = await getHRMSAccessToken();
    hashMap['punch_type'] = type;
    model.punchAttendance(hashMap);
  }

  getAttendance(String type) async {
    /* AttendanceModel model = new AttendanceModel(this);
    HashMap<String, String> hashMap=new HashMap();
    hashMap["access_token"] = await getHRMSAccessToken();
    model.getAttendance(hashMap);*/
    Map a = await SsoStorage.getPunchAttendance(AppUtils.getCurrentDate());
    print(a);
    _hrmsLoginView.getAttendanceSuccess(a);
  }

  trackLocation(String location_name, String latitude, String longitude) async {
    AttendanceModel model = new AttendanceModel(this);
    HashMap<String, String> hashMap = new HashMap();
    hashMap["access_token"] = await getHRMSAccessToken();
    hashMap["location_name"] = location_name;
    hashMap["latitude"] = latitude;
    hashMap["longitude"] = latitude;
    model.trackLocation(hashMap);
  }

  @override
  void onError(String error) {
    _hrmsLoginView.onAttendanceError(error);
  }

  @override
  void onFailure(String error) {
    _hrmsLoginView.onAttendanceFailure(error);
  }

  @override
  void onSuccess(String response) {
    _hrmsLoginView.onAttendanceSuccess(response);
  }

  static Future<String> getHRMSAccessToken() async {
    var aa = await SsoStorage.getHRMSToken();
    print(aa);
    return aa['data']['access_token'];
  }
}
