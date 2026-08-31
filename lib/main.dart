import 'package:flutter/material.dart';

import 'pages/auth/login_page.dart';
import 'pages/auth/register_page.dart';
import 'pages/account_page.dart';
import 'pages/change_password_page.dart';
import 'pages/cart_page.dart';
import 'pages/home_page.dart';
import 'pages/list_chat.dart';
import 'pages/edit_profile_page.dart';
import 'pages/checkout_history_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // LOGIN JADI HALAMAN PERTAMA
      initialRoute: 'LoginPage',

      routes: {
        'LoginPage': (context) => const LoginPage(),

        'RegisterPage': (context) => const RegisterPage(),

        'HomePage': (context) => const HomePage(),

        'CartPage': (context) => const CartPage(),

        'AccountPage': (context) => const AccountPage(),

        'ChangePasswordPage': (context) =>
            const ChangePasswordPage(),

        'ListChatPage': (context) =>
            const ListChatPage(),

        'EditProfilePage': (context) =>
            const EditProfilePage(),

        'CheckoutHistoryPage': (context) =>
            const CheckoutHistoryPage(),
      },
    );
  }
}