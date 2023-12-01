class User {
  bool online;
  String name;
  String email;
  String uid;
  User({
    required this.uid,
    required this.name,
    required this.email,
    this.online = false,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        uid: json['uid'] ?? '',
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        online: json['online'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'email': email,
        'online': online,
      };

  String get initials => name.substring(0, 2).toUpperCase();
}
//
// final usersList = [
//   User(uid: '1', name: 'Oscar', email: 'oscarhenry@gmail.com', online: true),
//   User(uid: '2', name: 'Arianna', email: 'arianna@gmail.com', online: true),
//   User(uid: '3', name: 'Pedro', email: 'pedro@gmail.com'),
//   User(uid: '4', name: 'Juan', email: 'juan@gmail.com', online: true),
// ];
//
// final oscarUser =
//     User(uid: '1', name: 'Oscar', email: 'oscarhenry@gmail.com', online: true);
// final ariannaUser =
//     User(uid: '2', name: 'Arianna', email: 'arianna@gmail.com', online: true);
