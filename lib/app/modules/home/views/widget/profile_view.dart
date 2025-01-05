import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // For working with file system

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  File? _userImage;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  // Function to pick an image from gallery
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _userImage = File(pickedFile.path);
      });
    }
  }

  // Function to handle logout
  void _logout() {
    // Logic for logout
    Navigator.pop(context); // You can also route to a login page here
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color(0xffFFFFFF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,  // Tap to change profile image
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _userImage != null
                    ? FileImage(_userImage!)
                    : const AssetImage('assets/images/default_avatar.png') as ImageProvider,
                child: _userImage == null
                    ? const Icon(
                  Icons.camera_alt,
                  size: 30,
                  color: Colors.white,
                )
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _logout,
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
