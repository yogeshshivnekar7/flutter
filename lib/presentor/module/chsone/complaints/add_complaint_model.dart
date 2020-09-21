import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/chsone_api.dart';
import 'package:sso_futurescape/utils/storage/chsone_storage.dart';

class AddComplaintModel {
  AddComplaintModel();

  void addComplaint(String detail, String subject, currentUnit, topic,
      RequestAddComplaintModelResponse addComplaintModelResponse, File file) {
    print("=====" + topic);
    ChsoneStorage.getChsoneAccessInfo().then((access_info) async {
      if (access_info != null) {
        HashMap<String, String> hashMap = new HashMap();
        hashMap["title"] = subject;
        hashMap["details"] = detail;
        hashMap["help_topic_id"] = topic;
        hashMap["unit_id"] = currentUnit;
        hashMap["token"] = access_info["access_token"];

        file = await compressFile(file);
        print(hashMap);
        NetworkHandler netwrkHandler = new NetworkHandler((response) {
          addComplaintModelResponse
              .onSuccessAddComplaint(jsonDecode(response.toString()));
        }, (response) {
          addComplaintModelResponse.onFailure(response);
        }, (response) {
          addComplaintModelResponse.onError(response);
        });

        Network networkt =
            CHSONEAPIHandler.addComplaint(hashMap, file, netwrkHandler);
        networkt.excute();
      }

      /*if (response.statusCode == 200) {
        success(response.data.toString());
      } else {
        failure(response.data.toString());
      }*/
    });
  }

  Future<File> compressFile(File file) async {
    if (file == null) {
      return file;
    }
    String mimeStr = lookupMimeType(file.path);
    var fileType = mimeStr.split('/');
    final dir = await path_provider.getTemporaryDirectory();
    final targetPath = dir.absolute.path + "/temp.jpg";
    try {
      if (fileType.contains("image")) {
        File result = await FlutterImageCompress.compressAndGetFile(
          file.absolute.path,
          targetPath,
          quality: 80,
        );
        return File(targetPath);
      }
    } catch (e) {
      print(e);
    }
    return file;
  }
}

abstract class RequestAddComplaintModelResponse {
  void onSuccessAddComplaint(response);

  void onError(String response);

  void onFailure(String response);
}
