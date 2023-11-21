import 'package:awa/home/community_channels.dart';
import 'package:awa/home/direct_message_screen.dart';
import 'package:awa/widgets/navigation_button.dart';
import 'package:flutter/material.dart';

class LeftHomePage extends StatefulWidget {
  const LeftHomePage({Key? key}) : super(key: key);

  @override
  State<LeftHomePage> createState() => _LeftHomePageState();
}

class _LeftHomePageState extends State<LeftHomePage> {
  bool isChatScreenShown = false;
  bool isDmViewShown = true;

  @override
  void initState() {
    super.initState();
    loadMyTasks();
  }

  loadMyTasks() async {}

  @override
  Widget build(BuildContext context) {
    final Size deviceScreen = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
            color: Colors.grey[200],
            width: deviceScreen.width,
            height: deviceScreen.height,
            child: Row(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      NavigationButton(
                          onPressed: () {
                            isChatScreenShown = false;
                            isDmViewShown = true;
                          },
                          iconData: Icons.workspaces_rounded),
                      NavigationButton(
                          onPressed: () {}, iconData: Icons.settings),
                    ],
                  ),
                ),
                if (isDmViewShown == true) const DirectMessageView(),
                if (isDmViewShown == false)
                  const CommunityChannelsView(
                    taskChanneDescription: "Awa Channel",
                    taskChanneImage: "images/user3.jpg",
                    taskChanneName: "Awa Channel",
                  )
              ],
            )),
      ),
    );
  }
}
