import 'dart:async';

import 'package:flutter/material.dart';
import 'package:launcher/data/model/SelectedApps.dart';
import 'package:winter/winter.dart';

class SelectAppModel implements WinterModel {
  final SelectedApps selectedApps;
  final String pageTitle;
  final String actionButtonTitle;
  final bool includeSystemApps;
  final bool onlyLaunchable;
  final SelectedApps editSelectedApps = SelectedApps([]);
  final FutureOr<void> Function(SelectedApps selectedApps) onActionClicked;

  final ValueNotifier<String> searchApp = ValueNotifier("");

  SelectAppModel({
    required this.pageTitle,
    required this.actionButtonTitle,
    required this.onActionClicked,
    required this.selectedApps,
    required this.includeSystemApps,
    required this.onlyLaunchable,
  }) {
    editSelectedApps.apps = List.of(selectedApps.apps);
  }
}
