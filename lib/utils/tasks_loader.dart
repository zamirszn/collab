import 'dart:convert';

class TasksRequest {
  // Future getDigitaltasks() async {
  //   Iterable jsonResponse = digitaltasks;
  //   List<Tasks> tasks =
  //       List<Tasks>.from(jsonResponse.map((model) => Tasks.fromJson(model)));

  //   return tasks;
  // }

  
}

Tasks tasksFromJson(String str) => Tasks.fromJson(json.decode(str));

class Tasks {
  String? taskTitle;
  String? taskDescription;
  String? taskIndustry;
  String? taskImage;

  Tasks({
    this.taskTitle,
    this.taskDescription,
    this.taskIndustry,
    this.taskImage,
  });

  Tasks.fromJson(Map<String, dynamic> json) {
    taskTitle = json['taskTitle'];
    taskDescription = json['taskDescription'];
    taskIndustry = json['taskIndustry'];
    taskImage = json['taskImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['taskTitle'] = taskTitle;
    data['taskDescription'] = taskDescription;
    data['taskIndustry'] = taskIndustry;
    data['taskImage'] = taskImage;

    return data;
  }
}




final List<Map<String, dynamic>> myDigitaltasks = [
  {
    "taskTitle": "Silicon Valley Agency",
    "taskDescription": "Specialize in making kuberetes solutions ",
    "taskIndustry": "Cloud Tech",
    "taskImage": "images/task5.jpg"
  },
  {
    "taskTitle": "Stimson",
    "taskDescription":
        "Scale and manage your businesses with us, we are a California based startup",
    "taskIndustry": "DevOps",
    "taskImage": "images/task2.jpg"
  },
  {
    "taskTitle": "DataStax Devs",
    "taskDescription":
        "Making the world a better place one line code at a time",
    "taskIndustry": "Software design",
    "taskImage": "images/task3.jpg"
  },
];

final List<Map<String, dynamic>> directMessages = [
  {
    "name": "Habeebah Lawal",
    "avatar": "images/user1.jpg",
    "isActive": true,
    "status": "Having Lunch"
  },
  {
    "name": "Doris Yang",
    "avatar": "images/user2.jpg",
    "isActive": true,
    "status": "Active"
  },
  {
    "name": "Trevor De-Santa",
    "avatar": "images/user3.jpg",
    "isActive": false,
    "status": "On Vacation"
  },
  {
    "name": "Zamira Arthur",
    "avatar": "images/user4.jpg",
    "isActive": true,
    "status": "Busy"
  },
  {
    "name": "Mubarak Lawal",
    "avatar": "images/user5.jpg",
    "isActive": false,
    "status": "Building AWa"
  },
];

final List<Map<String, dynamic>> activeUsers = [
  {
    "name": "Habeebah Lawal",
    "avatar": "images/user1.jpg",
    "isActive": true,
    "status": "Having Lunch"
  },
  {
    "name": "Doris Yang",
    "avatar": "images/user2.jpg",
    "isActive": true,
    "status": "Active"
  },
  {
    "name": "Zamira Arthur",
    "avatar": "images/user4.jpg",
    "isActive": true,
    "status": "Busy"
  },
  {
    "name": "Mubarak Lawal",
    "avatar": "images/user5.jpg",
    "isActive": true,
    "status": "Building Awa"
  },
];

List<CommunityMessageModel> messages = [
  CommunityMessageModel(
      sender: "Mubarak Lawal",
      text: "Hey hi guys :)",
      date: DateTime.now().subtract(const Duration(days: 4, minutes: 3)),
      isSentByMe: false),
  CommunityMessageModel(
      sender: "Me",
      text: "How's the project coming",
      date: DateTime.now().subtract(const Duration(days: 3, minutes: 2)),
      isSentByMe: true),
  CommunityMessageModel(
      sender: "Zamira Arthur",
      text: "We're almost done with the demo",
      date: DateTime.now().subtract(const Duration(days: 3, minutes: 5)),
      isSentByMe: false),
  CommunityMessageModel(
      sender: "Me",
      text: "Okay great, can you please upload it ",
      date: DateTime.now().subtract(const Duration(days: 3, minutes: 10)),
      isSentByMe: true),
  CommunityMessageModel(
      sender: "Zamira Arthur",
      text: "Yeah, sure",
      date: DateTime.now().subtract(const Duration(days: 2, minutes: 25)),
      isSentByMe: false),
  CommunityMessageModel(
      sender: "Doris Yang",
      text: "And also make it private please",
      date: DateTime.now().subtract(const Duration(days: 2, minutes: 3)),
      isSentByMe: false),
  CommunityMessageModel(
      sender: "Me",
      text: "Alright, send me an invitaton",
      date: DateTime.now().subtract(const Duration(days: 2, minutes: 3)),
      isSentByMe: true),
  CommunityMessageModel(
      sender: "Mubarak Lawal",
      text: "Okay, whats your email",
      date: DateTime.now().subtract(const Duration(days: 1, minutes: 40)),
      isSentByMe: false),
  CommunityMessageModel(
      sender: "Me",
      text: "zamirszn@gmail.com",
      date: DateTime.now().subtract(const Duration(days: 1, minutes: 3)),
      isSentByMe: true),
];



class CommunityMessageModel {
  final String text;
  final DateTime date;
  final bool isSentByMe;
  final String sender;

  CommunityMessageModel(
      {required this.sender,
      required this.text,
      required this.date,
      required this.isSentByMe});
}





