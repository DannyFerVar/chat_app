import 'package:chat_app/models/users_response.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/models/user.dart';

import 'package:chat_app/global/environment.dart';

class UsersService {
  Future<List<User>> getUsers() async {
    String? token = await AuthService.getToken();
    try {
      final uri = Uri.parse('${Envirnoment.apiUrl}/users');
      final resp = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'x-token': token.toString()
      });

      final usersResponse = usersResponseFromJson(resp.body);

      return usersResponse.users;
    } catch (e) {
      return [];
    }
  }
}
