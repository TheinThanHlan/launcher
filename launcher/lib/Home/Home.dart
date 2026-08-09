import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_device_apps/flutter_device_apps.dart';
import 'package:launcher/SelectApp/SelectApp.dart';
import 'package:launcher/SelectApp/SelectAppController.dart';
import 'package:launcher/SelectApp/SelectAppModel.dart';
import 'package:launcher/data/dao/SelectedAppsDao.dart';
import 'package:launcher/data/model/AppInfoExtension.dart';
import 'package:launcher/data/model/SelectedApps.dart';
import 'package:winter/winter.dart';
import "HomeModel.dart";

class Home extends StatelessWidget implements WinterView {
  //late final HomeController c;
  final WinterLanguageFactory _lf;
  final HomeModel _model;
  Home(this._lf, this._model);
  @override
  Widget build(BuildContext context) {
    //    return LayoutBuilder(builder: (context, constraints) {
    //      return Desktop(c);
    //    });
    return ValueListenableBuilder(
      valueListenable: getIt<ValueNotifier<List<AppInfo>>>(),
      builder: (context, value, child) => StatefulBuilder(
        builder: (context, setState) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: FutureBuilder(
              future: getIt<SelectedAppsDao>().fetchShowApps(),
              builder: (context, snapshot) {
                //if (snapshot.data != null) {
                //  snapshot.data!.forEach((a) {
                //    print(a.toJson());
                //  });
                //}
                //final SelectedApps showApps = snapshot.data as SelectedApps;
                //
                if (snapshot.data != null) {
                  return Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 13,
                      vertical: 21,
                    ),
                    child: GridView.count(
                      crossAxisCount:
                          ((MediaQuery.of(context).size.width / 144) * 1.618)
                              .toInt(),
                      mainAxisSpacing: 5,
                      semanticChildCount: snapshot.data!.apps.length,
                      crossAxisSpacing: 8,
                      childAspectRatio: 3 / 5,
                      shrinkWrap: false,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    getIt<SelectAppController>(
                                      param1: SelectAppModel(
                                        selectedApps: snapshot.data!,
                                        pageTitle: "Show App Chooser",
                                        actionButtonTitle: "Change",
                                        onActionClicked: (a) {
                                          getIt<SelectedAppsDao>()
                                              .updateShowApps(a)
                                              .then((x) {
                                                setState(() {});
                                              });
                                        },
                                      ),
                                    ).getView(),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(child: Icon(Icons.apps), radius: 21),
                              Text(
                                "Show App Chooser",
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        for (var a in value)
                          if (snapshot.data!.apps.contains(a.packageName))
                            InkWell(
                              onTap: () {
                                if (a.packageName != null) {
                                  FlutterDeviceApps.openApp(a.packageName!);
                                }
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 8,
                                children: [
                                  CircleAvatar(
                                    radius: 21,
                                    child: Image.memory(
                                      a.iconBytes ?? Uint8List(0),
                                    ),
                                  ),
                                  Text(
                                    "${a.appName}",
                                    maxLines: 2,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                      ],
                    ),
                  );
                }
                return Container(color: Colors.green);
              },
            ),
          );
        },
      ),
    );
  }
}
