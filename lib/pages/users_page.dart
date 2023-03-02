import 'package:chat_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final userList = [
    User(online: true, email: 'test1@test.com', name: 'Vanessa', uid: '1'),
    User(online: false, email: 'test2@test.com', name: 'Miguel', uid: '2'),
    User(online: true, email: 'test3@test.com', name: 'Daniela', uid: '3'),
    User(online: false, email: 'test4@test.com', name: 'Sabbath', uid: '4'),
  ];

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app),
          color: Colors.black87,
          onPressed: () {},
        ),
        title: const Text(
          'User Name',
          style: TextStyle(color: Colors.black87),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: const Icon(Icons.check_circle, color: Colors.green),
            //child: const Icon(Icons.offline_bolt, color: Colors.red),
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
          child: _userTile(userList[i]),
          onTap: () => Navigator.popAndPushNamed(context, 'chat')),
      separatorBuilder: (_, i) => const Divider(),
      itemCount: userList.length,
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
    );
  }

  _chargeUsers() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
