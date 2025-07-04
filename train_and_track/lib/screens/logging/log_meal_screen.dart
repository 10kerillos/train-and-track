import 'package:flutter/material.dart';

class LogMealScreen extends StatelessWidget {
  const LogMealScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Meal'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.restaurant_menu, size: 80, color: Colors.green),
              const SizedBox(height: 20),
              const Text(
                'Log Your Meal',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Record food items, portion sizes, calories, and macronutrients.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement meal logging form and save functionality
                  Navigator.pop(context); // Go back after "logging"
                },
                child: const Text('Save Meal (Placeholder)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
