import 'package:flutter/material.dart';
import 'package:train_and_track/utils/constants.dart'; // For styling and constants

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Placeholder data - In a real app, this would come from AuthService or a user data service
  String _userName = "Alex Doe";
  String _email = "alex.doe@example.com";
  String _age = "30";
  String _height = "180 cm";
  String _weight = "75 kg";
  String _fitnessGoal = "Muscle Gain";

  // Controllers for editing (if you add editing functionality directly here)
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  // ... add more controllers as needed

  bool _isEditing = false; // To toggle between view and edit mode

  @override
  void initState() {
    super.initState();
    // Initialize controllers with current data
    _nameController.text = _userName;
    _ageController.text = _age;
    // ... initialize other controllers
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    // ... dispose other controllers
    super.dispose();
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) {
        // If exiting edit mode, save changes (placeholder for actual save logic)
        _userName = _nameController.text;
        _age = _ageController.text;
        // TODO: Call a service to save updated profile data
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile changes saved (placeholder)!')),
        );
      } else {
        // If entering edit mode, ensure controllers are up to date
        _nameController.text = _userName;
        _ageController.text = _age;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Profile' : 'My Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save_outlined : Icons.edit_outlined),
            onPressed: _toggleEditMode,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey.shade300,
                    // TODO: Replace with user's profile picture
                    child: Icon(Icons.person, size: 70, color: Colors.grey.shade700),
                  ),
                  if (_isEditing)
                    MaterialButton(
                      onPressed: () { /* TODO: Implement image picker */ },
                      color: Theme.of(context).colorScheme.primary,
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(8),
                      shape: const CircleBorder(),
                      child: const Icon(Icons.camera_alt, size: 20),
                    )
                ],
              ),
            ),
            const SizedBox(height: kMediumPadding),
            if (_isEditing) ...[
              _buildEditableTextField(label: "Name", controller: _nameController, icon: Icons.person_outline),
              _buildEditableTextField(label: "Age", controller: _ageController, icon: Icons.cake_outlined, keyboardType: TextInputType.number),
              // TODO: Add more editable fields for height, weight, fitness goal, etc.
              // Example:
              // _buildEditableTextField(label: "Height (cm)", controller: _heightController, icon: Icons.height, keyboardType: TextInputType.number),
              // _buildEditableTextField(label: "Weight (kg)", controller: _weightController, icon: Icons.monitor_weight_outlined, keyboardType: TextInputType.number),
              // Consider using a DropdownButtonFormField for fitnessGoal if editing
            ] else ...[
              _buildProfileInfoTile(icon: Icons.email_outlined, title: 'Email', value: _email),
              _buildProfileInfoTile(icon: Icons.person_outline, title: 'Name', value: _userName),
              _buildProfileInfoTile(icon: Icons.cake_outlined, title: 'Age', value: _age),
              _buildProfileInfoTile(icon: Icons.height, title: 'Height', value: _height),
              _buildProfileInfoTile(icon: Icons.monitor_weight_outlined, title: 'Weight', value: _weight),
              _buildProfileInfoTile(icon: Icons.flag_outlined, title: 'Primary Goal', value: _fitnessGoal),
            ],
            const SizedBox(height: kLargePadding),
            // TODO: Add options for changing password, linked accounts, etc.
            if (!_isEditing)
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.lock_reset_outlined),
                  label: const Text('Change Password'),
                  onPressed: () {
                     ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(content: Text('Change Password (TODO)')),
                     );
                    // TODO: Navigate to change password screen or show dialog
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfoTile({required IconData icon, required String title, required String value}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: kSmallPadding / 2),
      elevation: 1,
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(value, style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }

  Widget _buildEditableTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kSmallPadding),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        ),
        validator: validator,
      ),
    );
  }
}
