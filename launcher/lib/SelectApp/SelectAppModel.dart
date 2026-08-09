import 'package:flutter_device_apps/flutter_device_apps.dart';
import 'package:launcher/data/dao/SelectedAppsDao.dart';
import 'package:launcher/data/model/SelectedApps.dart';
import 'package:winter/winter.dart';

class SelectAppModel implements WinterModel {
  final SelectedApps selectedApps;
  final String pageTitle;
  final String actionButtonTitle;
  final SelectedApps editSelectedApps = SelectedApps([]);
  final void Function(SelectedApps selectedApps) onActionClicked;

  SelectAppModel({
    required this.pageTitle,
    required this.actionButtonTitle,
    required this.onActionClicked,
    required this.selectedApps,
  }) {
    editSelectedApps.apps = [...this.selectedApps.apps];
  }
}
