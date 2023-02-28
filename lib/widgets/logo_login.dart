import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String pageTitle;
  const Logo({
    super.key,
    required this.screenSize,
    required this.pageTitle,
  });

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenSize.width * 0.5,
      alignment: Alignment.bottomCenter,
      child: Column(
        children: [
          const Image(
            image: AssetImage('assets/tag-logo.png'),
          ),
          const SizedBox(height: 15),
          Text(
            pageTitle,
            style: const TextStyle(
              fontSize: 25,
              letterSpacing: 0.3,
            ),
          )
        ],
      ),
    );
  }
}
