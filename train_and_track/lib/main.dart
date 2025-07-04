import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:train_and_track/services/auth_service.dart';
import 'package:train_and_track/screens/auth/auth_wrapper.dart';
import 'package:train_and_track/utils/constants.dart';
// import 'firebase_options.dart'; // Make sure to generate this with FlutterFire CLI

// Placeholder for firebase_options.dart if you don't have it yet
// You MUST generate this file using `flutterfire configure`
// For now, this is a temporary placeholder to avoid immediate compile errors
// but the app will not connect to Firebase without the real file.
class DefaultFirebaseOptions {
 static FirebaseOptions get currentPlatform {
    // Replace with your actual Firebase config for different platforms
    // This is a DUMMY configuration
    return const FirebaseOptions(
        apiKey: "YOUR_API_KEY", // Replace with your actual API key
        authDomain: "YOUR_AUTH_DOMAIN", // Replace
        projectId: "YOUR_PROJECT_ID", // Replace
        storageBucket: "YOUR_STORAGE_BUCKET", // Replace
        messagingSenderId: "YOUR_MESSAGING_SENDER_ID", // Replace
        appId: "YOUR_APP_ID", // Replace
        // measurementId: "YOUR_MEASUREMENT_ID" // Optional
    );
  }
}


void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  // You will need to run `flutterfire configure` to generate firebase_options.dart
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // TODO: Handle Firebase initialization error (e.g. show an error screen or log)
    print('Failed to initialize Firebase: $e');
    // Optionally, you could run a version of the app that doesn't rely on Firebase
    // or show a critical error message. For now, we'll proceed, but Firebase features won't work.
  }


  runApp(
    MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        // TODO: Add other providers here as your app grows (e.g., for database, state management)
      ],
      child: const TrainAndTrackApp(),
    ),
  );
}

class TrainAndTrackApp extends StatelessWidget {
  const TrainAndTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Train and Track',
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: kPrimaryColor, // Legacy, but good to set
        colorScheme: ColorScheme.fromSeed(
          seedColor: kPrimaryColor,
          brightness: Brightness.light,
          secondary: kSecondaryColor, // Define secondary color for FABs, etc.
          // error: kErrorColor, // Define an error color in constants.dart if needed
        ),
        scaffoldBackgroundColor: kBackgroundColor, // Use from constants
        visualDensity: VisualDensity.adaptivePlatformDensity,

        // Define the default font family (optional).
        // fontFamily: 'YourCustomFont',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          displayLarge: kHeadlineTextStyle.copyWith(fontSize: 32), // Example override
          headlineSmall: kHeadlineTextStyle.copyWith(fontSize: 24), // Used in Dashboard
          titleLarge: kHeadlineTextStyle.copyWith(fontSize: 20),    // Used for section titles
          bodyLarge: kBodyTextStyle,
          bodyMedium: kBodyTextStyle.copyWith(fontSize: 14), // Default for Text()
          labelLarge: kButtonTextStyle.copyWith(color: kPrimaryColor), // For button-like text labels
        ),

        appBarTheme: AppBarTheme(
          backgroundColor: kPrimaryColor, // AppBar background
          foregroundColor: Colors.white, // Text and icon color on AppBar
          elevation: 2.0,
          centerTitle: true,
          titleTextStyle: kHeadlineTextStyle.copyWith(fontSize: 20, color: Colors.white),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            foregroundColor: Colors.white, // Text color
            textStyle: kButtonTextStyle,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 2,
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white.withOpacity(0.8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: kPrimaryColor.withOpacity(0.7)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: kPrimaryColor.withOpacity(0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: kAccentColor, width: 2.0),
          ),
          labelStyle: TextStyle(color: kPrimaryColor.withOpacity(0.9)),
          hintStyle: TextStyle(color: Colors.grey.shade500),
        ),

        cardTheme: CardTheme(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          margin: const EdgeInsets.symmetric(vertical: kSmallPadding / 2, horizontal: kSmallPadding / 2),
        ),

        // Define a basic dark theme (can be expanded later)
        // This is just a starting point.
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: kPrimaryColor, // Or a dark-mode adjusted primary
        colorScheme: ColorScheme.fromSeed(
          seedColor: kPrimaryColor,
          brightness: Brightness.dark,
          secondary: kAccentColor, // Or a dark-mode adjusted accent
          // error: kErrorColorDark,
        ),
        // scaffoldBackgroundColor: const Color(0xFF121212), // Common dark background
        // textTheme: ... // Define dark theme specific text styles if needed
        // appBarTheme: ...
        // cardTheme: ...
        // elevatedButtonTheme: ...
        // inputDecorationTheme: ...
      ),
      themeMode: ThemeMode.system, // Respects system settings, can be changed by user later
      home: const AuthWrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Placeholder screen can be removed or kept for other uses if needed.
// class PlaceholderScreen extends StatelessWidget {
//   final String title;
//   const PlaceholderScreen({super.key, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: Center(
//         child: Text('Welcome to Train and Track!\nApp development in progress.'),
//       ),
//     );
//   }
// }
