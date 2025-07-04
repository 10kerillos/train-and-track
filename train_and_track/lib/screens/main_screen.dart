import 'package:flutter/material.dart';
import 'package:train_and_track/screens/dashboard/dashboard_screen.dart';
import 'package:train_and_track/screens/workouts/workouts_screen.dart';
import 'package:train_and_track/screens/recipes/recipes_screen.dart';
import 'package:train_and_track/screens/settings/settings_screen.dart';
import 'package:train_and_track/screens/logging/log_workout_screen.dart';
import 'package:train_and_track/screens/logging/log_meal_screen.dart';
import 'package:train_and_track/screens/logging/log_water_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Corresponds to Dashboard, Workouts, Recipes, Settings

  // Define the pages for the BottomNavigationBar.
  // The "Add" button is handled by FAB and doesn't need a page here.
  // The indices for _widgetOptions are 0:Dashboard, 1:Workouts, 2:Recipes, 3:Settings
  static final List<Widget> _widgetOptions = <Widget>[
    const DashboardScreen(),
    const WorkoutsScreen(),
    const RecipesScreen(),
    const SettingsScreen(),
  ];

  // This `_onItemTapped` is for the actual BottomNavigationBar items,
  // not the FAB. The FAB has its own `onPressed` handler.
  void _onBottomNavItemTapped(int navBarIndex) {
    // navBarIndex is the visual index: 0 (Dash), 1 (Workouts), 2 (Recipes), 3 (Settings)
    setState(() {
      _selectedIndex = navBarIndex;
    });
  }

  void _showAddLogModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext modalContext) { // Use a different context name
        return Container(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: <Widget>[
              Text("Log Your Activity", style: Theme.of(modalContext).textTheme.titleLarge),
              const SizedBox(height: 20, width: double.infinity), // Spacer
              ElevatedButton.icon(
                icon: const Icon(Icons.fitness_center),
                label: const Text('Log Workout'),
                onPressed: () {
                  Navigator.pop(modalContext); // Close the modal first
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LogWorkoutScreen()));
                },
                style: ElevatedButton.styleFrom(minimumSize: const Size(150, 50)),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.restaurant_menu),
                label: const Text('Log Meal'),
                onPressed: () {
                  Navigator.pop(modalContext); // Close the modal
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LogMealScreen()));
                },
                style: ElevatedButton.styleFrom(minimumSize: const Size(150, 50)),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.local_drink),
                label: const Text('Log Water'),
                onPressed: () {
                  Navigator.pop(modalContext); // Close the modal
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LogWaterScreen()));
                },
                style: ElevatedButton.styleFrom(minimumSize: const Size(150, 50)),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: SizedBox(
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildNavItem(icon: Icons.dashboard_outlined, activeIcon: Icons.dashboard, label: 'Dashboard', index: 0),
              _buildNavItem(icon: Icons.fitness_center_outlined, activeIcon: Icons.fitness_center, label: 'Workouts', index: 1),
              const SizedBox(width: 40), // The notch space for FAB
              _buildNavItem(icon: Icons.menu_book_outlined, activeIcon: Icons.menu_book, label: 'Recipes', index: 2),
              _buildNavItem(icon: Icons.settings_outlined, activeIcon: Icons.settings, label: 'Settings', index: 3),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddLogModal,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add, color: Colors.white),
        elevation: 2.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildNavItem({required IconData icon, IconData? activeIcon, required String label, required int index}) {
    bool isSelected = _selectedIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => _onBottomNavItemTapped(index),
        borderRadius: BorderRadius.circular(20), // Optional: for ink splash effect
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              isSelected ? (activeIcon ?? icon) : icon,
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey[600],
              size: 24,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey[600],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
