import 'package:awa/home/chat_screen.dart';
import 'package:flutter/material.dart';

import 'package:awa/utils/colors.dart';
import 'package:awa/utils/tasks_loader.dart';

class VolunteerScreen extends StatefulWidget {
  const VolunteerScreen({
    super.key,
  });

  @override
  State<VolunteerScreen> createState() => _VolunteerScreenState();
}

class _VolunteerScreenState extends State<VolunteerScreen> {
  final TextEditingController dmTextController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    dmTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...volunteers.map((user) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7.0),
                  child: ContactsWidget(
                    name: user["name"]!,
                    avatar: user["avatar"]!,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChatPage(),
                          ));
                    },
                    status: user["status"]!,
                    isActive: user["isActive"],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class ContactsWidget extends StatelessWidget {
  const ContactsWidget(
      {super.key,
      required this.name,
      required this.avatar,
      required this.onTap,
      required this.status,
      required this.isActive});
  final String name;
  final String avatar;
  final String status;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final Size deviceScreen = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.grey.shade200,
          width: deviceScreen.width,
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                image: AssetImage(avatar),
                height: 50,
              ),
            ),
            // CircleAvatar(
            //   radius: 25,
            //   backgroundImage: AssetImage(avatar),
            // ),

            Column(
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(status),
              ],
            ),

            isActive
                ? Container(
                    margin: const EdgeInsets.only(right: 10),
                    height: 20,
                    width: 20,
                    decoration: const ShapeDecoration(
                      color: Colors.green,
                      shape: CircleBorder(),
                    ),
                  )
                : Container(
                    height: 20,
                    margin: const EdgeInsets.only(right: 10),
                    width: 20,
                    decoration: const ShapeDecoration(
                      color: Colors.grey,
                      shape: CircleBorder(),
                    ),
                  ),
          ]),
        ),
      ),
    );
  }
}

class AwaInputField extends StatefulWidget {
  const AwaInputField({
    Key? key,
    required this.hintText,
    this.isPassword = false,
    required this.textInputType,
    required this.textEditingController,
    required this.preffixIconData,
    required this.suffixIconData,
    required this.onSuffixIconPress,
    required this.validator,
    this.maxLines,
  }) : super(key: key);
  final String hintText;
  final bool isPassword;
  final TextInputType textInputType;
  final TextEditingController textEditingController;
  final IconData preffixIconData;
  final IconData suffixIconData;
  final VoidCallback onSuffixIconPress;
  final String? Function(String?)? validator;
  final dynamic maxLines;

  @override
  State<AwaInputField> createState() => _AwaInputFieldState();
}

class _AwaInputFieldState extends State<AwaInputField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        setState(() {});
      },
      validator: widget.validator,
      controller: widget.textEditingController,
      onEditingComplete: () {},
      keyboardType: widget.textInputType,
      autofocus: false,
      maxLines: widget.maxLines,
      cursorColor: needsAppBlack,
      obscureText: widget.isPassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        fillColor: Colors.orange,
        contentPadding: const EdgeInsets.all(15.0),
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        prefixIcon: Icon(
          widget.preffixIconData,
          color: needsAppBlack,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            width: 1,
            style: BorderStyle.solid,
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            width: 1,
            style: BorderStyle.solid,
            color: Colors.red,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            width: 1,
            style: BorderStyle.solid,
            color: needsAppBlack,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
              width: 1, style: BorderStyle.solid, color: Colors.black54),
        ),
        counterStyle: TextStyle(color: needsAppBlack),
        focusColor: needsAppBlack,
        suffixIcon: IconButton(
          onPressed: () {
            widget.onSuffixIconPress();
          },
          icon: Icon(widget.suffixIconData),
          color: needsAppBlack,
        ),
      ),
      style: TextStyle(
        color: needsAppBlack,
      ),
    );
  }
}
