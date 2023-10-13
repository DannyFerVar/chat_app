import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  final List<ChatMessage> _messages = [];
  bool isWritting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Navigator.popAndPushNamed(context, 'users'),
          child: Icon(
            Platform.isAndroid ? Icons.arrow_left : Icons.arrow_back_ios,
            color: Colors.blue.shade200,
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              Icons.menu,
              color: Colors.blue.shade200,
            ),
          ),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 17,
              backgroundColor: Colors.blue.shade100,
              child: const Text(
                'U',
                style: TextStyle(color: Colors.black87),
              ),
            ),
            const SizedBox(
              width: 7,
            ),
            const Text(
              'User Name',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 23,
              ),
            )
          ],
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              reverse: true,
              physics: const BouncingScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder: (_, i) => _messages[i],
            ),
          ),
          const Divider(height: 1),
          _inputChat(),
        ],
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.only(left: 8),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 5),
              blurRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleText,
                onChanged: (text) {
                  setState(() {
                    text.isNotEmpty ? isWritting = true : null;
                  });
                },
                decoration: const InputDecoration.collapsed(
                  hintText: 'Send text',
                ),
                focusNode: _focusNode,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 4),
              child: Platform.isIOS
                  ? CupertinoButton(
                      onPressed: isWritting
                          ? () => _handleText(_textController.text.trim())
                          : null,
                      child: const Text('Send'),
                    )
                  : IconTheme(
                      data: IconThemeData(color: Colors.blue.shade300),
                      child: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: isWritting
                            ? () => _handleText(_textController.text.trim())
                            : null,
                        icon: const Icon(Icons.send),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  _handleText(String text) {
    if (text.isEmpty) return;
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      message: text,
      uid: '123',
      animationController: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      isWritting = false;
    });
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
