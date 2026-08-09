import 'package:flutter/material.dart';
import 'package:flutter_device_apps/flutter_device_apps.dart';
import 'package:launcher/Home/HomeComponentConfig.dart';
import 'package:launcher/SelectApp/SelectAppComponentConfig.dart';
import 'package:winter/winter.dart';
import './data/dao/DaoConfig.dart';

class ApplicationConfig implements Configurer {
  @override
  Future<void> config({String? instanceName}) async {
    WidgetsFlutterBinding.ensureInitialized();
    getIt.registerSingleton<ValueNotifier<String>>(
      ValueNotifier("jp"),
      instanceName: "currentLanguage",
    );

    await DaoConfig().config();
    getIt.registerSingleton(
      ValueNotifier(
        (await FlutterDeviceApps.listApps(
          includeSystem: true,
          includeIcons: true,
        )).toList()..sort((a, b) {
          return a.appName.toString().compareTo(b.appName.toString());
        }),
      ),
    );
    HomeComponentConfig().config();
    SelectAppComponentConfig().config();
  }
}
