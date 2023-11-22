import 'package:awa/utils/colors.dart';
import 'package:awa/home/home_screen.dart';
import 'package:awa/onboarding/liquid_card_swipe.dart';
import 'package:awa/onboarding/liquid_swipe_view.dart';
import 'package:flutter/material.dart';

class LiquidSwipeOnboarding extends StatefulWidget {
  const LiquidSwipeOnboarding({Key? key}) : super(key: key);

  @override
  State<LiquidSwipeOnboarding> createState() => _LiquidSwipeOnboardingState();
}

class _LiquidSwipeOnboardingState extends State<LiquidSwipeOnboarding> {
  final _key = GlobalKey<LiquidSwipeState>();

  LiquidSwipeState? get liquidSwipeController => _key.currentState;

  bool isLastPage = false;
  final controller = PageController();

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(
        key: _key,
        children: [
          /// First page
          LiquidSwipeCard(
            onTapName: () {},
            onSkip: () async {
              final navigator = Navigator.of(context);

              navigator.pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            },
            name: "Collab",
            action: "Skip",
            image: const AssetImage("images/comm2.jpg"),
            title: "Join the ",
            subtitle: "Collab Community",
            body: "Ready to make a difference? \n"
                "The comunity is here for you",
            buttonColor: needsAppBlackBlue,
            titleColor: Colors.grey.shade700,
            subtitleColor: Colors.grey.shade900,
            bodyColor: needsAppBlackBlue,
            gradient: const LinearGradient(
              colors: [Colors.white, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),

          /// Second page
          LiquidSwipeCard(
            onTapName: () => liquidSwipeController?.previous(),
            onSkip: () async {
              final navigator = Navigator.of(context);

              navigator.pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            },
            name: "Back",
            action: "Done",
            image: const AssetImage("images/comm.jpg"),
            title: "Welcome to",
            subtitle: "Collab Community",
            body: "Building Stronger Communities\n"
                "Connect with your neighbors,\n"
                "share resources, and network",
            buttonColor: Colors.white,
            titleColor: Colors.grey.shade500,
            subtitleColor: Colors.grey.shade200,
            bodyColor: Colors.white.withOpacity(0.8),
            gradient: LinearGradient(
              colors: [Colors.grey, needsAppBlackBlue],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
        ],
      ),
    );
  }
}
