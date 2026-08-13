import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:launcher/data/service/AppInfoService.dart';
import 'package:winter/winter.dart';
import "SelectAppModel.dart";

class SelectApp extends StatelessWidget implements WinterView {
  //late final SelectAppController c;
  final WinterLanguageFactory _lf;
  final SelectAppModel _model;
  SelectApp(this._lf, this._model);
  late final bool Function(List<AppInfo>) isAllSelected;

  @override
  Widget build(BuildContext context) {
    //    return LayoutBuilder(builder: (context, constraints) {
    //      return Desktop(c);
    //    });
    return ValueListenableBuilder(
      valueListenable: getIt<ValueNotifier<List<AppInfo>>>(),
      builder: (builder, value, child) {
        //filter the system apps and launchable apps.
        var search_text_controller = TextEditingController();
        var filteredValue = value;
        if (!_model.includeSystemApps) {
          filteredValue = filteredValue
              .where((a) => a.isSystemApp != true)
              .toList();
        }
        if (_model.onlyLaunchable) {
          filteredValue = filteredValue
              .where((a) => a.isLaunchableApp == true)
              .toList();
        }

        return StatefulBuilder(
          builder: (context, setState) {
            return Scaffold(
              appBar: AppBar(
                title: Text(_model.pageTitle),
                actionsPadding: EdgeInsetsGeometry.symmetric(horizontal: 21),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      getIt<AppInfoService>().updateAppInfosNotifier();
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
                  Chip(label: Text("${_model.editSelectedApps.apps.length}")),
                  Checkbox(
                    value: isAllSelected(filteredValue),
                    onChanged: (a) {
                      if (a ?? false) {
                        _model.editSelectedApps.apps = filteredValue.map((b) {
                          return b.packageName;
                        }).toList();
                      } else {
                        _model.editSelectedApps.apps = [];
                      }
                      setState(() {});
                    },
                  ),
                ],
              ),
              body: Column(
                children: [
                  Container(
                    height: 89,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 21),
                    child: TextField(
                      controller: search_text_controller,
                      decoration: InputDecoration(
                        hintText: "Search",
                        suffixIcon: IconButton(
                          onPressed: () {
                            _model.searchApp.value = "";
                            search_text_controller.clear();
                          },
                          icon: Icon(Icons.cancel),
                        ),
                      ),

                      onChanged: (a) {
                        _model.searchApp.value = a;
                      },
                      onTapOutside: (event) {
                        FocusScope.of(
                          context,
                        ).unfocus(); // Removes focus when tapping outside this field
                      },
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 13),
                      child: ValueListenableBuilder(
                        valueListenable: _model.searchApp,
                        builder: (context, value, child) {
                          return ListView(
                            children: [
                              for (var a in filteredValue)
                                if (a.name.toLowerCase().contains(
                                  value.toLowerCase(),
                                ))
                                  CheckboxListTile(
                                    //leading: Image.memory(a.iconBytes ?? [] as Uint8List),
                                    title: Row(
                                      spacing: 34,
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: Image.memory(
                                            a.icon ?? Uint8List(1),
                                            width: 55,
                                            fit: BoxFit.contain,
                                          ),
                                          onLongPress: () {
                                            InstalledApps.startApp(
                                              a.packageName,
                                            );
                                          },
                                        ),
                                        Expanded(
                                          child: Text(
                                            a.name.toString(),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    value: _model.editSelectedApps.apps
                                        .contains(a.packageName.toString()),

                                    onChanged: (aa) {
                                      // print(_model.editSelectedApps.apps.toString());
                                      if (aa ?? false) {
                                        _model.editSelectedApps.apps.add(
                                          a.packageName.toString(),
                                        );
                                      } else {
                                        _model.editSelectedApps.apps.remove(
                                          a.packageName,
                                        );
                                      }
                                      setState(() {});
                                    },
                                  ),
                            ],
                          );
                        },
                      ),
                    ),
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
