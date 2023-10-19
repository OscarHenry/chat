import 'dart:developer';

import 'package:chat/models/api_response.dart';
import 'package:chat/global/environments.dart';
import 'package:chat/global/storage_mixin.dart';
import 'package:chat/models/session.dart';
import 'package:chat/models/user.dart';
import 'dart:convert';
import 'package:http/http.dart';

class AuthenticationRepository with StorageMixin {
  final Client client = Client();

  Future<(User?, String? token, Exception?)> login({
    required String email,
    required String password,
  }) async {
    try {
      final body = {'email': email, 'password': password};
      final uri = Uri.parse('${Environments.apiUrl}/login/');
      final response = await client.post(
        uri,
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );

      log(
        'url[${response.request?.method}]: ${response.request?.url}\n'
        'headers: ${response.request?.headers}\n'
        'body: $body\n'
        'response: ${response.body}',
        name: 'Login',
      );

      final apiResponse = ApiResponse.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200 && apiResponse.ok) {
        return (
          User.fromJson(apiResponse.msg['user']),
          apiResponse.msg['token'] as String,
          null,
        );
      } else {
        throw Exception(apiResponse.msg ?? 'Login failed');
      }
    } catch (e, s) {
      log('', name: 'AuthenticationRepository', error: e, stackTrace: s);
      return (null, null, Exception('Login failed'));
    }
  }

  Future<(User?, String? token, Exception?)> signIn({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final body = {'name': name, 'email': email, 'password': password};
      final uri = Uri.parse('${Environments.apiUrl}/login/new');
      final response = await client.post(
        uri,
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );

      log(
        'url[${response.request?.method}]: ${response.request?.url}\n'
        'headers: ${response.request?.headers}\n'
        'body: $body\n'
        'response: ${response.body}',
        name: 'Register',
      );

      final apiResponse = ApiResponse.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200 && apiResponse.ok) {
        return (
          User.fromJson(apiResponse.msg['user']),
          apiResponse.msg['token'] as String,
          null,
        );
      } else {
        throw Exception(apiResponse.msg ?? 'Register failed');
      }
    } catch (e, s) {
      log('', name: 'AuthenticationRepository', error: e, stackTrace: s);
      return (null, null, Exception('Register failed'));
    }
  }

  Future<(User?, String? token, Exception?)> renewToken() async {
    try {
      final session = await Session.fromStorage();
      final uri = Uri.parse('${Environments.apiUrl}/login/renew');
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
        name: 'Renew token',
      );

      final apiResponse = ApiResponse.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200 && apiResponse.ok) {
        return (
          User.fromJson(apiResponse.msg['user']),
          apiResponse.msg['token'] as String,
          null,
        );
      } else {
        throw Exception(apiResponse.msg ?? 'Renew token failed');
      }
    } catch (e, s) {
      log('', name: 'AuthenticationRepository', error: e, stackTrace: s);
      return (null, null, Exception('Renew token failed'));
    }
  }
}
