import 'dart:collection';
import 'dart:convert';

import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/chsone_api.dart';
import 'package:sso_futurescape/utils/storage/chsone_storage.dart';

class ListComplaintModel {
  ListComplaintModel();

  void listComplaints(currentUnit, ListComplaintModelResponse complaintListView,
      {String complaintType, String loadPage}) {
    ChsoneStorage.getChsoneAccessInfo().then((access_info) {
      if (access_info != null) {
        HashMap<String, String> hashMap = new HashMap();
        hashMap["unit_id"] = currentUnit['unit_id'];
        hashMap["token"] = access_info["access_token"];
        if (loadPage != null) {
          hashMap["page"] = loadPage;
        }
        hashMap["status"] = complaintType;
        print(hashMap);
        NetworkHandler handler = new NetworkHandler((a) {
          print(a);
          var resPonse = jsonDecode(a)["data"];
          var matedata = resPonse["metadata"];
          var listResult = resPonse["results"];

          complaintListView.onSuccessListComplaint(matedata, listResult);
        }, (s) {
          complaintListView.onFailure(s);
        }, (s) {
          complaintListView.onError(s);
        });

        CHSONEAPIHandler.getComplaintList(handler, hashMap).excute();
      }
    });
  }
// AddComplaintModel();
// void addComplaint(String detail, String subject,currentUnit,topic,RequestAddComplaintModelResponse addComplaintModelResponse)
// {
//   print("====="+topic);
//   ChsoneStorage.getChsoneAccessInfo().then((access_info) {
//     if (access_info != null) {
//       HashMap<String, String> hashMap = new HashMap();
//       hashMap["title"] = subject;
//       hashMap["details"] = detail;
//       hashMap["help_topic_id"] =topic;
//       hashMap["unit_id"] = currentUnit;
//       hashMap["token"] = access_info["access_token"];

//       NetworkHandler netwrkHandler = new NetworkHandler(
//               (response) => {addComplaintModelResponse.onSuccessAddComplaint(jsonDecode(response.toString()))},
//               (response) => {addComplaintModelResponse.onFailure(response)},
//               (response) => {addComplaintModelResponse.onError(response)});

//       Network networkt =
//       CHSONEAPIHandler.addComplaint(hashMap, netwrkHandler);
//       networkt.excute();
//     }
//   });

// }

}

abstract class ListComplaintModelResponse {
  void onSuccessListComplaint(response, List allComplaintList);

  void onError(String response);

  void onFailure(String response);
}
