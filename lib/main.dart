import 'dart:math' show Random;

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

const String appTitle = "TeaTone";

ColorScheme randomColorScheme([
  Brightness brightness = Brightness.light,
]) {
  final Random random = Random.secure();
  final r = random.nextInt(128) + 128;
  final g = random.nextInt(128) + 128;
  final b = random.nextInt(128) + 128;
  final seedColor = Color.fromRGBO(r, g, b, 1);
  return ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: brightness,
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(360, 560),
    center: true,
    title: appTitle,
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

class TeaToneApp extends StatelessWidget {
  const TeaToneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        colorScheme: randomColorScheme(),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const Placeholder(),
    );
  }
}
