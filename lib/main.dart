import 'dart:async';
import 'dart:developer';

import 'package:exchange/app.dart';
import 'package:exchange/core/dependecies.dart';
import 'package:flutter/material.dart';

void main() {
  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized();
    appRunner();
  }, (e, s) {
    ///TODO crashlitic
    log(e.toString());
  });
}

Future<void> appRunner() async {
  final binding = WidgetsFlutterBinding.ensureInitialized()..deferFirstFrame();

  final AppDependencies dependencies = AppDependencies();
  await dependencies.init();

  binding.allowFirstFrame();

  return runApp(App(appDependencies: dependencies));
}
