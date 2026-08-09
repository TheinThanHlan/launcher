import 'dart:convert';

class SelectedApps {
  List<String> apps;

  SelectedApps(this.apps);

  factory SelectedApps.fromJson(Map<String, dynamic> json) {
    return SelectedApps(
      (json["apps"] as List).map((a) => a.toString()).toList(),
    );
  }
  Map<String, List<String>> toJson() {
    return <String, List<String>>{"apps": apps};
  }
}
