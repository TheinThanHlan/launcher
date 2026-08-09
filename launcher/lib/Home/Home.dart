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
                    padding: EdgeInsetsGeometry.only(
                      left: 55,
                      right: 55,
                      top: 55,
                      bottom: 55,
                    ),
                    child: GridView.count(
                      crossAxisCount: 4,
                      mainAxisSpacing: 21,
                      crossAxisSpacing: 21,
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
                          child: Container(
                            width: 89,
                            height: 89,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.apps, size: 55),
                                Text(
                                  "Show App Chooser",
                                  maxLines: 2,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
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
                              child: Container(
                                width: 89,
                                height: 89,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 13,
                                  children: [
                                    Image.memory(
                                      a.iconBytes ?? Uint8List(0),
                                      fit: BoxFit.fitHeight,
                                      height: 55,
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
