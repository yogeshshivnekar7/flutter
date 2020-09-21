
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/ui/module/meeting/pojo/meet_vote_pojos.dart';
import 'package:sso_futurescape/ui/module/meeting/utils/meet_vote_utils.dart';
import 'package:sso_futurescape/utils/app_utils.dart';

class MeetVoteParser {

  ApiData parseParticipantList(var responseObj) {
    ApiData apiData = ApiData();

    var dataObj = responseObj != null ? responseObj["data"] : null;
    List participantArray = dataObj != null ? dataObj["participants"] : null;
    if (responseObj == null || dataObj == null || participantArray == null) {
      apiData.dataLoadMsg = FsString.ERROR_UNKNOWN_RETRY;
      apiData.errorInDataLoad = true;
      return apiData;
    }

    if (participantArray.isEmpty) {
      apiData.dataLoadMsg = FsString.ERROR_EMPTY_MEETINGS;
      apiData.errorInDataLoad = false;
      apiData.data = [];
      return apiData;
    }

    List participantList = [];
    for (var participantObj in participantArray) {
      String firstName = participantObj["first_name"];
      String lastName = participantObj["last_name"];
      String fullName = MeetVoteUtils.getFullName(firstName, lastName);
      participantList.add({
        "id": participantObj["_id"],
        "user_id": participantObj["user_id"],
        "mobile": participantObj["mobile"],
        "email": participantObj["email"],
        "first_name": participantObj["first_name"],
        "last_name": participantObj["last_name"],
        "full_name": fullName,
        "role": participantObj["role"]
      });
    }

    apiData.data = participantList;
    apiData.dataLoadMsg = null;
    apiData.errorInDataLoad = false;

    return apiData;
  }

  ApiData parseAgendaList(var responseObj) {
    ApiData apiData = ApiData();

    var dataObj = responseObj != null ? responseObj["data"] : null;
    List agendaArray = dataObj != null ? dataObj["agendas"] : null;
    if (responseObj == null || dataObj == null || agendaArray == null) {
      apiData.dataLoadMsg = FsString.ERROR_UNKNOWN_RETRY;
      apiData.errorInDataLoad = true;
      return apiData;
    }

    if (agendaArray.isEmpty) {
      apiData.dataLoadMsg = FsString.ERROR_EMPTY_MEETINGS;
      apiData.errorInDataLoad = false;
      apiData.data = [];
      return apiData;
    }

    List agendaList = [];
    for (var agendaObj in agendaArray) {
      agendaList.add({
        "id": agendaObj["_id"],
        "status": agendaObj["status"],
        "user_id": agendaObj["user_id"],
        "description": agendaObj["description"],
        "conclusion": agendaObj["conclusion"],
        "plan_duration": agendaObj["plan_duration"],
        "suggestion": agendaObj["suggestion"],
        "suggestions": agendaObj["suggestions"]
      });
    }

    apiData.data = agendaList;
    apiData.dataLoadMsg = null;
    apiData.errorInDataLoad = false;

    return apiData;
  }

  static ApiData parseMeetingDetails(var responseObj) {
    ApiData apiData = ApiData();

    if (responseObj == null) {
      apiData.errorInDataLoad = true;
      apiData.dataLoadMsg = FsString.ERROR_LOAD_MEETING_DETAILS;
      return apiData;
    }

    var dataObj = responseObj["data"];
    if (dataObj == null) {
      apiData.errorInDataLoad = true;
      apiData.dataLoadMsg = FsString.ERROR_LOAD_MEETING_DETAILS;
      return apiData;
    }

    String startDate = dataObj["date"];
    String fStartDate = AppUtils.getConvertDate(startDate,
        date_from_format: null, date_to_formate: AppUtils.DATE_FORM_DD_MMM_YYYY);

    String endDate = dataObj["date"];
    String fEndDate = AppUtils.getConvertDate(endDate,
        date_from_format: null, date_to_formate: AppUtils.DATE_FORM_DD_MMM_YYYY);

    String startTime = dataObj["start_time_local"];
    String fStartTime = AppUtils.getConvertDate(startTime,
        date_from_format: null, date_to_formate: AppUtils.TIME_FORM_HH_MM_A);

    String endTime = dataObj["end_time_local"];
    String fEndTime = AppUtils.getConvertDate(endTime,
        date_from_format: null, date_to_formate: AppUtils.TIME_FORM_HH_MM_A);

    apiData.data = {
      "id": dataObj["meeting_id"],
      "title": dataObj["title"],
      "description": (dataObj["description"]?.toString()?.trim() ?? ""),
      "start_date": fStartDate,
      "end_date": fEndDate,
      "start_time": fStartTime,
      "end_time": fEndTime
    };
    apiData.dataLoadMsg = null;
    apiData.errorInDataLoad = false;

    return apiData;
  }

  static ApiData parseMeetingList(int page, var responseObj) {
    ApiData apiData = ApiData();

    if (page == 1) {
      apiData.dataLoadMsg = null;
      apiData.errorInDataLoad = false;
    } else {
      apiData.dataLoadMsg = null;
      apiData.errorInDataLoad = false;
    }

    var dataObj = responseObj != null ? responseObj["data"] : null;
    apiData.metadata = dataObj != null ? dataObj["metadata"] : null;
    List resultsArray = dataObj != null ? dataObj["results"] : null;

    if (responseObj == null || dataObj == null || resultsArray == null) {
      if (page == 1) {
        apiData.dataLoadMsg = FsString.ERROR_UNKNOWN_RETRY;
        apiData.errorInDataLoad = true;
      } else {
        apiData.dataLoadMsg = null;
        apiData.errorInDataLoad = false;
      }
      return apiData;
    }

    if (resultsArray.isEmpty) {
      if (page == 1) {
        apiData.dataLoadMsg = FsString.ERROR_EMPTY_MEETINGS;
        apiData.errorInDataLoad = false;
      } else {
        apiData.dataLoadMsg = null;
        apiData.errorInDataLoad = false;
        apiData.data = [];
      }
      return apiData;
    }

    List meetingList = [];
    for (var resultObj in resultsArray) {
      String startDate = resultObj["date"];
      String fStartDate = AppUtils.getConvertDate(startDate,
          date_from_format: null, date_to_formate: AppUtils.DATE_FORM_DD_MMM_YYYY);

      String endDate = resultObj["date"];
      String fEndDate = AppUtils.getConvertDate(endDate,
          date_from_format: null, date_to_formate: AppUtils.DATE_FORM_DD_MMM_YYYY);

      String startTime = resultObj["start_time_local"];
      String fStartTime = AppUtils.getConvertDate(startTime,
          date_from_format: null, date_to_formate: AppUtils.TIME_FORM_HH_MM_A);

      String endTime = resultObj["end_time_local"];
      String fEndTime = AppUtils.getConvertDate(endTime,
          date_from_format: null, date_to_formate: AppUtils.TIME_FORM_HH_MM_A);

      meetingList.add({
        "id": resultObj["meeting_id"],
        "title": resultObj["title"],
        "description": (resultObj["description"]?.toString()?.trim() ?? ""),
        "start_date": fStartDate,
        "end_date": fEndDate,
        "start_time": fStartTime,
        "end_time": fEndTime,
        "state": resultObj["meeting_state"]
      });
    }
    apiData.data = meetingList;

    return apiData;
  }

  static ApiData parseAccessToken(var responseObj) {
    ApiData apiData = ApiData();

    if (responseObj == null) {
      apiData.errorInDataLoad = true;
      return apiData;
    }

    int statusCode = responseObj["status_code"];
    if (statusCode != 200) {
      apiData.errorInDataLoad = true;
      return apiData;
    }
      var dataObj = responseObj["data"];
      if (dataObj == null) {
        apiData.errorInDataLoad = true;
        return apiData;
      }

      debugPrint("Meeting Token = $dataObj");
    apiData.data = dataObj;
    return apiData;
  }

  static ApiData parseUserProfile(var responseObj) {
    ApiData apiData = ApiData();

    if (responseObj == null) {
      apiData.errorInDataLoad = true;
      return apiData;
    }

    int statusCode = responseObj["status_code"];
    if (statusCode != 200) {
      apiData.errorInDataLoad = true;
      return apiData;
    }
      var dataObj = responseObj["data"];
      var userObj = dataObj != null ? dataObj["users"] : null;

      if (dataObj == null || userObj == null) {
        apiData.errorInDataLoad = true;
        return apiData;
      }

      var profile = {
        "user_id": userObj["user_id"],
        "auth_id": userObj["auth_id"],
        "username": userObj["username"],
        "mobile": userObj["mobile"],
        "email": userObj["email"],
        "first_name": userObj["first_name"],
        "last_name": userObj["last_name"],
        "session_token": userObj["session_token"]
      };
    debugPrint("Meeting User Profile = $profile");
      apiData.data = profile;

      return apiData;
  }

  static ApiData parseMemberType(var responseObj) {
    ApiData apiData = ApiData();

    if (responseObj == null) {
      apiData.errorInDataLoad = true;
      return apiData;
    }

    int statusCode = responseObj["status_code"];
    if (statusCode != 200) {
      apiData.errorInDataLoad = true;
      return apiData;
    }
    var dataObj = responseObj["data"];
    if (dataObj == null) {
      apiData.errorInDataLoad = true;
      return apiData;
    }

    bool isAdmin = dataObj["isadmin"];
    apiData.data = isAdmin;
    apiData.errorInDataLoad = false;

    return apiData;
  }

}