import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_soloud/flutter_soloud.dart';
import 'package:flutter_svg/svg.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:launcher/SelectApp/SelectAppController.dart';
import 'package:launcher/SelectApp/SelectAppModel.dart';
import 'package:launcher/data/dao/SelectedAppsDao.dart';
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
                      semanticChildCount: snapshot.data!.apps.length,
                      childAspectRatio: 0.9,
                      children: [
                        InkWell(
                          onTap: () async {
                            getIt<SoLoud>().play(
                              getIt<AudioSource>(instanceName: "pop_sound"),
                            );
                          },

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 13,
                            children: [
                              SvgPicture.asset(
                                "lib/resources/bubble-3-svgrepo-com.svg",
                                width: 34,
                                height: 34,
                              ),
                              Text(
                                "Pop bubble",
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    getIt<SelectAppController>(
                                      param1: SelectAppModel(
                                        includeSystemApps: true,
                                        onlyLaunchable: true,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 13,
                            children: [
                              CircleAvatar(radius: 21, child: Icon(Icons.apps)),
                              Text(
                                "Show App Chooser",
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    getIt<SelectAppController>(
                                      param1: SelectAppModel(
                                        selectedApps: SelectedApps([]),
                                        includeSystemApps: false,
                                        onlyLaunchable: false,
                                        pageTitle: "Delete Apps",
                                        actionButtonTitle: "Delete",
                                        onActionClicked: (a) async {
                                          var tmpAa = SelectedApps(
                                            snapshot.data!.apps
                                                .where(
                                                  (b) => !a.apps.contains(b),
                                                )
                                                .toList(),
                                          );
                                          await getIt<SelectedAppsDao>()
                                              .updateShowApps(tmpAa);

                                          for (var b in a.apps) {
                                            await InstalledApps.uninstallApp(b);
                                          }
                                          setState(() {});
                                        },
                                      ),
                                    ).getView(),
                              ),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 13,
                            children: [
                              CircleAvatar(
                                radius: 21,
                                child: Icon(Icons.delete),
                              ),
                              Text(
                                "Delete Apps",
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        for (var a in value)
                          if (snapshot.data!.apps.contains(a.packageName))
                            InkWell(
                              onTap: () async {
                                InstalledApps.startApp(a.packageName);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                spacing: 8,
                                children: [
                                  CircleAvatar(
                                    radius: 21,
                                    child: Image.memory(a.icon ?? Uint8List(0)),
                                  ),
                                  Text(
                                    a.name,
                                    maxLines: 2,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
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
