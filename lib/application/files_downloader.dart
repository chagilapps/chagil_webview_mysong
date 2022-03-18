import 'dart:io';
// import 'package:al_downloader/al_downloader.dart';
import 'package:android_path_provider/android_path_provider.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'links_navigation.dart';

class FileDownloader {
  // TargetPlatform platform;
  // FileDownloader ({required this.platform});

  newDownload(name, String downloadUrl) {
    if (Platform.isIOS) {
      LinksNavigation.launchURL(Uri.parse(downloadUrl) );
    } else {
      checkAndRequestPermission()
          .then((value) => _requestDownload(name: name, link: downloadUrl));
    }
  }

  Future<void> checkAndRequestPermission() async {
    // if(Platform.isIOS){}
    // if(Platform.isAndroid){}
    print("check Permmission");
    var status = await Permission.storage.status;
    print(status.toString());
    if (!status.isGranted) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      Permission.storage.request();
    }
  }

  void _requestDownload({required String name, required String link}) async {
    _TaskInfo task = _TaskInfo(name: name, link: link);
    var _dir = await _prepareSaveDir();
    print("_dir == $_dir");
    task.taskId = await FlutterDownloader.enqueue(
      url: task.link!,
      // headers: {"auth": "test_for_sql_encoding"},
      savedDir: await _dir,
      showNotification: true,
      openFileFromNotification: true,
      saveInPublicStorage: true,
    );
  }

  Future<String> _prepareSaveDir() async {
    String _localPath;
    _localPath = (await _findLocalPath())!;
    print("_localPath:  $_localPath");
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
    return _localPath;
  }

  Future<String?> _findLocalPath() async {
    var externalStorageDirPath;
    if (Platform.isAndroid) {
      try {
        externalStorageDirPath = await AndroidPathProvider.downloadsPath;
      } catch (e) {
        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }

    print("externalStorageDirPath : $externalStorageDirPath");
    return externalStorageDirPath;
  }
}

class _TaskInfo {
  final String? name;
  final String? link;

  String? taskId;
  int? progress = 0;
  DownloadTaskStatus? status = DownloadTaskStatus.undefined;

  _TaskInfo({this.name, this.link});
}
