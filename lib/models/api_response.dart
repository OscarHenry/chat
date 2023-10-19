/// ok : true
/// msg : {"user":{"name":"Oscar","email":"oscar@gmail.com","online":false,"uid":"650131e2b017894ee5d4368f"},"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI2NTAxMzFlMmIwMTc4OTRlZTVkNDM2OGYiLCJpYXQiOjE2OTU2OTgwMjcsImV4cCI6MTY5NTc4NDQyN30.avkLx9oZg2f_FVYSnUp2LB8zwzLzQYLW_NJSjXeXZb4"}

class ApiResponse {
  final bool ok;
  final dynamic msg;

  const ApiResponse({
    required this.ok,
    required this.msg,
  });

  factory ApiResponse.fromJson(dynamic json) => ApiResponse(
        ok: json['ok'],
        msg: json['msg'],
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ok'] = ok;
    map['msg'] = msg;
    return map;
  }
}
