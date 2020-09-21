import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sso_futurescape/utils/permission/permission_service.dart';

class DownloadUtils {
  DownloadUtils._privateConstructor();

  static DownloadUtils _downloadUtils;

  static Future<DownloadUtils> getDownloadInstance() async {
    if (_downloadUtils == null) {
      WidgetsFlutterBinding.ensureInitialized();
      await FlutterDownloader.initialize();
      _downloadUtils = new DownloadUtils._privateConstructor();
      return _downloadUtils;
    } else {
      return _downloadUtils;
    }
  }

  Future<void> startDownload(String url) async {
    PermissionsService1().requestStoragePermission().then((value) {
      if (value) {
        createFolderInAppDocDir("one_app").then((result) {
          print("path ----------------------- " + result);
          final taskId = FlutterDownloader.enqueue(
            url: url,
            savedDir: result,
            showNotification: true,
            // show download progress in status bar (for Android)
            openFileFromNotification:
                true, // click on notification to open downloaded file (for Android)
          );
        });
      }
    });
  }

  static Future<String> createFolderInAppDocDir(String folderName) async {
    //Get this App Document Directory
    final Directory _appDocDir = await getExternalStorageDirectory();
    //App Document Directory + folder name
    final Directory _appDocDirFolder =
        Directory('${_appDocDir.path}/$folderName');

    if (await _appDocDirFolder.exists()) {
      //if folder already exists return path
      return _appDocDirFolder.path;
    } else {
      //if folder not exists create folder and then return its path
      final Directory _appDocDirNewFolder =
          await _appDocDirFolder.create(recursive: true);
      return _appDocDirNewFolder.path;
    }
  }
}
