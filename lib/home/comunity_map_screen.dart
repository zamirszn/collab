import 'dart:io';
import 'dart:math';

import 'package:awa/home/home_screen.dart';
import 'package:awa/home/task_board_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart'; // ignore: unnecessary_import
import 'package:mapbox_gl/mapbox_gl.dart';

const randomMarkerNum = 100;

class CustomMapScreen extends StatelessWidget {
  const CustomMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomMarker();
  }
}

class CustomMarker extends StatefulWidget {
  const CustomMarker({super.key});

  @override
  State createState() => CustomMarkerState();
}

class CustomMarkerState extends State<CustomMarker> {
  final Random _rnd = Random();

  late MapboxMapController _mapController;
  final List<Widget> _markers = [];
  final List<_MarkerState> _markerStates = [];

  void _addMarkerStates(_MarkerState markerState) {
    _markerStates.add(markerState);
  }

  void animateCamera(lat, long) {
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 270.0,
          target: LatLng(lat, long),
          tilt: 90.0,
          zoom: 14.0,
        ),
      ),
    );
  }

  void _onMapCreated(MapboxMapController controller) {
    _mapController = controller;

    animateCamera(9.077410766023869, 7.462809509821562);
    _addMarker(const Point(579.0, 875.9999389648438),
        const LatLng(9.078032040384088, 7.460573872852478));

    controller.addListener(() {
      if (controller.isCameraMoving) {
        _updateMarkerPosition();
      }
    });
  }

  void _onStyleLoadedCallback() {
    print('onStyleLoadedCallback');
  }

  void _onMapLongClickCallback(Point<double> point, LatLng coordinates) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        return AddTaskBottomSheet(
          callback: () => _addMarker(point, coordinates),
        );
      },
    );
  }

  void _onCameraIdleCallback() {
    _updateMarkerPosition();
  }

  void _updateMarkerPosition() {
    final coordinates = <LatLng>[];

    for (final markerState in _markerStates) {
      coordinates.add(markerState.getCoordinate());
    }

    _mapController.toScreenLocationBatch(coordinates).then((points) {
      _markerStates.asMap().forEach((i, value) {
        _markerStates[i].updatePosition(points[i]);
      });
    });
  }

  void _addMarker(Point<double> point, LatLng coordinates) {
    String loc = _rnd.nextInt(100000).toString();
    setState(() {
      _markers.add(Marker(
        loc,
        coordinates,
        point,
        _addMarkerStates,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        MapboxMap(
          accessToken: mapBoxToken,
          trackCameraPosition: true,
          compassEnabled: true,
          dragEnabled: true,
          rotateGesturesEnabled: true,
          onMapCreated: _onMapCreated,
          onMapLongClick: _onMapLongClickCallback,
          onCameraIdle: _onCameraIdleCallback,
          onStyleLoadedCallback: _onStyleLoadedCallback,
          initialCameraPosition:
              const CameraPosition(target: LatLng(35.0, 135.0), zoom: 5),
        ),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              enableDrag: true,
              context: context,
              builder: (context) {
                return TaskBoardBottomSheet(
                    task: TaskModel(
                  address: "Town Center",
                  contactPhoneNumber: "+1234567890",
                  deadline: DateTime(2023, 7, 1),
                  isUrgent: true,
                  posterName: "Local Business Alliance",
                  taskDescription:
                      "Join us for the Local Business Expo! Discover and support the diverse products and services offered by our community's businesses.",
                  taskTitle: "Local Business Expo",
                ));
              },
            );
          },
          child: Stack(
            children: _markers,
          ),
        )
      ]),
    );
  }

  // ignore: unused_element
  void _measurePerformance() {
    const trial = 10;
    final batches = [500, 1000, 1500, 2000, 2500, 3000];
    var results = <int, List<double>>{};
    for (final batch in batches) {
      results[batch] = [0.0, 0.0];
    }

    _mapController.toScreenLocation(const LatLng(0, 0));
    Stopwatch sw = Stopwatch();

    for (final batch in batches) {
      //
      // primitive
      //
      for (var i = 0; i < trial; i++) {
        sw.start();
        var list = <Future<Point<num>>>[];
        for (var j = 0; j < batch; j++) {
          var p = _mapController
              .toScreenLocation(LatLng(j.toDouble() % 80, j.toDouble() % 300));
          list.add(p);
        }
        Future.wait(list);
        sw.stop();
        results[batch]![0] += sw.elapsedMilliseconds;
        sw.reset();
      }

      //
      // batch
      //
      for (var i = 0; i < trial; i++) {
        sw.start();
        var param = <LatLng>[];
        for (var j = 0; j < batch; j++) {
          param.add(LatLng(j.toDouble() % 80, j.toDouble() % 300));
        }
        Future.wait([_mapController.toScreenLocationBatch(param)]);
        sw.stop();
        results[batch]![1] += sw.elapsedMilliseconds;
        sw.reset();
      }

      print(
          'batch=$batch,primitive=${results[batch]![0] / trial}ms, batch=${results[batch]![1] / trial}ms');
    }
  }
}

class Marker extends StatefulWidget {
  final Point _initialPosition;
  final LatLng _coordinate;
  final void Function(_MarkerState) _addMarkerState;

  Marker(
    String key,
    this._coordinate,
    this._initialPosition,
    this._addMarkerState,
  ) : super(key: Key(key));

  @override
  State<StatefulWidget> createState() {
    final state = _MarkerState(_initialPosition);
    _addMarkerState(state);
    return state;
  }
}

class _MarkerState extends State with TickerProviderStateMixin {
  final _iconSize = 20.0;

  Point _position;

  late AnimationController _controller;
  late Animation<double> _animation;

  _MarkerState(this._position);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var ratio = 1.0;

    //web does not support Platform._operatingSystem
    if (!kIsWeb) {
      // iOS returns logical pixel while Android returns screen pixel
      ratio = Platform.isIOS ? 1.0 : MediaQuery.of(context).devicePixelRatio;
    }

    return Positioned(
        left: _position.x / ratio - _iconSize / 2,
        top: _position.y / ratio - _iconSize / 2,
        child: const Icon(
          Icons.place,
          color: Colors.deepPurple,
          size: 35,
        ));
  }

  void updatePosition(Point<num> point) {
    setState(() {
      _position = point;
    });
  }

  LatLng getCoordinate() {
    return (widget as Marker)._coordinate;
  }
}

const OutlineInputBorder searchFieldOutlineBorder = OutlineInputBorder(
    borderSide: BorderSide(width: 1, color: Colors.black38),
    borderRadius: BorderRadius.all(Radius.circular(10)));

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key, required this.callback});
  final VoidCallback callback;
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final txtCtrl = TextEditingController();
  bool isUrgent = false;

  Size? screenSize;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        border: Border.all(
          width: 5,
          color: Colors.transparent,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      height: screenSize!.height / 1.4,
      width: screenSize?.width,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: Center(
                child: SizedBox(
                    width: 50,
                    height: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade500,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 14.0),
              child: Center(
                  child: Text(
                "Need",
                style: TextStyle(fontSize: 22),
              )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextFormField(
                controller: txtCtrl,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  border: searchFieldOutlineBorder,
                  enabledBorder: searchFieldOutlineBorder,
                  focusedBorder: searchFieldOutlineBorder,
                  prefixIcon: Icon(
                    Icons.task_alt_rounded,
                    color: Colors.black,
                  ),
                  hintText: "Post your task here",
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  border: searchFieldOutlineBorder,
                  enabledBorder: searchFieldOutlineBorder,
                  focusedBorder: searchFieldOutlineBorder,
                  prefixIcon: Icon(
                    Icons.description,
                    color: Colors.black,
                  ),
                  hintText: "Add a Description",
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text("Urgent:"),
                  const SizedBox(
                    width: 10,
                  ),
                  Switch(
                    value: isUrgent,
                    onChanged: (newValue) {
                      isUrgent = newValue;

                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                    label: const Text("Cancel")),
                ElevatedButton.icon(
                    onPressed: () {
                      widget.callback();
                      allCommunityEvents.add(TaskModel(
                          address: "No 2b Barnawa, Kaduna",
                          contactPhoneNumber: "+2349029709898",
                          deadline: DateTime(2024),
                          isUrgent: true,
                          posterName: "Mubarak Lawal",
                          taskDescription:
                              "Due to my work i need someone to baby sit my 5 year old twin",
                          taskTitle: txtCtrl.text));
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.check),
                    label: const Text("Done")),
              ],
            )
          ]),
    );
  }
}
