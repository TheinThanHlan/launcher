import 'languages/JapanLanguageMap.dart';
import 'SelectAppController.dart';
import 'SelectAppModel.dart';
import 'SelectApp.dart';
import 'package:flutter/foundation.dart';
import 'package:winter/winter.dart';

class SelectAppComponentConfig implements Configurer {
  final String? instanceName;
  SelectAppComponentConfig({this.instanceName});

  //please write sub component configurations here
  Future<void> _preConfig() async {}

  Future<void> config() async {
    await _preConfig();

    var lf = WinterLanguageFactory(
      getIt<ValueNotifier<String>>(instanceName: "currentLanguage"),
      {"jp": JapanLanguageMap()},
    );

    //Lazy Singleton injection
    //getIt.registerLazySingleton(instanceName:instanceName,(){
    //var model=  SelectAppModel();
    //var view=SelectApp(lf,model);
    //return SelectAppController(
    //  //SelectApp(),
    //  view,lf,model
    // );});
    //

    //Factory injection with parameter
    getIt.registerFactoryParam<SelectAppController, SelectAppModel, Null>(
      instanceName: instanceName,
      (p1, p2) => SelectAppController(SelectApp(lf, p1), lf, p1),
    );

    await _postConfig();
  }

  //please write the tasks you want to do after config here
  Future<void> _postConfig() async {
    debugPrint("\t~>\tSelectAppComponent injected;");
  }
}
