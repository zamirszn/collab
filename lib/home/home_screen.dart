import 'package:awa/home/comunity_map_screen.dart';
import 'package:awa/home/task_board_screen.dart';
import 'package:awa/home/volunteer_screen.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.person_2_rounded))
        ],
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 55,
            ),
            Text('Collab '),
            Icon(
              Icons.handshake_outlined,
              size: 30,
            )
          ],
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.place),
            label: 'Community Map',
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment),
            label: 'Upcoming Events',
          ),
          NavigationDestination(
            icon: Icon(Icons.people),
            label: 'Volunteer Hub',
          ),
        ],
      ),
    );
  }
}

final List<Widget> _pages = [
  const CustomMapScreen(),
  const TaskBoardScreen(),
  const VolunteerScreen(),
];

const String mapBoxToken =
    "sk.eyJ1IjoiemFtaXJzem4iLCJhIjoiY2xwOGZjMXhrMmp4aDJqcW90dDIwb24yNCJ9.F8FMXnC18m6tm_0cgVDTmw";

LatLng myLoc = const LatLng(10.45968, 7.39233);
