import 'package:flutter/material.dart';
import 'package:flutter_device_apps/flutter_device_apps.dart';

import 'SelectAppModel.dart';
import 'SelectApp.dart';
import 'package:winter/winter.dart';

class SelectAppController implements WinterController {
  final SelectAppModel _model;
  final SelectApp _view;
  final WinterLanguageFactory _lf;
  //final module = getIt<GetIt>(instanceName:);
  SelectAppController(this._view, this._lf, this._model) {
    _view.reloadApps = reloadApps;
  }
  //this._view.c=this;
  void reset() {}

  WinterView getView() {
    return this._view;
  }

  Future<void> reloadApps() async {
    var apps = await FlutterDeviceApps.listApps(
      includeSystem: true,
      includeIcons: true,
    );
    apps.sort((x, y) => x.appName.toString().compareTo(x.appName.toString()));
    getIt<ValueNotifier<List<AppInfo>>>().value = apps;
  }
}
