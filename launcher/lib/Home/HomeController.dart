import 'HomeModel.dart';
import 'Home.dart';
import 'package:winter/winter.dart';

class HomeController implements WinterController {
  final HomeModel _model;
  final Home _view;
  final WinterLanguageFactory _lf;
  //final module = getIt<GetIt>(instanceName:);
  HomeController(this._view,this._lf,this._model);
   //this._view.c=this;
  void reset(){}

  WinterView getView(){
    return this._view;
  }

}
