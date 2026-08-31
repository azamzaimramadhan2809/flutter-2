class AuthService {
  // Menyimpan akun yang sudah melakukan register
  static final Map<String, String> _users = {};

  // REGISTER
  static bool register(
    String email,
    String password,
  ) {
    email = email.trim().toLowerCase();

    // Kalau email sudah terdaftar
    if (_users.containsKey(email)) {
      return false;
    }

    _users[email] = password;

    return true;
  }

  // LOGIN
  static bool login(
    String email,
    String password,
  ) {
    email = email.trim().toLowerCase();

    // Cek apakah email ada dan password sesuai
    return _users[email] == password;
  }

  // CEK EMAIL SUDAH TERDAFTAR
  static bool isRegistered(String email) {
    email = email.trim().toLowerCase();

    return _users.containsKey(email);
  }
}