import 'package:awa/home/home_screen.dart';
import 'package:awa/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const NeedsApp());
}

class NeedsApp extends StatelessWidget {
  const NeedsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Collab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "PulpDisplay",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LiquidSwipeOnboarding(),
    );
  }
}
