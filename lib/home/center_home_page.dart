import 'package:awa/home/overlapping.dart';
import 'package:flutter/material.dart';

class MapHomePage extends StatefulWidget {
  const MapHomePage({super.key});

  @override
  State<MapHomePage> createState() => _MapHomePageState();
}

class _MapHomePageState extends State<MapHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatHeaderSlivers: true,
      appBar: AppBar(
        title: const Text(
          "Awa Community",
        ),
        actions: [
          IconButton(
              onPressed: () {
                OverlappingPanels.of(context)?.reveal(RevealSide.right);
              },
              icon: const Icon(Icons.people_alt_rounded))
        ],
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
          ),
          onPressed: () {
            OverlappingPanels.of(context)?.reveal(RevealSide.left);
          },
        ),
      ),

      body: const Center(child: Text("Map Box ")),
    );
  }
}
