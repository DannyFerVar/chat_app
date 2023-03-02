import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String message;
  final String uid;
  final AnimationController animationController;

  const ChatMessage({
    super.key,
    required this.message,
    required this.uid,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animationController, curve: Curves.easeIn),
        child: Container(
          child: uid == '123' ? _myMessage() : _notMyMessage(),
        ),
      ),
    );
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(
          right: 5,
          bottom: 5,
          left: 50,
        ),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xff4D9EF6),
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 5),
              blurRadius: 1,
            ),
          ],
        ),
        child: Text(message),
      ),
    );
  }

  Widget _notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(
          left: 5,
          bottom: 5,
          right: 50,
        ),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xffE4E5E8),
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 5),
              blurRadius: 1,
            ),
          ],
        ),
        child: Text(message),
      ),
    );
  }
}
