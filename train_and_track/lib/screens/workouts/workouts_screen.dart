import 'package:flutter/material.dart';
import 'package:train_and_track/utils/constants.dart';

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({super.key});

  // Placeholder for the image path
  // IMPORTANT: Make sure you have an image at 'assets/images/human_model_placeholder.png'
  // and that your pubspec.yaml includes this asset folder.
  final String humanModelImagePath = 'assets/images/human_model_placeholder.png';

  void _showMuscleGroupInfo(BuildContext context, String muscleGroup) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Muscle Group Selected'),
          content: Text('You selected the $muscleGroup.\n\nDetails about $muscleGroup exercises and information would be shown here.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    // Alternatively, use a SnackBar:
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text('Selected Muscle Group: $muscleGroup. Details would appear here.')),
    // );
  }

  Widget _buildMuscleButton(BuildContext context, String muscleName, {EdgeInsetsGeometry? margin}) {
    return Padding(
      padding: margin ?? const EdgeInsets.symmetric(vertical: 4.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          textStyle: const TextStyle(fontSize: 16),
        ),
        onPressed: () => _showMuscleGroupInfo(context, muscleName),
        child: Text(muscleName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Target Muscle Groups'),
        centerTitle: true,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Select a Muscle Group',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: kSmallPadding),
            Text(
              'Tap on a muscle group on the model (simulated below) or use the buttons to view targeted exercises.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: kMediumPadding),

            // 3D Human Model Placeholder
            Container(
              width: double.infinity, // Take available width
              height: 350, // Fixed height for the placeholder
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade200, // Placeholder background
              ),
              // Attempt to load the image, with a fallback
              child: Image.asset(
                humanModelImagePath,
                fit: BoxFit.contain, // Or BoxFit.cover, depending on the image
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  // Fallback if the image fails to load
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_search, size: 80, color: Colors.grey.shade600),
                        const SizedBox(height: kSmallPadding),
                        Text(
                          'Human model image not found.\n(Expected at $humanModelImagePath)',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: kMediumPadding),

            Text(
              'Or select from the list:',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: kSmallPadding),

            // Clickable Muscle Groups (Buttons)
            // Using a Wrap for better layout if there are many buttons
            Wrap(
              spacing: 8.0, // Horizontal space between buttons
              runSpacing: 4.0, // Vertical space between lines of buttons
              alignment: WrapAlignment.center,
              children: <Widget>[
                _buildMuscleButton(context, 'Chest'),
                _buildMuscleButton(context, 'Back'),
                _buildMuscleButton(context, 'Legs (Quads, Hamstrings, Calves)'),
                _buildMuscleButton(context, 'Shoulders (Deltoids)'),
                _buildMuscleButton(context, 'Arms (Biceps, Triceps)'),
                _buildMuscleButton(context, 'Abs (Core)'),
                _buildMuscleButton(context, 'Glutes'),
                // Add more specific muscle groups if needed
              ],
            ),
             const SizedBox(height: kLargePadding),
          ],
        ),
      ),
    );
  }
}
