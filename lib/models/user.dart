class User {
  bool online;
  String name;
  String email;
  String uuid;
  User({
    required this.uuid,
    required this.name,
    required this.email,
    this.online = false,
  });
}

final usersList = [
  User(uuid: '1', name: 'Oscar', email: 'oscarhenry@gmail.com', online: true),
  User(uuid: '2', name: 'Arianna', email: 'arianna@gmail.com', online: true),
  User(uuid: '3', name: 'Pedro', email: 'pedro@gmail.com'),
  User(uuid: '4', name: 'Juan', email: 'juan@gmail.com', online: true),
];

final oscarUser =
    User(uuid: '1', name: 'Oscar', email: 'oscarhenry@gmail.com', online: true);
final ariannaUser =
    User(uuid: '2', name: 'Arianna', email: 'arianna@gmail.com', online: true);
