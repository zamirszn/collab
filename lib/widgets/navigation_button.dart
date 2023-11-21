import 'package:awa/utils/colors.dart';
import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  const NavigationButton(
      {super.key, required this.iconData, required this.onPressed});
  final IconData iconData;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: CircleAvatar(
        backgroundColor: awaLightBlue,
        radius: 23,
        child: IconButton(
            onPressed: onPressed,
            icon: Icon(
              iconData,
              size: 24,
              color: Colors.white,
            )),
      ),
    );
  }
}
