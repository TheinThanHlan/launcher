import 'package:flutter/material.dart';
import 'package:launcher/Home/HomeController.dart';
import 'package:launcher/data/dao/SelectedAppsDao.dart';
import 'ApplicationConfig.dart';
import 'package:winter/winter.dart';

void main() {
  ApplicationConfig().config().then((a) {
    runApp(
      MaterialApp(
        color: Colors.transparent,
        home: ValueListenableBuilder(
          valueListenable: getIt<ValueNotifier<String>>(
            instanceName: "currentLanguage",
          ),
          builder: (context, _, _) {
            return getIt<HomeController>().getView();
          },
        ),
      ),
    );
  });
}
