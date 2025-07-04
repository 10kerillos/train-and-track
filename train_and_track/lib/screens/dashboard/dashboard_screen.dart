import 'package:flutter/material.dart';
import 'package:train_and_track/utils/constants.dart';
import 'package:train_and_track/screens/profile/profile_screen.dart'; // Import ProfileScreen
import 'package:train_and_track/models/recent_workout_model.dart'; // Import the new model

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Dummy data for display
  final String userName = "Alex"; // TODO: Replace with actual user data
  final String weight = "75 kg";
  final String height = "180 cm";
  final String bmi = "23.1";
  final String bodyFat = "15%";
  final String leanMass = "63.7 kg";
  final String dailyCalories = "2200 kcal";

  final String caloriesConsumed = "1200/2200 kcal";
  final String waterIntake = "1.5/3 L";
  final String proteinIntake = "80/150 g";
  final String stepsTaken = "7500/10000";

  final List<RecentWorkout> recentWorkouts = [
    RecentWorkout(name: "Morning Run", duration: "30 min", caloriesBurned: "300 kcal"),
    RecentWorkout(name: "Full Body Strength", duration: "60 min", caloriesBurned: "450 kcal"),
    RecentWorkout(name: "Yoga Session", duration: "45 min", caloriesBurned: "200 kcal"),
  ];

  void openKeroAI() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🤖 Kero AI Chat Activated! (Placeholder)'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.account_circle_outlined, size: 28),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          },
        ),
        title: const Text('Train and Track', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, size: 28),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Show Notifications (TODO)')),
              );
            },
          ),
        ],
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back, $userName!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: kMediumPadding),
            _buildHealthMetricsBox(),
            const SizedBox(height: kMediumPadding),
            _buildQuickStatsGrid(),
            const SizedBox(height: kMediumPadding),
            _buildRecentWorkoutsSection(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openKeroAI,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Text('🤖', style: TextStyle(fontSize: 24, color: Colors.white)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildHealthMetricsBox() {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.blue.shade700,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMetricItem("Weight", weight, Colors.white, isTopRow: true),
              _buildMetricItem("Height", height, Colors.white, isTopRow: true),
              _buildMetricItem("BMI", bmi, Colors.white, isTopRow: true),
            ],
          ),
          const Divider(color: Colors.white54, height: 20, thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMetricItem("Body Fat", bodyFat, Colors.white),
              _buildMetricItem("Lean Mass", leanMass, Colors.white),
              _buildMetricItem("Daily Cals", dailyCalories, Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem(String label, String value, Color textColor, {bool isTopRow = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: isTopRow ? 14 : 13, color: textColor.withOpacity(0.8)),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: isTopRow ? 18 : 16, fontWeight: FontWeight.bold, color: textColor),
        ),
      ],
    );
  }

  Widget _buildQuickStatsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: kDefaultPadding,
      mainAxisSpacing: kDefaultPadding,
      childAspectRatio: 1.8,
      children: [
        _buildStatCard("Calories", caloriesConsumed, Icons.local_fire_department, Colors.orange),
        _buildStatCard("Water", waterIntake, Icons.water_drop, Colors.lightBlue),
        _buildStatCard("Protein", proteinIntake, Icons.egg, Colors.pink),
        _buildStatCard("Steps", stepsTaken, Icons.directions_walk, Colors.green),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color iconColor) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(kSmallPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor, size: 28),
                const SizedBox(width: kSmallPadding),
                Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
            const Spacer(),
            Text(value, style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: iconColor, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentWorkoutsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Workouts",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: kSmallPadding),
        if (recentWorkouts.isEmpty)
          const Text("No recent workouts logged yet."),
        if (recentWorkouts.isNotEmpty)
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recentWorkouts.length > 3 ? 3 : recentWorkouts.length,
            itemBuilder: (context, index) {
              final workout = recentWorkouts[index];
              return Card(
                elevation: 1.5,
                margin: const EdgeInsets.symmetric(vertical: kSmallPadding / 2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: const Icon(Icons.fitness_center, color: kPrimaryColor),
                  title: Text(workout.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text("${workout.duration} - ${workout.caloriesBurned}"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Details for ${workout.name} (TODO)')),
                    );
                  },
                ),
              );
            },
          ),
      ],
    );
  }
}
