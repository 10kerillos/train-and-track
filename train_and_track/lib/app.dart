import 'package:flutter/material.dart';
// TODO: Import initial screen (e.g., AuthWrapper or LoginScreen)
// import 'package:train_and_track/screens/auth/login_screen.dart'; // Example

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Train and Track',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        // Define other global theme properties here
        // e.g., textTheme, appBarTheme, buttonTheme
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        // Define dark theme specific properties
      ),
      themeMode: ThemeMode.system, // Or allow user to select
      // TODO: Implement routing or set the initial screen
      // home: const LoginScreen(), // Example: Direct to login
      home: Scaffold( // Placeholder home
        appBar: AppBar(title: const Text('Train and Track App')),
        body: const Center(child: Text('App Structure Initializing...')),
      ),
      // navigatorObservers: [], // For navigation analytics or state management
      // routes: { // Define named routes if using them
      //   '/login': (context) => const LoginScreen(),
      // },
    );
  }
}
