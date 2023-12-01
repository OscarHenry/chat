import 'dart:convert';
import 'dart:developer';

import 'package:chat/global/environments.dart';
import 'package:chat/models/session.dart';
import 'package:chat/models/user.dart';
import 'package:http/http.dart';

class UserRepository {
  final Client client = Client();

  Future<(List<User>?, Exception?)> fetchUsers({
    int skip = 0,
    int pageSize = 15,
  }) async {
    try {
      final session = await Session.fromStorage();
      final uri = Uri.parse('${Environments.apiUrl}/users');
      final response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'x-token': session.token!,
        },
      );

      log(
        'url[${response.request?.method}]: ${response.request?.url}\n'
        'headers: ${response.request?.headers}\n'
        'response: ${response.body}',
        name: 'fetchUsers',
      );

      final apiResponse = _UserResponse.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200 && apiResponse.ok) {
        return (apiResponse.users, null);
      } else {
        throw Exception('fetch users failed');
      }
    } catch (e, s) {
      log('', name: 'UserRepository', error: e, stackTrace: s);
      return (null, Exception('fetch users failed'));
    }
  }
}

class _UserResponse {
  _UserResponse({
    required this.ok,
    required this.users,
  });

  bool ok;
  List<User> users;

  factory _UserResponse.fromJson(Map<String, dynamic> json) => _UserResponse(
        ok: json["ok"],
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}
