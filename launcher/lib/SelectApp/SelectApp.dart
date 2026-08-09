import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_device_apps/flutter_device_apps.dart';
import 'package:launcher/data/dao/SelectedAppsDao.dart';
import 'package:launcher/data/model/SelectedApps.dart';
import 'package:winter/winter.dart';
import "SelectAppModel.dart";

class SelectApp extends StatelessWidget implements WinterView {
  //late final SelectAppController c;
  final WinterLanguageFactory _lf;
  final SelectAppModel _model;
  SelectApp(this._lf, this._model);
  bool selectAll = false;
  @override
  Widget build(BuildContext context) {
    //    return LayoutBuilder(builder: (context, constraints) {
    //      return Desktop(c);
    //    });
    return ValueListenableBuilder(
      valueListenable: getIt<ValueNotifier<List<AppInfo>>>(),
      builder: (builder, value, child) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Scaffold(
              appBar: AppBar(
                title: Text(_model.pageTitle),
                actions: [
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 13),
                    child: ElevatedButton(
                      onPressed: () {
                        _model.onActionClicked(_model.selectedApps);
                        Navigator.of(context).pop();
                      },
                      child: Text(_model.actionButtonTitle),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 21),
                    child: Checkbox(
                      value: selectAll,
                      onChanged: (a) {
                        selectAll = a!;
                        if (a ?? false) {
                          this._model.selectedApps.apps = value.map((b) {
                            return b.packageName.toString();
                          }).toList();
                        } else {
                          this._model.selectedApps.apps = [];
                        }
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              body: ListView(
                children: [
                  for (var a in value)
                    CheckboxListTile(
                      //leading: Image.memory(a.iconBytes ?? [] as Uint8List),
                      title: Row(
                        spacing: 55,
                        children: [
                          Image.memory(
                            a.iconBytes ?? Uint8List(1),
                            width: 55,
                            fit: BoxFit.contain,
                          ),
                          Text(a.appName.toString()),
                        ],
                      ),
                      value: _model.selectedApps.apps.contains(
                        a.packageName.toString(),
                      ),
                      onChanged: (aa) {
                        // print(_model.selectedApps.apps.toString());
                        if (aa ?? false) {
                          _model.selectedApps.apps.add(
                            a.packageName.toString(),
                          );
                        } else {
                          _model.selectedApps.apps.remove(a.packageName);
                        }
                        setState(() {});
                      },
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
