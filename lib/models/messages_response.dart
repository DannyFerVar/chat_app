// To parse this JSON data, do
//
//     final messagesResponse = messagesResponseFromJson(jsonString);

import 'dart:convert';

import 'package:chat_app/widgets/chat_message.dart';

MessagesResponse messagesResponseFromJson(String str) =>
    MessagesResponse.fromJson(json.decode(str));

String messagesResponseToJson(MessagesResponse data) =>
    json.encode(data.toJson());

class MessagesResponse {
  bool ok;
  List<Last30> last30;

  MessagesResponse({
    required this.ok,
    required this.last30,
  });

  factory MessagesResponse.fromJson(Map<String, dynamic> json) =>
      MessagesResponse(
        ok: json["ok"],
        last30:
            List<Last30>.from(json["last30"].map((x) => Last30.fromJson(x))),
      );

  get message => null;

  get from => null;

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "last30": List<dynamic>.from(last30.map((x) => x.toJson())),
      };

  map(ChatMessage Function(dynamic m) param0) {}
}

class Last30 {
  String from;
  String to;
  String message;
  DateTime createdAt;
  DateTime updatedAt;

  Last30({
    required this.from,
    required this.to,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Last30.fromJson(Map<String, dynamic> json) => Last30(
        from: json["from"],
        to: json["to"],
        message: json["message"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "message": message,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
