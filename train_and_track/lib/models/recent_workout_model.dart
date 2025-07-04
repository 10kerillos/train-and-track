// Defines the data structure for a recent workout entry.
class RecentWorkout {
  final String name;
  final String duration;
  final String caloriesBurned;
  // final DateTime date; // Optional: Could add a date for more detailed tracking

  RecentWorkout({
    required this.name,
    required this.duration,
    required this.caloriesBurned,
    // this.date,
  });

  // Potential future enhancements:
  // factory RecentWorkout.fromJson(Map<String, dynamic> json) {
  //   return RecentWorkout(
  //     name: json['name'],
  //     duration: json['duration'],
  //     caloriesBurned: json['caloriesBurned'],
  //     // date: DateTime.parse(json['date']),
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'name': name,
  //     'duration': duration,
  //     'caloriesBurned': caloriesBurned,
  //     // 'date': date?.toIso8601String(),
  //   };
  // }
}
