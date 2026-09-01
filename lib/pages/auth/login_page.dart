// lib/pages/auth/login_page.dart

import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() =>
      _LoginPageState();
}

class _LoginPageState
    extends State<LoginPage> {

  final _formKey =
      GlobalKey<FormState>();

  final _emailController =
      TextEditingController();

  final _passwordController =
      TextEditingController();

  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  // ============================================================
  // EMAIL VALIDATION
  // ============================================================

  String? _validateEmail(
    String? value,
  ) {
    if (value == null ||
        value.trim().isEmpty) {
      return 'Please enter your email';
    }

    final email = value.trim();

    // Wajib Gmail
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@gmail\.com$',
    );

    if (!emailRegex.hasMatch(email)) {
      return 'Please use a valid Gmail address';
    }

    return null;
  }

  // ============================================================
  // PASSWORD VALIDATION
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
  // LOGIN
  // ============================================================

  void _handleLogin() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final email =
        _emailController.text.trim();

    final password =
        _passwordController.text;

    final success =
        AuthService.login(
      email,
      password,
    );

    if (!success) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Account not registered or password is incorrect.',
          ),
        ),
      );

      return;
    }

    // Login berhasil
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const HomePage(),
      ),
    );
  }

  // ============================================================
  // REGISTER
  // ============================================================

  void _goToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const RegisterPage(),
      ),
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

                const SizedBox(
                  height: 24,
                ),

                // BRAND
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,

                      decoration:
                          BoxDecoration(
                        color:
                            const Color(
                          0xFF1E3A5F,
                        ),

                        borderRadius:
                            BorderRadius.circular(
                          12,
                        ),
                      ),

                      child:
                          const Icon(
                        Icons
                            .shopping_bag_outlined,

                        color:
                            Colors.white,
                      ),
                    ),

                    const SizedBox(
                      width: 12,
                    ),

                    const Text(
                      'GameShop',

                      style: TextStyle(
                        fontSize: 24,
                        fontWeight:
                            FontWeight.bold,
                        color:
                            Color(
                          0xFF1E3A5F,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 32,
                ),

                const Text(
                  'Welcome Back 👋',

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
                  'Sign in to continue shopping',

                  style: TextStyle(
                    fontSize: 15,
                    color:
                        Color(0xFF6B7280),
                  ),
                ),

                const SizedBox(
                  height: 32,
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
                    labelText: 'Email',

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
                  height: 32,
                ),

                // LOGIN BUTTON
                SizedBox(
                  width:
                      double.infinity,

                  height: 52,

                  child:
                      ElevatedButton(
                    onPressed:
                        _handleLogin,

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
                      'LOGIN',

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
                        "Don't have an account?",

                        style: TextStyle(
                          color:
                              Color(
                            0xFF6B7280,
                          ),
                        ),
                      ),

                      TextButton(
                        onPressed:
                            _goToRegister,

                        child:
                            const Text(
                          'Sign Up',

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