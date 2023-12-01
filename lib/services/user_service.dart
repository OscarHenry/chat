import 'package:chat/models/user.dart';
import 'package:chat/repositories/user_repository.dart';
import 'package:flutter/widgets.dart';

class UserService with ChangeNotifier {
  final UserRepository _userRepo = UserRepository();
  List<User> users = [];

  Future<void> fetchUsers() async {
    final (usersList, exception) = await _userRepo.fetchUsers();

    if (exception != null) return;

    users = usersList!;
    notifyListeners();
  }
}
