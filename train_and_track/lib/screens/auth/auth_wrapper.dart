import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:train_and_track/services/auth_service.dart';
import 'package:train_and_track/screens/auth/login_screen.dart';
import 'package:train_and_track/screens/main_screen.dart'; // Placeholder for your main app screen
import 'package:train_and_track/screens/onboarding/onboarding_screen.dart';
import 'package:train_and_track/utils/constants.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  Future<bool> _isOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(kOnboardingCompleteKey) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData && snapshot.data != null) {
          // User is logged in
          return FutureBuilder<bool>(
            future: _isOnboardingComplete(),
            builder: (context, onboardingSnapshot) {
              if (onboardingSnapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              if (onboardingSnapshot.hasData && onboardingSnapshot.data == true) {
                // Onboarding is complete, go to main app
                return const MainScreen(); // TODO: Replace with your actual MainScreen
              } else {
                // Onboarding not complete or first time login, go to onboarding
                return const OnboardingScreen(); // TODO: Replace with your actual OnboardingScreen
              }
            },
          );
        }
        // User is not logged in
        return const LoginScreen();
      },
    );
  }
}
