import 'package:flutter/material.dart';

class LogWaterScreen extends StatelessWidget {
  const LogWaterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Water Intake'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.local_drink, size: 80, color: Colors.lightBlueAccent),
              const SizedBox(height: 20),
              const Text(
                'Log Your Water Consumption',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Track the amount of water you drink throughout the day.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              // Example: Quick add buttons or a text field
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: () {/* TODO: Log 250ml */ Navigator.pop(context);}, child: const Text('+250ml')),
                  ElevatedButton(onPressed: () {/* TODO: Log 500ml */ Navigator.pop(context);}, child: const Text('+500ml')),
                ],
              ),
               const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement custom water logging and save functionality
                  Navigator.pop(context); // Go back after "logging"
                },
                child: const Text('Save Water Log (Placeholder)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
