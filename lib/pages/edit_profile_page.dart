import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/auth_service.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;

  Uint8List? _pickedPhotoBytes;

  @override
  void initState() {
    super.initState();

    final user = AuthService.currentUser;

    _usernameController = TextEditingController(text: user?.username ?? '');
    _emailController = TextEditingController(text: user?.email ?? '');
    _pickedPhotoBytes = user?.photoBytes;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  // ============================================================
  // VALIDATION
  // ============================================================

  String? _validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your name';
    }

    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    }

    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Email must use @gmail.com';
    }

    return null;
  }

  // ============================================================
  // PICK PHOTO
  // ============================================================

  Future<void> _pickPhoto() async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );

    if (pickedFile == null) return;

    final bytes = await pickedFile.readAsBytes();

    setState(() {
      _pickedPhotoBytes = bytes;
    });
  }

  // ============================================================
  // SAVE
  // ============================================================

  void _handleSave() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final success = AuthService.updateProfile(
      username: _usernameController.text,
      newEmail: _emailController.text,
      photoBytes: _pickedPhotoBytes,
    );

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This email is already used by another account.'),
        ),
      );

      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully.')),
    );

    Navigator.pop(context);
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontWeight: FontWeight.w600,
          ),
        ),

        backgroundColor: Colors.white,
        elevation: 0.5,

        iconTheme: const IconThemeData(color: Color(0xFF1E3A5F)),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: const Color(0xFFE5E7EB),

                      backgroundImage: _pickedPhotoBytes != null
                          ? MemoryImage(_pickedPhotoBytes!)
                          : null,

                      child: _pickedPhotoBytes == null
                          ? const Icon(
                              Icons.person,
                              size: 55,
                              color: Color(0xFF9CA3AF),
                            )
                          : null,
                    ),

                    Positioned(
                      right: 0,
                      bottom: 0,

                      child: InkWell(
                        onTap: _pickPhoto,
                        borderRadius: BorderRadius.circular(20),

                        child: Container(
                          padding: const EdgeInsets.all(8),

                          decoration: const BoxDecoration(
                            color: Color(0xFF1E3A5F),
                            shape: BoxShape.circle,
                          ),

                          child: const Icon(
                            Icons.camera_alt,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              TextFormField(
                controller: _usernameController,
                validator: _validateUsername,

                decoration: InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: const Icon(Icons.person_outline),
                  filled: true,
                  fillColor: Colors.white,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,

                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email_outlined),
                  filled: true,
                  fillColor: Colors.white,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 52,

                child: ElevatedButton(
                  onPressed: _handleSave,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A5F),
                    foregroundColor: Colors.white,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  child: const Text(
                    'SAVE CHANGES',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}