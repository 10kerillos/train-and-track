import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:train_and_track/services/auth_service.dart';
import 'package:train_and_track/screens/auth/login_screen.dart'; // For logout navigation
import 'package:train_and_track/screens/profile/profile_screen.dart'; // Import ProfileScreen
import 'package:train_and_track/utils/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showFeatureTodoSnackBar(BuildContext context, String featureName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$featureName feature is not yet implemented.')),
    );
  }

  Widget _buildSettingsTile(
      {required BuildContext context,
      required IconData icon,
      required String title,
      String? subtitle,
      VoidCallback? onTap,
      Widget? trailing}) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap ?? () => _showFeatureTodoSnackBar(context, title),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kSmallPadding),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
      ),
      body: ListView(
        children: <Widget>[
          _buildSectionTitle(context, 'Account & App'),
          _buildSettingsTile(
            context: context,
            icon: Icons.star_outline,
            title: 'Premium',
            subtitle: 'Unlock exclusive features',
            onTap: () => _showFeatureTodoSnackBar(context, 'Premium'),
          ),
          _buildSettingsTile(
            context: context,
            icon: Icons.person_outline,
            title: 'My Profile',
            subtitle: 'Manage your personal data and goals',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
          _buildSettingsTile(
            context: context,
            icon: Icons.palette_outlined,
            title: 'App Appearance',
            subtitle: 'Customize themes (Light/Dark mode)',
          ),

          _buildSectionTitle(context, 'Activity & Tracking'),
          _buildSettingsTile(
            context: context,
            icon: Icons.directions_walk_outlined,
            title: 'Steps',
            subtitle: 'Adjust daily step goals',
          ),
          _buildSettingsTile(
            context: context,
            icon: Icons.emoji_events_outlined,
            title: 'Challenges',
            subtitle: 'Join fitness challenges',
          ),
          _buildSettingsTile(
            context: context,
            icon: Icons.square_foot_outlined,
            title: 'Measurements',
            subtitle: 'Track body measurements',
          ),

          _buildSectionTitle(context, 'Communication'),
           _buildSettingsTile(
            context: context,
            icon: Icons.message_outlined,
            title: 'Messages',
            subtitle: 'View app messages or trainer chats',
          ),
          _buildSettingsTile(
            context: context,
            icon: Icons.notifications_active_outlined,
            title: 'Push Notifications',
            subtitle: 'Set reminders for workouts, meals, water',
          ),
          _buildSettingsTile(
            context: context,
            icon: Icons.language_outlined,
            title: 'Language',
            subtitle: 'Select preferred app language',
          ),

          _buildSectionTitle(context, 'General'),
          _buildSettingsTile(
            context: context,
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Settings',
          ),
           _buildSettingsTile(
            context: context,
            icon: Icons.help_outline,
            title: 'Help & Support',
          ),
          _buildSettingsTile(
            context: context,
            icon: Icons.sync_outlined,
            title: 'Sync Data',
            subtitle: 'Last synced: Just now',
          ),
          const Divider(height: kMediumPadding),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red.shade700),
            title: Text('Logout', style: TextStyle(color: Colors.red.shade700, fontWeight: FontWeight.w600)),
            onTap: () async {
              bool? confirmLogout = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirm Logout'),
                    content: const Text('Are you sure you want to log out?'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                      TextButton(
                        child: Text('Logout', style: TextStyle(color: Colors.red.shade700)),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ],
                  );
                },
              );

              if (confirmLogout == true) {
                await authService.signOut();
                if (context.mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (Route<dynamic> route) => false,
                  );
                }
              }
            },
          ),
          const SizedBox(height: kLargePadding),
        ],
      ),
    );
  }
}
