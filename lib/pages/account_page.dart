import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';
import 'edit_profile_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final AppUser? user = AuthService.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      appBar: AppBar(
        title: const Text(
          'Account',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontWeight: FontWeight.w600,
          ),
        ),

        backgroundColor: Colors.white,
        elevation: 0.5,

        iconTheme: const IconThemeData(
          color: Color(0xFF1E3A5F),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),

          child: Column(
            children: [
              const SizedBox(height: 20),

              _buildProfileSection(context, user),

              const SizedBox(height: 30),

              _buildSettingsSection(context),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /* ==========================
  ===== PROFILE SECTION =========
  =============================*/

  Widget _buildProfileSection(BuildContext context, AppUser? user) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1E3A5F),
            Color(0xFF4F6D8A),
          ],

          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        borderRadius: BorderRadius.circular(15),
      ),

      padding: const EdgeInsets.symmetric(
        vertical: 30,
        horizontal: 16,
      ),

      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 45,
                backgroundColor: Colors.white24,

                backgroundImage: user?.photoBytes != null
                    ? MemoryImage(user!.photoBytes!)
                    : null,

                child: user?.photoBytes == null
                    ? const Icon(
                        Icons.person,
                        size: 45,
                        color: Colors.white,
                      )
                    : null,
              ),

              const SizedBox(width: 20),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      user?.username ?? 'Guest',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      user?.email ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EditProfilePage(),
                  ),
                );

                setState(() {});
              },

              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white70),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              child: const Text(
                'Edit Profile',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /* ==========================
  ======= SETTING ITEMS =========
  =============================*/

  Widget _buildSettingItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 1,

      color: Colors.white,

      margin: const EdgeInsets.only(
        bottom: 10,
      ),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),

        side: const BorderSide(
          color: Color(0xFFE5E7EB),
        ),
      ),

      child: ListTile(
        leading: Icon(
          icon,
          color: const Color(0xFF1E3A5F),
          size: 26,
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1F2937),
          ),
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Color(0xFF9CA3AF),
          size: 16,
        ),

        onTap: onTap,
      ),
    );
  }

  /* ==========================
  ======= SETTING SECTION =======
  =============================*/

  Widget _buildSettingsSection(BuildContext context) {
    return Column(
      children: [
        _buildSettingItem(
          context,
          icon: Icons.person_outline,
          title: 'Personal Information',
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const EditProfilePage(),
              ),
            );

            setState(() {});
          },
        ),

        _buildSettingItem(
          context,
          icon: Icons.lock_outline,
          title: 'Change Password',
          onTap: () {
            Navigator.pushNamed(
              context,
              'ChangePasswordPage',
            );
          },
        ),

        _buildSettingItem(
          context,
          icon: Icons.receipt_long_outlined,
          title: 'Checkout History',
          onTap: () {
            Navigator.pushNamed(
              context,
              'CheckoutHistoryPage',
            );
          },
        ),

        const SizedBox(height: 10),

        _buildSettingItem(
          context,
          icon: Icons.logout,
          title: 'Logout',
          onTap: () {
            _showLogoutDialog(context);
          },
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,

      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          title: const Text(
            'Logout',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          content: const Text(
            'Are you sure you want to logout?',
          ),

          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.of(dialogContext).pop(),

              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();

                // Hapus session login
                AuthService.logout();

                // Kembali ke LoginPage dan hapus semua history
                // navigasi sebelumnya, supaya tombol back
                // tidak bisa masuk ke Home tanpa login lagi
                Navigator.of(context).pushNamedAndRemoveUntil(
                  'LoginPage',
                  (route) => false,
                );
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E3A5F),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              child: const Text(
                'Logout',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}