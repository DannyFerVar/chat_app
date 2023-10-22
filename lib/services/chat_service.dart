import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/messages_response.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app/models/user.dart';

class ChatService with ChangeNotifier {
  late User userTo;

  Future<MessagesResponse> getChat(String userID) async {
    String? token = await AuthService.getToken();
    final uri = Uri.parse('${Envirnoment.apiUrl}/messages/$userID');
    final resp = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'x-token': token.toString()
    });

    final messagesResp = messagesResponseFromJson(resp.body);

    return messagesResp;
  }
}
