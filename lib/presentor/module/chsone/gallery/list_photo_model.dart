import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/chsone_api.dart';
import 'package:sso_futurescape/utils/storage/chsone_storage.dart';

class ListPhotoModel {
  ListPhotoModel();

  void listPhotos(currentUnit, albumid, ListPhotoModelResponse photoListView,
      {String loadPage}) {
    ChsoneStorage.getChsoneAccessInfo().then((access_info) {
      if (access_info != null) {
        HashMap<String, String> hashMap = new HashMap();
        hashMap["unit_id"] = currentUnit['unit_id'];
        hashMap["album_id"] = albumid.toString();
        hashMap["token"] = access_info["access_token"];
        if (loadPage != null) {
          hashMap["page"] = loadPage;
        }
        print(hashMap);
        NetworkHandler handler = new NetworkHandler((a) {
          print(a);
          var resPonse = jsonDecode(a)["data"];
          var matedata = resPonse["metadata"];
          var listResult = resPonse["results"];

          photoListView.onSuccessListPhoto(matedata, listResult);
        }, (s) {
          photoListView.onFailure(s);
        }, (s) {
          photoListView.onError(s);
        });

        CHSONEAPIHandler.getPhotoList(handler, hashMap).excute();
      }
    });
  }

  void uploadImage(albumid, File image, ListPhotoModelResponse photoListView) {
    ChsoneStorage.getChsoneAccessInfo().then((access_info) {
      if (access_info != null) {
        HashMap<String, String> hashMap = new HashMap();
        hashMap["album_id"] = albumid.toString();
        hashMap["token"] = access_info["access_token"];
        print(hashMap);
        NetworkHandler handler = new NetworkHandler((a) {
          print(a);
          var resPonse = jsonDecode(a)["data"];
          var matedata = [];
          var listResult = [resPonse];
          matedata.add("goToMainPage");
          photoListView.onSuccessListPhoto(matedata, listResult);
        }, (s) {
          photoListView.onFailure(s);
        }, (s) {
          photoListView.onError(s);
        });

        CHSONEAPIHandler.uploadPhoto(hashMap, image, handler).excute();
      }
    });
//     void success(String a) {
//       print("response - " + a);
//       var resPonse = jsonDecode(a)["data"];
//       var metadata = resPonse["metadata"];
//       var listResult = resPonse["results"];
//       photoListView.onSuccessListPhoto(metadata, listResult);

//       //print("s - " + jsonDecode(response));
//     }

//     void error(String error) {
//       print("error" + error);
//       photoListView.onError(error);
//     }

//     void failure(String failure) {
//       print("failure" + failure);
//       photoListView.onFailure(failure);
//     }

//     print("handlerhandlerhandler");
// /*    NetworkHandler handler = new NetworkHandler(
//         (response) => {success(response)},
//         (response) => {failure(response)},
//         (response) => {error(response)});*/

//     ChsoneStorage.getChsoneAccessInfo().then((access_info) async {
//       var tokensss;
//       if (access_info != null) {
//         tokensss = access_info["access_token"];
//         print(tokensss);
//         var formData = FormData.fromMap({
//           "token": tokensss,
//           "albumid": albumid,
//           "image[0]":
//               await MultipartFile.fromFile(image.path, filename: "image.jpg"),
//         });
//         Dio dio = new Dio();
//         /*http://authapi.chsone.in/api/v2/users/35/avatars*/
//         Response response = await dio.post(
//             Environment().getCurrentConfig().ssoAuthUrl + "users/avatars",
//             data: formData);
//         print(response.data);
//         if (response.statusCode == 200) {
//           success(response.data.toString());
//         } else {
//           failure(response.data.toString());
//         }
//       } else {
//         error("Access Token not available");
//       }

//       print("excute");
//     }).catchError((e) {
//       print(e);
//       print("excute");
//     });
  }

  void deletePhotos(currentUnit, photoids, ListPhotoModelResponse albumListView,
      {String loadPage}) {
    ChsoneStorage.getChsoneAccessInfo().then((access_info) {
      if (access_info != null) {
        HashMap<String, String> hashMap = new HashMap();
        hashMap["photo_id"] = jsonEncode(photoids);
        hashMap["token"] = access_info["access_token"];
        if (loadPage != null) {
          hashMap["page"] = loadPage;
        }
        print(hashMap);
        NetworkHandler handler = new NetworkHandler((a) {
          print(a);

          albumListView.onSuccessDeletePhoto(photoids);
        }, (s) {
          albumListView.onFailure(s);
        }, (s) {
          albumListView.onError(s);
        });

        CHSONEAPIHandler.deletePhotos(handler, hashMap).excute();
      }
    });
  }
}

abstract class ListPhotoModelResponse {
  // void onSuccessAddPhoto(response, List addedPhotos);
  void onSuccessDeletePhoto(photoids);

  void onSuccessListPhoto(response, List allPhotoList);

  void onError(String response);

  void onFailure(String response);
}
