import 'package:flutter/material.dart';

import 'package:chat_app/widgets/label.dart';

class LoginLabels extends StatelessWidget {
  final String route;
  final String labelText;
  final String labelTextBlue;
  const LoginLabels({super.key, required this.route, required this.labelText, required this.labelTextBlue});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Label(labelName: labelText),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, route);
            },
            child: Label(
              labelName: labelTextBlue,
              textColor: Colors.blue.shade600,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
