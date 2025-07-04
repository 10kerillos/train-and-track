import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:train_and_track/services/auth_service.dart';
import 'package:train_and_track/screens/onboarding/onboarding_screen.dart'; // Navigate to onboarding after signup
import 'package:train_and_track/screens/main_screen.dart'; // Navigate to main app after login
import 'package:train_and_track/utils/constants.dart'; // For styles and constants
import 'package:train_and_track/screens/auth/signup_screen.dart'; // Navigate to signup

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _loginUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
      try {
        final authService = Provider.of<AuthService>(context, listen: false);
        await authService.signInWithEmailAndPassword(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
        // Navigation will be handled by AuthWrapper or stream listener in main/app.dart
        // For now, simulate navigation to MainScreen if successful
        if (mounted && authService.currentUser != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MainScreen()), // TODO: Replace with actual main screen
          );
        }
      } catch (e) {
        setState(() {
          _errorMessage = e.toString().contains('Firebase Auth Exception')
              ? e.toString().split(']').last.trim() // More user-friendly message
              : 'Login failed. Please try again.';
        });
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  Future<void> _loginWithGoogle() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      await authService.signInWithGoogle();
      // Navigation will be handled by AuthWrapper or stream listener
      // For now, simulate navigation to MainScreen if successful
      if (mounted && authService.currentUser != null) {
         // TODO: Check if user is new (from Google Sign In) to direct to onboarding if needed
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainScreen()), // TODO: Replace with actual main screen
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().contains('Firebase Auth Exception')
            ? e.toString().split(']').last.trim()
            : 'Google Sign-In failed. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _navigateToSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login to Train and Track'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Welcome Back!',
                  style: kHeadlineTextStyle.copyWith(fontSize: 28, color: Theme.of(context).colorScheme.primary),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: kSmallPadding),
                Text(
                  'Log in to continue your fitness journey.',
                  style: kBodyTextStyle.copyWith(fontSize: 16, color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: kMediumPadding),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: kSmallPadding),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: kDefaultPadding),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    // You might add more password validation rules here
                    return null;
                  },
                ),
                const SizedBox(height: kMediumPadding),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          textStyle: kButtonTextStyle,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          )
                        ),
                        onPressed: _loginUser,
                        child: const Text('Login'),
                      ),
                const SizedBox(height: kDefaultPadding),
                TextButton(
                  onPressed: () {
                    // TODO: Implement Password Reset functionality
                    // For now, can show a dialog or navigate to a new screen
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Password Reset functionality to be implemented.')),
                    );
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
                const SizedBox(height: kSmallPadding),
                Row(
                  children: <Widget>[
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kSmallPadding),
                      child: Text("OR", style: TextStyle(color: Colors.grey[600])),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: kSmallPadding),
                _isLoading
                    ? const SizedBox.shrink() // Hide Google button when main login is loading
                    : ElevatedButton.icon(
                        icon: const Icon(Icons.g_mobiledata, color: Colors.red), // Placeholder for Google icon
                        label: const Text('Sign in with Google'),
                        onPressed: _loginWithGoogle,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black87,
                          backgroundColor: Colors.white,
                          side: BorderSide(color: Colors.grey[300]!),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          )
                        ),
                      ),
                const SizedBox(height: kMediumPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Don't have an account? "),
                    TextButton(
                      onPressed: _navigateToSignUp,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
