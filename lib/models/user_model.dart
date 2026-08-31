import 'dart:typed_data';

class AppUser {
  String username;
  String email;
  String password;
  Uint8List? photoBytes;

  AppUser({
    required this.username,
    required this.email,
    required this.password,
    this.photoBytes,
  });
}