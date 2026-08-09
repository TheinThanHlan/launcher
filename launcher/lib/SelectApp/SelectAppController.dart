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
    _view.isAllSelected = isAllSelected;
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
    apps.sort((x, y) => x.appName.toString().compareTo(y.appName.toString()));
    getIt<ValueNotifier<List<AppInfo>>>().value = apps;
  }

  bool isAllSelected() {
    for (var a in getIt<ValueNotifier<List<AppInfo>>>().value) {
      if (!_model.editSelectedApps.apps.contains(a.packageName.toString())) {
        return false;
      }
    }
    return true;
  }
}
