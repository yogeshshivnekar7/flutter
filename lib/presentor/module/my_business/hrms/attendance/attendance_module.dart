import 'dart:collection';

import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/hrms_api.dart';

class AttendanceModel {
  RequestAttendanceModelResponse _attendanceModelResponse;

  AttendanceModel(this._attendanceModelResponse);

  punchAttendance(HashMap hashMap) async {
    NetworkHandler netwrkHandler = new NetworkHandler(
            (response) => {_attendanceModelResponse.onSuccess(response)},
            (response) => {_attendanceModelResponse.onFailure(response)},
            (response) => {_attendanceModelResponse.onError(response)});

    Network networkt =
    await HRMSAPIHandler.punchAttendance(hashMap, netwrkHandler);
    networkt.excute();
  }

  trackLocation(HashMap hashMap) async {
    NetworkHandler netwrkHandler = new NetworkHandler(
            (response) => {_attendanceModelResponse.onSuccess(response)},
            (response) => {_attendanceModelResponse.onFailure(response)},
            (response) => {_attendanceModelResponse.onError(response)});

    Network networkt =
    await HRMSAPIHandler.trackLocation(hashMap, netwrkHandler);
    networkt.excute();
  }

  getAttendance(HashMap hashMap) async {
    NetworkHandler netwrkHandler = new NetworkHandler(
            (response) => {_attendanceModelResponse.onSuccess(response)},
            (response) => {_attendanceModelResponse.onFailure(response)},
            (response) => {_attendanceModelResponse.onError(response)});

    Network networkt =
    await HRMSAPIHandler.getAttendance(hashMap, netwrkHandler);
    networkt.excute();
  }
}

abstract class RequestAttendanceModelResponse {
  void onSuccess(String response);

  void onError(String error);

  void onFailure(String error);
}
