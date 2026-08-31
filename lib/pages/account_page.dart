import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F8FA),

      appBar: AppBar(
        title: Text(
          'Account Page',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontWeight: FontWeight.w600,
          ),
        ),

        backgroundColor: Colors.white,
        elevation: 0.5,

        iconTheme: IconThemeData(
          color: Color(0xFF1E3A5F),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
          ),

          child: Column(
            children: [
              SizedBox(height: 20),

              _buildProfileSection(),

              SizedBox(height: 30),

              _buildSettingsSection(context),
            ],
          ),
        ),
      ),
    );
  }

  /* ==========================
  ===== PROFILE SECTION =========
  =============================*/

  Widget _buildProfileSection() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF1E3A5F),
            Color(0xFF4F6D8A),
          ],

          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),

      padding: EdgeInsets.symmetric(
        vertical: 40,
        horizontal: 16,
      ),

      child: Row(
        children: [
          ClipOval(
            child: Image.asset(
              'assets/images/A.png',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(width: 20),

          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Text(
                "Azam Za'im Ramadhan",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 5),

              Text(
                'azamzaimramadhan.17@gmail.com',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ],
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

      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),

        side: BorderSide(
          color: Color(0xFFE5E7EB),
        ),
      ),

      child: ListTile(
        leading: Icon(
          icon,
          color: Color(0xFF1E3A5F),
          size: 28,
        ),

        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1F2937),
          ),
        ),

        trailing: Icon(
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

  Widget _buildSettingsSection(
    BuildContext context,
  ) {
    return Column(
      children: [
        _buildSettingItem(
          context,
          icon: Icons.person_outline,
          title: 'Profile',
          onTap: () {
            Navigator.pushNamed(
              context,
              'AccountPage',
            );
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
          icon: Icons.notifications_outlined,
          title: 'Notifications',
          onTap: () {
            Navigator.pushNamed(
              context,
              'Notifications',
            );
          },
        ),

        _buildSettingItem(
          context,
          icon: Icons.help_outline,
          title: 'Help & Support',
          onTap: () {
            Navigator.pushNamed(
              context,
              'Help',
            );
          },
        ),

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

  void _showLogoutDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          title: Text(
            'Logout',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          content: Text(
            'Are you sure you want to logout?',
          ),

          actions: [
            TextButton(
              onPressed:
                  Navigator.of(context).pop,

              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();

                Navigator.pushNamed(
                  context,
                  'LoginPage',
                );
              },

              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color(0xFF1E3A5F),

                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10),
                ),
              ),

              child: Text(
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