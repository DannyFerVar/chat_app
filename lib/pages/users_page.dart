import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/users_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat_app/services/auth_service.dart';
import '../services/socket_service.dart';

import 'package:chat_app/models/user.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final userService = UsersService();

  List<User> usersList = [];

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    _chargeUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    final user = authService.user;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app),
          color: Colors.black87,
          onPressed: () {
            socketService.disconnect();
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();
          },
        ),
        title: Text(
          user!.name,
          style: const TextStyle(color: Colors.black87),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: (socketService.serverStatus == ServerStatus.Online)
                ? const Icon(Icons.check_circle, color: Colors.blue)
                : const Icon(Icons.offline_bolt, color: Colors.red),
          ),
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        header: const WaterDropHeader(
          complete: Icon(
            Icons.check,
            color: Colors.lightBlue,
          ),
          waterDropColor: Colors.lightBlue,
        ),
        onRefresh: _chargeUsers,
        child: _userList(),
      ),
    );
  }

  ListView _userList() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, i) => GestureDetector(
          child: _userTile(usersList[i]),
          onTap: () => Navigator.popAndPushNamed(context, 'chat')),
      separatorBuilder: (_, i) => const Divider(),
      itemCount: usersList.length,
    );
  }

  ListTile _userTile(User user) {
    return ListTile(
      title: Text(user.name),
      leading: CircleAvatar(
        backgroundColor: Colors.blue.shade100,
        child: Text(
          user.name.substring(0, 1),
          style: const TextStyle(color: Colors.black87),
        ),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: user.online ? Colors.green : Colors.red),
      ),
      subtitle: Text(user.email),
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.userTo = user;
        Navigator.pushNamed(context, 'chat');
      },
    );
  }

  _chargeUsers() async {
    usersList = await userService.getUsers();
    setState(() {});

    // await Future.delayed(const Duration(milliseconds: 1000));
    // if failed, use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
