import 'package:flutter_device_apps/flutter_device_apps.dart';

extension AppInfoExtension on AppInfo {
  static AppInfo fromJson(Map<String, dynamic> json) {
    return AppInfo(
      packageName: json["packageName"],
      appName: json["appName"],
      versionName: json["versionName"],
      versionCode: json["versionCode"],
      uid: json["uid"],
      apkPath: json["apkPath"],
      apkSizeBytes: json["apkSizeBytes"],
      dataPath: json["dataPath"],
      isOnExternalStorage: json["isOnExternalStorage"],
      firstInstallTime: json["firstInstallTime"],
      lastUpdateTime: json["lastUpdateTime"],
      isSystem: json["isSystem"],
      iconBytes: json["iconBytes"],
      category: json["category"],
      targetSdkVersion: json["targetSdkVersion"],
      minSdkVersion: json["minSdkVersion"],
      enabled: json["enabled"],
      processName: json["processName"],
      installLocation: json["installLocation"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "packageName": packageName,
      "appName": appName,
      "versionName": versionName,
      "versionCode": versionCode,
      "uid": uid,
      "apkPath": apkPath,
      "apkSizeBytes": apkSizeBytes,
      "dataPath": dataPath,
      "isOnExternalStorage": isOnExternalStorage,
      "firstInstallTime": firstInstallTime,
      "lastUpdateTime": lastUpdateTime,
      "isSystem": isSystem,
      "iconBytes": iconBytes,
      "category": category,
      "targetSdkVersion": targetSdkVersion,
      "minSdkVersion": minSdkVersion,
      "enabled": enabled,
      "processName": processName,
      "installLocation": installLocation,
    };
  }
}
