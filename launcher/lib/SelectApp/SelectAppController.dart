import 'package:installed_apps/app_info.dart';

import 'SelectAppModel.dart';
import 'SelectApp.dart';
import 'package:winter/winter.dart';

class SelectAppController implements WinterController {
  final SelectAppModel _model;
  final SelectApp _view;
  final WinterLanguageFactory _lf;
  //final module = getIt<GetIt>(instanceName:);
  SelectAppController(this._view, this._lf, this._model) {
    _view.isAllSelected = isAllSelected;
  }
  //this._view.c=this;
  void reset() {}

  @override
  WinterView getView() {
    return _view;
  }

  bool isAllSelected(List<AppInfo> appInfos) {
    for (var a in appInfos) {
      if (!_model.editSelectedApps.apps.contains(a.packageName)) {
        return false;
      }
    }
    return true;
  }
}
