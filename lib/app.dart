import 'dart:math' show Random;

import 'package:flutter/material.dart';
import 'package:teatone/case/case.dart';

class TeaToneApp extends StatelessWidget {
  static const String title = "TeaTone";

  const TeaToneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _randomColor()),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const CasePage(),
    );
  }

  Color _randomColor() {
    final Random random = Random.secure();
    final r = random.nextInt(128) + 128;
    final g = random.nextInt(128) + 128;
    final b = random.nextInt(128) + 128;
    final seedColor = Color.fromRGBO(r, g, b, 1);
    return seedColor;
  }
}

/// TODO: Problems
/// 1. Display state -> BLS logic
/// 2. Case with build context