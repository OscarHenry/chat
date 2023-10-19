import 'package:chat/global/di.dart';
import 'package:chat/models/user.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/socket_service.dart';
import 'package:chat/widgets/connectivity_status_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final SocketService socketService = getIt<SocketService>();
  final List<User> users = usersList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(context.watch<AuthService>().session.user?.name ?? ''),
        leading: IconButton(
          onPressed: _logOut,
          icon: const Icon(Icons.logout),
        ),
        actions: const [ConnectivityStatusIcon()],
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
        constraints: BoxConstraints.loose(const Size.fromRadius(4)),
      ),
    );
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> _logOut() async {
    await context.read<AuthService>().logOut().then(
          (_) => Navigator.pushReplacementNamed(context, 'login'),
        );
  }
}
