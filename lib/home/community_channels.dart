import 'package:flutter/material.dart';

class CommunityChannelsView extends StatelessWidget {
  const CommunityChannelsView({
    super.key,
    required this.taskChanneName,
    required this.taskChanneImage,
    required this.taskChanneDescription,
  });
  final String taskChanneName;
  final String taskChanneImage;
  final String taskChanneDescription;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SafeArea(
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: AssetImage(taskChanneImage),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[100]!))),
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            taskChanneName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        taskChanneDescription,
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Material(
                    color: Colors.white,
                    child: ListView(
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.only(top: 16, left: 16, right: 16),
                          child: Text(
                            'CHANNELS',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.grey),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 30.0),
                          child: ListTile(
                            leading: Icon(Icons.broadcast_on_personal_rounded),
                            title: Text("Community"),
                            trailing: Icon(Icons.mic_off),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 30.0),
                          child: ListTile(
                            leading: Icon(Icons.work_rounded),
                            title: Text("Projects"),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 30.0),
                          child: ListTile(
                            leading: Icon(Icons.cloud_upload_rounded),
                            title: Text("Cloud"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30.0),
                          child: ExpansionTile(
                            leading: const Icon(Icons.videocam_rounded),
                            title: const Text("Meet"),
                            trailing: const Icon(Icons.keyboard_arrow_down),
                            children: [
                              ListTile(
                                leading: const Icon(Icons.videocam_rounded),
                                title: const Text("Schedule a meeting"),
                                onTap: () {
                                  // showScheduleMeetingBottomSheet(
                                  //     context, deviceScreen);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.alarm),
                                title: const Text("Set a reminder"),
                                onTap: () {
                                  // setReminderBottomSheet(context, deviceScreen);
                                },
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 30.0),
                          child: ListTile(
                            leading: Icon(Icons.work_rounded),
                            title: Text("Tools"),
                            trailing: Icon(Icons.keyboard_arrow_down),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 30.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.people_alt_rounded,
                              color: Colors.blue,
                            ),
                            title: Text("Team taskChanne"),
                            trailing: Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
