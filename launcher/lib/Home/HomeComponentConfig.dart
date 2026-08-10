import 'languages/JapanLanguageMap.dart';
import 'HomeController.dart';
import 'HomeModel.dart';
import 'Home.dart';
import 'package:flutter/foundation.dart';
import 'package:winter/winter.dart';

class HomeComponentConfig implements Configurer {
  final String? instanceName;
  HomeComponentConfig({this.instanceName});

  //please write sub component configurations here
  Future<void> _preConfig() async {}

  @override
  Future<void> config() async {
    await _preConfig();

    var lf = WinterLanguageFactory(
      getIt<ValueNotifier<String>>(instanceName: "currentLanguage"),
      {"jp": JapanLanguageMap()},
    );

    //Lazy Singleton injection
    getIt.registerLazySingleton(instanceName: instanceName, () {
      var model = HomeModel();
      var view = Home(lf, model);
      return HomeController(
        //Home(),
        view,
        lf,
        model,
      );
    });

    //Factory injection with parameter
    /*
  getIt.registerFactoryParam<HomeController,HomeModel,Null>(instanceName:instanceName,(p1,p2)=>HomeController(
    
    Home(lf,p1), 
    lf,
    p1

   ),);

  */

    await _postConfig();
  }

  //please write the tasks you want to do after config here
  Future<void> _postConfig() async {
    debugPrint("\t~>\tHomeComponent injected;");
  }
}
