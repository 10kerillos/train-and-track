import 'package:flutter/material.dart';

class LogWorkoutScreen extends StatelessWidget {
  const LogWorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Workout'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.fitness_center, size: 80, color: Colors.blueAccent),
              const SizedBox(height: 20),
              const Text(
                'Log Your Workout Session',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Track exercises, sets, reps, duration, and calories burned.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement workout logging form and save functionality
                  Navigator.pop(context); // Go back after "logging"
                },
                child: const Text('Save Workout (Placeholder)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
