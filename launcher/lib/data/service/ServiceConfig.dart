
import 'package:launcher/data/service/AppInfoService.dart';
import 'package:winter/winter.dart';

class ServiceConfig implements Configurer {
  @override
  Future<void> config({String? instanceName}) async {
    //Database configuration and Database access object configurations should be done here.
    getIt.registerSingleton(AppInfoService());
  }
}
