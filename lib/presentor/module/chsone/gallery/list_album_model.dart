import 'dart:collection';
import 'dart:convert';

import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/chsone_api.dart';
import 'package:sso_futurescape/utils/storage/chsone_storage.dart';

class ListAlbumModel {
  ListAlbumModel();

  void listAlbums(currentUnit, ListAlbumModelResponse albumListView,
      {String loadPage}) {
    ChsoneStorage.getChsoneAccessInfo().then((access_info) {
      if (access_info != null) {
        HashMap<String, String> hashMap = new HashMap();
        hashMap["unit_id"] = currentUnit['unit_id'];
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

          albumListView.onSuccessListAlbum(matedata, listResult);
        }, (s) {
          albumListView.onFailure(s);
        }, (s) {
          albumListView.onError(s);
        });

        CHSONEAPIHandler.getAlbumList(handler, hashMap).excute();
      }
    });
  }

  void deleteAlbums(currentUnit, albumids, ListAlbumModelResponse albumListView,
      {String loadPage}) {
    ChsoneStorage.getChsoneAccessInfo().then((access_info) {
      if (access_info != null) {
        HashMap<String, String> hashMap = new HashMap();
        hashMap["unit_id"] = currentUnit['unit_id'];
        hashMap["album_id"] = jsonEncode(albumids);
        hashMap["token"] = access_info["access_token"];
        if (loadPage != null) {
          hashMap["page"] = loadPage;
        }
        print(hashMap);
        NetworkHandler handler = new NetworkHandler((a) {
          print(a);

          albumListView.onSuccessDeleteAlbum(albumids);
        }, (s) {
          albumListView.onFailure(s);
        }, (s) {
          albumListView.onError(s);
        });

        CHSONEAPIHandler.deleteAlbums(handler, hashMap).excute();
      }
    });
  }

  void createAlbum(name, ListAlbumModelResponse albumListView,
      {String loadPage}) {
    ChsoneStorage.getChsoneAccessInfo().then((access_info) {
      if (access_info != null) {
        HashMap<String, String> hashMap = new HashMap();
        hashMap["name"] = name;
        hashMap["token"] = access_info["access_token"];
        if (loadPage != null) {
          hashMap["page"] = loadPage;
        }
        print(hashMap);
        NetworkHandler handler = new NetworkHandler((a) {
          print(a);
          var resPonse = jsonDecode(a)["data"];

          albumListView.onSuccessCreateAlbum(resPonse);
        }, (s) {
          albumListView.onFailure(s);
        }, (s) {
          albumListView.onError(s);
        });

        CHSONEAPIHandler.createAlbum(handler, hashMap).excute();
      }
    });
  }
}

abstract class ListAlbumModelResponse {
  void onSuccessListAlbum(response, List allAlbumList);

  void onSuccessDeleteAlbum(albumids);

  void onSuccessCreateAlbum(response);

  void onError(String response);

  void onFailure(String response);
}
