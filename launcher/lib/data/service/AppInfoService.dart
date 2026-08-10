import 'dart:async';

import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:winter/winter.dart';

class AppInfoService {
  Future<void> updateAppInfosNotifier() async {
    var x = (await InstalledApps.getInstalledApps(
      excludeSystemApps: false,
      excludeNonLaunchableApps: false,
      withIcon: true,
    ));
    x.sort((a, b) {
      return a.name.compareTo(b.name);
    });
    if (!getIt.isRegistered<ValueNotifier<List<AppInfo>>>()) {
      getIt.registerSingleton(ValueNotifier(x));
    } else {
      getIt<ValueNotifier<List<AppInfo>>>().value = x;
    }
  }
}
