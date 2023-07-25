import 'package:chat/models/user.dart';
import 'package:chat/widgets/connectivity_status_icon.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final List<User> users = usersList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('My Name'),
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.logout)),
        actions: const [
          ConnectivityStatusIcon(isActive: true),
        ],
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: _onRefresh,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemCount: users.length,
          itemBuilder: (context, index) => buildUserItem(user: users[index]),
          separatorBuilder: (context, index) => const Divider(),
        ),
      ),
    );
  }

  ListTile buildUserItem({required User user}) {
    return ListTile(
      title: Text(user.name),
      subtitle: Text(user.email),
      leading:
          CircleAvatar(child: Text(user.name.substring(0, 2).toUpperCase())),
      trailing: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: user.online ? Colors.green : Colors.blueGrey,
        ),
        constraints: BoxConstraints.loose(
          const Size.fromRadius(4),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
