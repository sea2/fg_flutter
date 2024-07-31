library app;

import 'package:app/src/di/component/app_component.jugger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:td_client/td_client.dart';

import 'src/di/component/app_component.dart';

Future<void> launch() async {
  WidgetsFlutterBinding.ensureInitialized();
  final IAppComponent appComponent = JuggerAppComponent.create();
  await appComponent.appInitializer.init();
  appComponent.appController.onInit();


// 订阅事件
//   eventBus.on<MyEvent>().listen((event) {
//     appComponent.CommonScreenRouter.toChat(1);
//   });
  // Future.delayed(Duration(seconds: 5), () {
  //   appComponent.CommonScreenRouter.toChat(1);
  // });
}
