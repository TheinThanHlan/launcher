import 'dart:io';

import 'package:flutter/material.dart';
import 'package:launcher/data/dao/SelectedAppsDao.dart';
import 'package:path_provider/path_provider.dart';
import 'package:winter/winter.dart';

class DaoConfig implements Configurer {
  @override
  Future<void> config({String? instanceName}) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    //Database configuration and Database access object configurations should be done here.
    getIt.registerSingleton(SelectedAppsDao(appDocDir: appDocDir));
  }
}
