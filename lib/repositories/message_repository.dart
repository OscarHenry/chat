import 'dart:convert';
import 'dart:developer';

import 'package:chat/global/environments.dart';
import 'package:chat/models/message.dart';
import 'package:chat/models/session.dart';
import 'package:http/http.dart';

class MessageRepository {
  final Client client = Client();

  Future<(List<Message>?, Exception?)> fetchMessages({
    required String userId,
    int skip = 0,
    int pageSize = 15,
  }) async {
    assert(userId.isNotEmpty, 'userId is required');
    try {
      final session = await Session.fromStorage();
      var uri = Uri.parse('${Environments.apiUrl}/messages/$userId');
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
        name: 'fetchMessages',
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> apiResponse = jsonDecode(response.body);
        final messagesResponse = apiResponse['messages'] as List<dynamic>;
        final messages =
            messagesResponse.map((e) => Message.fromJson(e)).toList();
        return (messages, null);
      } else {
        throw Exception('fetch message failed');
      }
    } catch (e, s) {
      log('', name: 'MessageRepository', error: e, stackTrace: s);
      return (null, Exception('fetch message failed'));
    }
  }
}
