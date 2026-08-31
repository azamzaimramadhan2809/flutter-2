import 'dart:typed_data';

import '../models/user_model.dart';

class AuthService {
  // Menyimpan semua akun yang sudah register, key = email (lowercase)
  static final Map<String, AppUser> _users = {};

  // Email user yang sedang login, null kalau belum login
  static String? _currentUserEmail;

  // ============================================================
  // REGISTER
  // ============================================================

  static bool register(
    String username,
    String email,
    String password,
  ) {
    final normalizedEmail = email.trim().toLowerCase();

    if (_users.containsKey(normalizedEmail)) {
      return false;
    }

    _users[normalizedEmail] = AppUser(
      username: username.trim(),
      email: normalizedEmail,
      password: password,
    );

    return true;
  }

  // ============================================================
  // LOGIN
  // ============================================================

  static bool login(String email, String password) {
    final normalizedEmail = email.trim().toLowerCase();
    final user = _users[normalizedEmail];

    if (user == null || user.password != password) {
      return false;
    }

    _currentUserEmail = normalizedEmail;
    return true;
  }

  // ============================================================
  // LOGOUT
  // ============================================================

  static void logout() {
    _currentUserEmail = null;
  }

  // ============================================================
  // CURRENT USER
  // ============================================================

  static AppUser? get currentUser {
    if (_currentUserEmail == null) return null;
    return _users[_currentUserEmail];
  }

  // ============================================================
  // CEK EMAIL SUDAH TERDAFTAR
  // ============================================================

  static bool isRegistered(String email) {
    return _users.containsKey(email.trim().toLowerCase());
  }

  // ============================================================
  // UPDATE PASSWORD
  // ============================================================

  static bool updatePassword(String oldPassword, String newPassword) {
    final user = currentUser;

    if (user == null || user.password != oldPassword) {
      return false;
    }

    user.password = newPassword;
    return true;
  }

  // ============================================================
  // UPDATE PROFILE (username / email / foto)
  // ============================================================

  static bool updateProfile({
    String? username,
    String? newEmail,
    Uint8List? photoBytes,
  }) {
    final user = currentUser;

    if (user == null) return false;

    if (newEmail != null && newEmail.trim().isNotEmpty) {
      final normalizedEmail = newEmail.trim().toLowerCase();

      // Email baru sudah dipakai akun lain
      if (normalizedEmail != user.email &&
          _users.containsKey(normalizedEmail)) {
        return false;
      }

      if (normalizedEmail != user.email) {
        _users.remove(user.email);
        user.email = normalizedEmail;
        _users[normalizedEmail] = user;
        _currentUserEmail = normalizedEmail;
      }
    }

    if (username != null && username.trim().isNotEmpty) {
      user.username = username.trim();
    }

    if (photoBytes != null) {
      user.photoBytes = photoBytes;
    }

    return true;
  }
}