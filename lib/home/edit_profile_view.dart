import 'package:flutter/material.dart';
import 'package:pfe_coashing_app/core/utils/show_flash_bar.dart';
import 'package:pfe_coashing_app/core/utils/validator.dart'; // Import ValidationUtils
import 'package:pfe_coashing_app/home/navigation.dart';
import 'package:pfe_coashing_app/models/user.dart';
import 'package:pfe_coashing_app/services/auth_service.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _emailController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;
  bool _isEditing = false;
  User? _userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
  setState(() => _isLoading = true);
  try {
    final response = await _authService.getCurrentUser();
    if (!response.isError && response.data != null) {
      setState(() {
        _userData = response.data; // Use the User object directly

        // Populate the controllers with user data
        _userNameController.text = _userData?.username ?? '';
        _heightController.text = _userData?.height.toString() ?? '';
        _weightController.text = _userData?.weight.toString() ?? '';
        _emailController.text = _userData?.email ?? '';
      });
    } else {
      showFlushBar(context, message: response.errorMessage ?? 'Failed to load user data', success: false);
    }
  } catch (e) {
    showFlushBar(context, message: 'An error occurred: $e', success: false);
  } finally {
    setState(() => _isLoading = false);
  }
}

  Future<void> _handleSave() async {
  if (_formKey.currentState!.validate()) {
    setState(() => _isLoading = true);
    try {
      final response = await _authService.updateProfile({
        'username': _userNameController.text,
        'height': double.tryParse(_heightController.text),
        'weight': double.tryParse(_weightController.text),
        'email': _emailController.text,
      });

      if (!response.isError) {
        setState(() {
          _isEditing = false;
          _userData = response.data; // Use the updated User object
        });
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => const Navigation(), // Navigate to ProfileView after saving
        ));
        showFlushBar(context, message: 'Profile updated successfully', success: true);
        
      
      } else {
        showFlushBar(context, message: response.errorMessage ?? 'Failed to update profile', success: false);
      }
    } catch (e) {
      showFlushBar(context, message: 'An error occurred: $e', success: false);
    } finally {
      setState(() => _isLoading = false);
    }
  }
}

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) {
        // Reset fields to original data if editing is canceled
        _userNameController.text = _userData?.username ?? '';
        _heightController.text = _userData?.height.toString() ?? '';
        _weightController.text = _userData?.weight.toString() ?? '';
        _emailController.text = _userData?.email ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          if (!_isLoading)
            IconButton(
              icon: Icon(_isEditing ? Icons.cancel : Icons.edit),
              onPressed: _toggleEditing,
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        child: Icon(Icons.person, size: 50),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _userNameController,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                        ),
                        enabled: _isEditing,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),

                      TextFormField(
                        controller: _heightController,
                        decoration: const InputDecoration(
                          labelText: 'Height (cm)',
                        ),
                        enabled: _isEditing,
                        validator: ValidationUtils.validateHeight, // Use ValidationUtils
                      ),
                      TextFormField(
                        controller: _weightController,
                        decoration: const InputDecoration(
                          labelText: 'Weight (kg)',
                        ),
                        enabled: _isEditing,
                        validator: ValidationUtils.validateWeight, // Use ValidationUtils
                      ),
                      
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                        ),
                        enabled: _isEditing,
                        validator: ValidationUtils.validateEmail, // Use ValidationUtils
                      ),
                      if (_isEditing) const SizedBox(height: 24),
                      if (_isEditing)
                        ElevatedButton(
                          onPressed: _isLoading ? null : _handleSave,
                          child: const Text('Save Changes'),
                        ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}