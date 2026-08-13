import 'package:flutter/material.dart';
//import 'package:flutter_soloud/flutter_soloud.dart';
import 'package:launcher/Home/HomeComponentConfig.dart';
import 'package:launcher/SelectApp/SelectAppComponentConfig.dart';
import 'package:launcher/data/service/AppInfoService.dart';
import 'package:launcher/data/service/ServiceConfig.dart';
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
    await ServiceConfig().config();

    //run before application start to inject app info notifier
    await getIt<AppInfoService>().updateAppInfosNotifier();

    //register soloud to play sounds
    //var soloud = SoLoud.instance;
    //await soloud.init();
    //getIt.registerSingleton(soloud);
    //getIt.registerSingleton(
    //  await soloud.loadAsset(
    //    "lib/resources/universfield-bubble-pop-02-293341.mp3",
    //  ),
    //  instanceName: "pop_sound",
    //);

    //app change listener use too much resource and I will comment ths util I found better solution
    //getIt<AppInfoService>().listenToTheAppChange();
    HomeComponentConfig().config();
    SelectAppComponentConfig().config();
  }
}
