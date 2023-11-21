import 'package:awa/utils/colors.dart';
import 'package:awa/home/direct_message_screen.dart';
import 'package:awa/home/overlapping.dart';
import 'package:awa/utils/tasks_loader.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.title});
  final String title;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageTextFieldController =
      TextEditingController();

  @override
  void dispose() {
    messageTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Channel"),
          backgroundColor: awaBlackBlue,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              OverlappingPanels.of(context)?.reveal(RevealSide.left);
            },
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          children: [
            Expanded(
                child: GroupedListView<CommunityMessageModel, DateTime>(
              reverse: true,
              order: GroupedListOrder.DESC,
              useStickyGroupSeparators: true,
              floatingHeader: true,
              padding: const EdgeInsets.all(8),
              elements: messages,
              groupBy: (message) => DateTime(
                message.date.year,
                message.date.month,
                message.date.day,
              ),
              groupHeaderBuilder: (CommunityMessageModel message) => SizedBox(
                height: 40,
                child: Center(
                  child: Card(
                    color: awaSnowWhite,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        DateFormat.yMMMd().format(message.date),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              itemBuilder: (context, CommunityMessageModel message) => Align(
                alignment: message.isSentByMe
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Card(
                  color: Colors.grey.shade300,
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.sender,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          message.text,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: AwaInputField(
                hintText: "Type your message here",
                onSuffixIconPress: () {
                  sendMessage();
                  setState(() {
                    messageTextFieldController.text = "";
                  });
                },
                preffixIconData: Icons.add,
                suffixIconData: Icons.send_rounded,
                textEditingController: messageTextFieldController,
                textInputType: TextInputType.text,
                validator: (p0) {
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  void sendMessage() {
    final userMessage = CommunityMessageModel(
      sender: "Me",
      text: messageTextFieldController.text,
      date: DateTime.now(),
      isSentByMe: true,
    );
    messages.add(userMessage);
  }
}
