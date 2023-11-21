import 'package:awa/home/center_home_page.dart';
import 'package:awa/home/chat_screen.dart';
import 'package:awa/home/left_home_page.dart';
import 'package:awa/home/overlapping.dart';
import 'package:awa/home/right_home_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        OverlappingPanels(
          onSideChange: (value) {},
          left: Builder(builder: (context) {
            return const LeftHomePage();
          }),
          main: Builder(
            builder: (context) {
              if (isChatScreenShown == true) {
                return const ChatScreen(
                  title: "Awa Community",
                );
              } else {
                return const MapHomePage();
              }
            },
          ),
          right: Builder(
            builder: (context) {
              return const RightHomePage();
            },
          ),
        ),
      ],
    ));
  }
}

bool isChatScreenShown = false;
bool isDmViewShown = true;
