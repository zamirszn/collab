import 'package:awa/home/chat_screen.dart';
import 'package:awa/home/comunity_map_screen.dart';
import 'package:awa/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class TaskBoardScreen extends StatefulWidget {
  const TaskBoardScreen({super.key});

  @override
  State<TaskBoardScreen> createState() => _TaskBoardScreenState();
}

class _TaskBoardScreenState extends State<TaskBoardScreen> {
  List<TaskModel> filteredCommunityTasks = [];

  @override
  void initState() {
    filteredCommunityTasks = allCommunityEvents;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: filteredCommunityTasks.length,
              itemBuilder: (context, index) {
                TaskModel task = filteredCommunityTasks[index];

                return ListTile(
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      enableDrag: true,
                      context: context,
                      builder: (context) {
                        return TaskBoardBottomSheet(
                          task: task,
                        );
                      },
                    );
                  },
                  leading: const Icon(Icons.place),
                  title: Text(
                    task.taskTitle,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black),
                  ),
                  trailing: task.isUrgent
                      ? const Icon(Icons.warning_rounded)
                      : const SizedBox(),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.taskDescription,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      Text(
                        "${task.posterName} - ${task.address}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.black87),
                      ),
                    ],
                  ),
                );

                // return ContactsWidget(
                //     name: allCommunityEvents[index].posterName,
                //     avatar: "images/user5.jpg",
                //     onTap: () {},
                //     status: "Online",
                //     isActive: true);
              }),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 5),
          child: TextFormField(
            onChanged: (value) {
              setState(() {
                filteredCommunityTasks = allCommunityEvents
                    .where((task) => task.taskTitle
                        .toLowerCase()
                        .contains(value.toLowerCase()))
                    .toList();
              });
            },
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              border: searchFieldOutlineBorder,
              enabledBorder: searchFieldOutlineBorder,
              focusedBorder: searchFieldOutlineBorder,
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              hintText: "Search tasks close to you",
            ),
          ),
        ),
      ],
    );
  }
}

class TaskBoardBottomSheet extends StatelessWidget {
  const TaskBoardBottomSheet({super.key, required this.task});
  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

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
        height: screenSize.height / 1.12,
        width: screenSize.width,
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
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: screenSize.height / 2,
                  child: MapboxMap(
                    accessToken: mapBoxToken,
                    trackCameraPosition: true,
                    compassEnabled: true,
                    dragEnabled: true,
                    rotateGesturesEnabled: true,
                    // onMapCreated: _onMapCreated,
                    // onMapLongClick: _onMapLongClickCallback,
                    // onCameraIdle: _onCameraIdleCallback,
                    // onStyleLoadedCallback: _onStyleLoadedCallback,
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(35.0, 135.0),
                      tilt: 90.0,
                      zoom: 14.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.place),
                title: Text(
                  task.taskTitle,
                  maxLines: 2,
                  style: const TextStyle(color: Colors.black),
                ),
                trailing: task.isUrgent
                    ? const Icon(Icons.warning_rounded)
                    : const SizedBox(),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.taskDescription,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    Text(
                      "${task.posterName} - ${task.address}",
                      style: const TextStyle(color: Colors.black87),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChatPage(),
                          ));
                    },
                    icon: const Icon(Icons.messenger_rounded),
                    label: const Text("Message")),
              ),
            ]));
  }
}

List<TaskModel> allCommunityEvents = [
  TaskModel(
    address: "Green Valley Park",
    contactPhoneNumber: "+1234567890",
    deadline: DateTime(2023, 5, 20),
    isUrgent: true,
    posterName: "Community Strides for Change Committee",
    taskDescription:
        "Join us for the 'Community Strides for Change' charity run, where every step makes a difference! Lace up your running shoes and hit the scenic trails of Green Valley Park to support local charities dedicated to education and healthcare.",
    taskTitle: "Community Strides for Change",
  ),
  TaskModel(
    address: "Local Streets and Parks",
    contactPhoneNumber: "+1234567890",
    deadline: DateTime(2023, 6, 10),
    isUrgent: false,
    posterName: "Community Cleanup Committee",
    taskDescription:
        "Come together with your neighbors to clean and beautify our local streets and parks. Let's make our community shine!",
    taskTitle: "Neighborhood Clean-up Day",
  ),
  TaskModel(
    address: "Town Center",
    contactPhoneNumber: "+1234567890",
    deadline: DateTime(2023, 7, 1),
    isUrgent: true,
    posterName: "Local Business Alliance",
    taskDescription:
        "Join us for the Local Business Expo! Discover and support the diverse products and services offered by our community's businesses.",
    taskTitle: "Local Business Expo",
  ),
  TaskModel(
    address: "Central Park",
    contactPhoneNumber: "+1234567890",
    deadline: DateTime(2023, 8, 15),
    isUrgent: false,
    posterName: "Community Arts Council",
    taskDescription:
        "Experience the vibrant cultural scene in our community at the Annual Art Fair. Local artists will showcase their talent, and you can even participate in interactive workshops!",
    taskTitle: "Annual Art Fair",
  ),
  TaskModel(
    address: "Community Center",
    contactPhoneNumber: "+1234567890",
    deadline: DateTime(2023, 9, 5),
    isUrgent: true,
    posterName: "Community Council",
    taskDescription:
        "Let's discuss the future of our community! Join us for a Town Hall Meeting where your voice matters. Together, we can shape a better tomorrow.",
    taskTitle: "Town Hall Meeting",
  ),
  TaskModel(
    address: "Downtown Square",
    contactPhoneNumber: "+1234567890",
    deadline: DateTime(2023, 10, 1),
    isUrgent: false,
    posterName: "Community Events Committee",
    taskDescription:
        "Celebrate the rich diversity of our community at the Annual Street Festival. Enjoy music, dance, food, and fun activities for the whole family!",
    taskTitle: "Annual Street Festival",
  ),
  TaskModel(
    address: "Various Locations",
    contactPhoneNumber: "+1234567890",
    deadline: DateTime(2023, 11, 15),
    isUrgent: true,
    posterName: "Community Potluck Organizers",
    taskDescription:
        "Bring your favorite dish and join us for a Community Potluck. Let's share delicious food and good company!",
    taskTitle: "Community Potluck",
  ),
  TaskModel(
    address: "Public Library",
    contactPhoneNumber: "+1234567890",
    deadline: DateTime(2023, 12, 1),
    isUrgent: false,
    posterName: "Book Club Facilitators",
    taskDescription:
        "Are you a book lover? Join our Book Club Gathering at the public library to discuss and discover new literary gems.",
    taskTitle: "Book Club Gathering",
  ),
  TaskModel(
    address: "Community Garden",
    contactPhoneNumber: "+1234567890",
    deadline: DateTime(2024, 1, 10),
    isUrgent: true,
    posterName: "Community Gardening Group",
    taskDescription:
        "Get your hands dirty and join us for a day of community gardening. Let's nurture our green spaces together!",
    taskTitle: "Community Gardening Day",
  ),
  TaskModel(
    address: "City Park",
    contactPhoneNumber: "+1234567890",
    deadline: DateTime(2024, 2, 5),
    isUrgent: false,
    posterName: "Community Events Committee",
    taskDescription:
        "Bring your blankets and enjoy an Outdoor Movie Night under the stars. A perfect evening for families and friends!",
    taskTitle: "Outdoor Movie Night",
  ),
  TaskModel(
    address: "Community Center",
    contactPhoneNumber: "+1234567890",
    deadline: DateTime(2024, 3, 1),
    isUrgent: true,
    posterName: "Health and Wellness Committee",
    taskDescription:
        "Take a step towards a healthier life at our Health and Wellness Fair. Free screenings, fitness classes, and valuable health information await you!",
    taskTitle: "Health and Wellness Fair",
  ),
  TaskModel(
    address: "Town Center",
    contactPhoneNumber: "+1234567890",
    deadline: DateTime(2024, 4, 15),
    isUrgent: false,
    posterName: "Local Business Alliance",
    taskDescription:
        "Support local businesses and discover unique products and services at the Spring Edition of the Local Business Expo.",
    taskTitle: "Spring Local Business Expo",
  ),
  TaskModel(
    address: "Sports Complex",
    contactPhoneNumber: "+1234567890",
    deadline: DateTime(2024, 5, 1),
    isUrgent: true,
    posterName: "Community Sports League",
    taskDescription:
        "Compete and have fun! Join our Sports Tournament featuring soccer, basketball, and softball. All skill levels welcome!",
    taskTitle: "Community Sports Tournament",
  ),
  TaskModel(
    address: "Downtown Streets",
    contactPhoneNumber: "+1234567890",
    deadline: DateTime(2024, 6, 15),
    isUrgent: false,
    posterName: "Community Events Committee",
    taskDescription:
        "Celebrate the holiday season with our festive Holiday Parade. Join us for a joyful procession through downtown!",
    taskTitle: "Holiday Parade",
  ),
  TaskModel(
    address: "Senior Center",
    contactPhoneNumber: "+1234567890",
    deadline: DateTime(2024, 7, 1),
    isUrgent: true,
    posterName: "Senior Citizens Association",
    taskDescription:
        "Seniors, come together for a day of socializing and fun activities at the Senior Citizens Social. Make new friends and enjoy the day!",
    taskTitle: "Senior Citizens Social",
  ),
  // Add more events based on the list I provided earlier
  // ...
];

class TaskModel {
  final String taskTitle;
  final String taskDescription;
  final String posterName;
  final String contactPhoneNumber;
  final String address;
  final DateTime deadline;
  final bool isUrgent;

  TaskModel({
    required this.taskTitle,
    required this.taskDescription,
    required this.posterName,
    required this.contactPhoneNumber,
    required this.address,
    required this.deadline,
    required this.isUrgent,
  });
}
