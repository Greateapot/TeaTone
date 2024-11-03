import 'package:flutter/material.dart';
import 'package:teatone/app.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(360, 560),
    center: true,
    title: TeaToneApp.title,
    windowButtonVisibility: true,
    skipTaskbar: false,
  );

  windowManager.setResizable(false);
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const TeaToneApp());
}
