// lib/pages/auth/register_page.dart

import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
  });

  @override
  State<RegisterPage> createState() =>
      _RegisterPageState();
}

class _RegisterPageState
    extends State<RegisterPage> {

  final _formKey =
      GlobalKey<FormState>();

  final _nameController =
      TextEditingController();

  final _emailController =
      TextEditingController();

  final _passwordController =
      TextEditingController();

  final _confirmPasswordController =
      TextEditingController();

  bool _isPasswordVisible = false;

  bool _isConfirmPasswordVisible =
      false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  // ============================================================
  // NAME
  // ============================================================

  String? _validateName(
    String? value,
  ) {
    if (value == null ||
        value.trim().isEmpty) {
      return 'Please enter your full name';
    }

    return null;
  }

  // ============================================================
  // EMAIL
  // ============================================================

  String? _validateEmail(
    String? value,
  ) {
    if (value == null ||
        value.trim().isEmpty) {
      return 'Please enter your email';
    }

    final email =
        value.trim();

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@gmail\.com$',
    );

    if (!emailRegex.hasMatch(email)) {
      return 'Email must use @gmail.com';
    }

    return null;
  }

  // ============================================================
  // PASSWORD
  // ============================================================

  String? _validatePassword(
    String? value,
  ) {
    if (value == null ||
        value.isEmpty) {
      return 'Please enter your password';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  // ============================================================
  // CONFIRM PASSWORD
  // ============================================================

  String? _validateConfirmPassword(
    String? value,
  ) {
    if (value == null ||
        value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value !=
        _passwordController.text) {
      return 'Passwords do not match';
    }

    return null;
  }

  // ============================================================
  // REGISTER
  // ============================================================

  void _handleRegister() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final email =
        _emailController.text.trim();

    final password =
        _passwordController.text;

    final success =
        AuthService.register(
      email,
      password,
    );

    if (!success) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'This email is already registered.',
          ),
        ),
      );

      return;
    }

    // Berhasil register
    showDialog(
      context: context,

      builder: (dialogContext) {
        return AlertDialog(
          title:
              const Text(
            'Registration Successful',
          ),

          content:
              const Text(
            'Your account has been created. Please login to continue.',
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                );

                Navigator.pushReplacement(
                  context,

                  MaterialPageRoute(
                    builder: (_) =>
                        const LoginPage(),
                  ),
                );
              },

              child:
                  const Text(
                'LOGIN',
              ),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF7F8FA),

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 32,
          ),

          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                // BACK
                IconButton(
                  onPressed: () =>
                      Navigator.pop(
                    context,
                  ),

                  icon:
                      const Icon(
                    Icons.arrow_back,
                  ),

                  padding:
                      EdgeInsets.zero,
                ),

                const SizedBox(
                  height: 15,
                ),

                const Text(
                  'Create Account',

                  style: TextStyle(
                    fontSize: 30,
                    fontWeight:
                        FontWeight.bold,
                    color:
                        Color(0xFF1F2937),
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                const Text(
                  'Start your shopping journey',

                  style: TextStyle(
                    fontSize: 15,
                    color:
                        Color(0xFF6B7280),
                  ),
                ),

                const SizedBox(
                  height: 32,
                ),

                // NAME
                TextFormField(
                  controller:
                      _nameController,

                  validator:
                      _validateName,

                  decoration:
                      InputDecoration(
                    labelText:
                        'Full Name',

                    prefixIcon:
                        const Icon(
                      Icons.person_outline,
                    ),

                    filled: true,

                    fillColor:
                        Colors.white,

                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(
                        12,
                      ),

                      borderSide:
                          BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                // EMAIL
                TextFormField(
                  controller:
                      _emailController,

                  keyboardType:
                      TextInputType
                          .emailAddress,

                  validator:
                      _validateEmail,

                  decoration:
                      InputDecoration(
                    labelText:
                        'Gmail',

                    hintText:
                        'example@gmail.com',

                    prefixIcon:
                        const Icon(
                      Icons.email_outlined,
                    ),

                    filled: true,

                    fillColor:
                        Colors.white,

                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(
                        12,
                      ),

                      borderSide:
                          BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                // PASSWORD
                TextFormField(
                  controller:
                      _passwordController,

                  obscureText:
                      !_isPasswordVisible,

                  validator:
                      _validatePassword,

                  decoration:
                      InputDecoration(
                    labelText:
                        'Password',

                    helperText:
                        'Minimum 6 characters',

                    prefixIcon:
                        const Icon(
                      Icons.lock_outline,
                    ),

                    suffixIcon:
                        IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons
                                .visibility_off
                            : Icons
                                .visibility,
                      ),

                      onPressed: () {
                        setState(() {
                          _isPasswordVisible =
                              !_isPasswordVisible;
                        });
                      },
                    ),

                    filled: true,

                    fillColor:
                        Colors.white,

                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(
                        12,
                      ),

                      borderSide:
                          BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                // CONFIRM PASSWORD
                TextFormField(
                  controller:
                      _confirmPasswordController,

                  obscureText:
                      !_isConfirmPasswordVisible,

                  validator:
                      _validateConfirmPassword,

                  decoration:
                      InputDecoration(
                    labelText:
                        'Confirm Password',

                    prefixIcon:
                        const Icon(
                      Icons.lock_reset_outlined,
                    ),

                    suffixIcon:
                        IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible
                            ? Icons
                                .visibility_off
                            : Icons
                                .visibility,
                      ),

                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                    ),

                    filled: true,

                    fillColor:
                        Colors.white,

                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(
                        12,
                      ),

                      borderSide:
                          BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 32,
                ),

                // REGISTER BUTTON
                SizedBox(
                  width:
                      double.infinity,

                  height: 52,

                  child:
                      ElevatedButton(
                    onPressed:
                        _handleRegister,

                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(
                        0xFF1E3A5F,
                      ),

                      foregroundColor:
                          Colors.white,

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          12,
                        ),
                      ),
                    ),

                    child:
                        const Text(
                      'CREATE ACCOUNT',

                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 24,
                ),

                Center(
                  child: Column(
                    children: [

                      const Text(
                        'Already have an account?',

                        style: TextStyle(
                          color:
                              Color(
                            0xFF6B7280,
                          ),
                        ),
                      ),

                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,

                            MaterialPageRoute(
                              builder: (_) =>
                                  const LoginPage(),
                            ),
                          );
                        },

                        child:
                            const Text(
                          'Login',

                          style:
                              TextStyle(
                            color:
                                Color(
                              0xFF1E3A5F,
                            ),

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}