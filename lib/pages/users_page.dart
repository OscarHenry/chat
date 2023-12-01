import 'package:chat/models/user.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/user_service.dart';
import 'package:chat/widgets/connectivity_status_icon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserService()..fetchUsers(),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: Text(context.read<AuthService>().currentUser?.name ?? ''),
          leading: IconButton(
            onPressed: () => _logOut(context),
            icon: const Icon(Icons.logout),
          ),
          actions: const [ConnectivityStatusIcon()],
        ),
        body: Consumer<UserService>(
          builder: (context, state, child) => RefreshIndicator.adaptive(
            onRefresh: () => _onRefresh(context),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: state.users.length,
              itemBuilder: (context, index) =>
                  buildUserItem(context: context, user: state.users[index]),
              separatorBuilder: (context, index) => const Divider(),
            ),
          ),
        ),
      ),
    );
  }

  ListTile buildUserItem({
    required BuildContext context,
    required User user,
  }) {
    return ListTile(
      onTap: () => GoRouter.of(context).push('/chat', extra: user),
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

  Future<void> _onRefresh(BuildContext context) async =>
      context.read<UserService>().fetchUsers();

  Future<void> _logOut(BuildContext context) async {
    await context.read<AuthService>().logOut().then(
          (_) => context.go('/'),
        );
  }
}
