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
  late final bool Function() isAllSelected;
  late final Function() reloadApps;

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
                actionsPadding: EdgeInsetsGeometry.symmetric(horizontal: 21),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      reloadApps();
                    },
                    child: Text("Reload Apps"),
                  ),

                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 21),
                    child: ElevatedButton(
                      onPressed: () {
                        _model.onActionClicked(_model.editSelectedApps);
                        Navigator.pop(context);
                      },
                      child: Text(_model.actionButtonTitle),
                    ),
                  ),
                  Checkbox(
                    value: isAllSelected(),
                    onChanged: (a) {
                      if (a ?? false) {
                        _model.editSelectedApps.apps = value.map((b) {
                          return b.packageName.toString();
                        }).toList();
                      } else {
                        _model.editSelectedApps.apps = [];
                      }
                      setState(() {});
                    },
                  ),
                ],
              ),
              body: Padding(
                padding: EdgeInsetsGeometry.symmetric(vertical: 13),
                child: ListView(
                  children: [
                    for (var a in value)
                      CheckboxListTile(
                        //leading: Image.memory(a.iconBytes ?? [] as Uint8List),
                        title: Row(
                          spacing: 34,
                          children: [
                            Image.memory(
                              a.iconBytes ?? Uint8List(1),
                              width: 55,
                              fit: BoxFit.contain,
                            ),
                            Expanded(
                              child: Text(
                                a.appName.toString(),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        value: _model.editSelectedApps.apps.contains(
                          a.packageName.toString(),
                        ),
                        onChanged: (aa) {
                          // print(_model.editSelectedApps.apps.toString());
                          if (aa ?? false) {
                            _model.editSelectedApps.apps.add(
                              a.packageName.toString(),
                            );
                          } else {
                            _model.editSelectedApps.apps.remove(a.packageName);
                          }
                          setState(() {});
                        },
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
