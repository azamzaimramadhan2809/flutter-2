import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _oldPassController = TextEditingController();
  final _newPassController = TextEditingController();
  final _confirmPassController = TextEditingController();

  String oldPassword = 'admin';

  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildOldPasswordFiled(),
                SizedBox(height: 20),
                _buildNewPasswordFiled(),
                SizedBox(height: 20),
                _buildConfirmPasswordFiled(),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Change Password'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /* ==========================
  ======= PASSWORD OLD ==========
  =============================*/

  Widget _buildOldPasswordFiled() {
    return TextFormField(
      controller: _oldPassController,
      decoration: InputDecoration(
        labelText: 'Password Lama',
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.deepPurple,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureOld
                ? Icons.visibility_off
                : Icons.visibility,
            color: Colors.deepPurple,
          ),
          onPressed: () {
            setState(() {
              _obscureOld = !_obscureOld;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.deepPurple,
            width: 2,
          ),
        ),
      ),
      obscureText: _obscureOld,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password tidak boleh kosong';
        }

        if (value != oldPassword) {
          return 'Password Lama Salah';
        }

        return null;
      },
    );
  }

  /* ==========================
  ======= PASSWORD NEW ==========
  =============================*/

  Widget _buildNewPasswordFiled() {
    return TextFormField(
      controller: _newPassController,
      decoration: InputDecoration(
        labelText: 'Password Baru',
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.deepPurple,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureNew
                ? Icons.visibility_off
                : Icons.visibility,
            color: Colors.deepPurple,
          ),
          onPressed: () {
            setState(() {
              _obscureNew = !_obscureNew;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.deepPurple,
            width: 2,
          ),
        ),
      ),
      obscureText: _obscureNew,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password tidak boleh kosong';
        }

        if (value.length < 6) {
          return 'Password minimal 6 karakter';
        }

        return null;
      },
    );
  }

  /* ==========================
  ======= PASSWORD CONFIRM ======
  =============================*/

  Widget _buildConfirmPasswordFiled() {
    return TextFormField(
      controller: _confirmPassController,
      decoration: InputDecoration(
        labelText: 'Confirm Password Baru',
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.deepPurple,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureConfirm
                ? Icons.visibility_off
                : Icons.visibility,
            color: Colors.deepPurple,
          ),
          onPressed: () {
            setState(() {
              _obscureConfirm = !_obscureConfirm;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.deepPurple,
            width: 2,
          ),
        ),
      ),
      obscureText: _obscureConfirm,
      validator: (value) {
        if (_confirmPassController.text !=
            _newPassController.text) {
          return 'Password Baru dan Confirm Password tidak cocok';
        }

        oldPassword = _newPassController.text;
        return null;
      },
    );
  }
}