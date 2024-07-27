import 'dart:io';

import 'package:book_worm/models/user.dart';
import 'package:book_worm/services/isar_service.dart';
import 'package:book_worm/widgets/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class EditUserPage extends StatefulWidget {
  const EditUserPage({super.key});

  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final _formKey = GlobalKey<FormState>();
  final IsarService _isarService = IsarService();

  late TextEditingController _usernameController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _biographyController;
  File? _imageLoaded;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _biographyController = TextEditingController();
    _loadUserData();
  }

  void _loadUserData() async {
    final user = await _isarService.getUser().then((future) => future);
    if (user != null) {
      setState(() {
        _usernameController.text = user.username ?? '';
        _firstNameController.text = user.firstName ?? '';
        _lastNameController.text = user.lastName ?? '';
        _biographyController.text = user.biography ?? '';
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _biographyController.dispose();
    super.dispose();
  }

  void _saveUser() async {
    if (_formKey.currentState!.validate()) {
      final updatedUser = User(
        username: _usernameController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        biography: _biographyController.text,
      );
      final applicationDirectory = await getApplicationDocumentsDirectory();
      final path = applicationDirectory.path;
      File? newImage =
          await _imageLoaded!.copy('$path/${_usernameController.text}.jpg');
      updatedUser.profileImage = newImage.path;

      await _isarService.updateUser(updatedUser);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildInputField("Username", _usernameController, 1),
              const SizedBox(height: 16),
              _buildInputField("First Name", _firstNameController, 1),
              const SizedBox(height: 16),
              _buildInputField("Last name", _lastNameController, 1),
              const SizedBox(height: 16),
              _buildInputField("Biography", _biographyController, 3),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  ImagePickerHelper(onImagePicked: (file) {
                    _imageLoaded = File(file.path);
                    const SnackBar(content: Text("Successfully loaded image"),);
                  }).showImagePickerOptions(context);
                },
                child: const Text('Change Profile Picture'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveUser,
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
      String label, TextEditingController controller, int maxLines) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          width: double.infinity,
          child: TextField(
            textCapitalization: TextCapitalization.words,
            maxLines: maxLines,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 16.0,
              ),
              border: OutlineInputBorder(),
            ),
            controller: controller,
          ),
        ),
      ],
    );
  }
}
