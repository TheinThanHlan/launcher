import 'dart:convert';
import 'dart:io';

import 'package:launcher/data/model/SelectedApps.dart';

class SelectedAppsDao {
  final Directory appDocDir;
  SelectedAppsDao({required this.appDocDir});
  Future<SelectedApps> _fetchSelectedApps(String fileName) async {
    final selectedAppsFile = File("${appDocDir.path}/$fileName");
    var selectedAppsJson = "";
    if (selectedAppsFile.existsSync()) {
      selectedAppsJson = selectedAppsFile.readAsStringSync();
    } else {
      selectedAppsJson = jsonEncode(SelectedApps([]));
      selectedAppsFile.writeAsString(selectedAppsJson);
    }

    return SelectedApps.fromJson(jsonDecode(selectedAppsJson));
  }

  Future _updateSelectedApps(SelectedApps selectedApps, String fileName) async {
    final selectedAppsFile = File("${appDocDir.path}/$fileName");
    return selectedAppsFile.writeAsString(jsonEncode(selectedApps.toJson()));
  }

  final String _showAppsFileName = "showApps.json";
  Future<SelectedApps> fetchShowApps() async {
    return _fetchSelectedApps(_showAppsFileName);
  }

  Future updateShowApps(SelectedApps selectedApps) async {
    return _updateSelectedApps(selectedApps, _showAppsFileName);
  }
}
