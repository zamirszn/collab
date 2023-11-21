import 'package:awa/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AwaApp());
}

class AwaApp extends StatelessWidget {
  const AwaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awa',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LiquidSwipeOnboarding(),
    );
  }
}
