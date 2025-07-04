import 'dart:math';

enum Gender { male, female }
enum ActivityLevel { sedentary, light, moderate, active, veryActive }
enum FitnessGoal { weightLoss, maintenance, muscleGain }

class FitnessCalculator {
  // Mifflin-St Jeor Equation for BMR
  // Weight in kg, height in cm, age in years
  static double calculateBMR({
    required double weight,
    required double height,
    required int age,
    required Gender gender,
  }) {
    if (weight <= 0 || height <= 0 || age <= 0) {
      throw ArgumentError("Weight, height, and age must be positive values.");
    }
    if (gender == Gender.male) {
      return (10 * weight) + (6.25 * height) - (5 * age) + 5;
    } else { // Gender.female
      return (10 * weight) + (6.25 * height) - (5 * age) - 161;
    }
  }

  // Calculate TDEE (Total Daily Energy Expenditure)
  static double calculateTDEE({
    required double bmr,
    required ActivityLevel activityLevel,
  }) {
    if (bmr <= 0) {
      throw ArgumentError("BMR must be a positive value.");
    }
    switch (activityLevel) {
      case ActivityLevel.sedentary:
        return bmr * 1.2;
      case ActivityLevel.light:
        return bmr * 1.375;
      case ActivityLevel.moderate:
        return bmr * 1.55;
      case ActivityLevel.active:
        return bmr * 1.725;
      case ActivityLevel.veryActive:
        return bmr * 1.9;
      default:
        return bmr * 1.2; // Default to sedentary
    }
  }

  // Calculate BMI (Body Mass Index)
  // Weight in kg, height in meters
  static double calculateBMI({required double weight, required double heightInCm}) {
    if (weight <= 0 || heightInCm <= 0) {
      throw ArgumentError("Weight and height must be positive values.");
    }
    double heightInM = heightInCm / 100;
    return weight / (heightInM * heightInM);
  }

  // Get BMI Category
  static String getBMICategory(double bmi) {
    if (bmi < 18.5) return "Underweight";
    if (bmi < 24.9) return "Normal weight";
    if (bmi < 29.9) return "Overweight";
    return "Obesity";
  }

  // Calculate Ideal Weight Range using BMI
  // Returns a map with 'min' and 'max' ideal weight in kg
  // Height in cm
  static Map<String, double> calculateIdealWeightRange({required double heightInCm}) {
    if (heightInCm <= 0) {
      throw ArgumentError("Height must be a positive value.");
    }
    double heightInM = heightInCm / 100;
    // Using healthy BMI range of 18.5 to 24.9
    double minIdealWeight = 18.5 * (heightInM * heightInM);
    double maxIdealWeight = 24.9 * (heightInM * heightInM);
    return {'min': minIdealWeight, 'max': maxIdealWeight};
  }

    // Devine Formula for Ideal Body Weight (IBW) - simple but with limitations
    // Height in cm, gender
    // Returns IBW in kg
    static double calculateIdealWeightDevine({required double heightInCm, required Gender gender}) {
        if (heightInCm <= 152.4) { // 5 feet
            return (gender == Gender.male) ? 50.0 : 45.5; // Base weight for 5 feet
        }
        double heightInInches = heightInCm / 2.54;
        double inchesOver5Feet = heightInInches - 60;
        if (gender == Gender.male) {
            return 50.0 + (2.3 * inchesOver5Feet);
        } else { // Gender.female
            return 45.5 + (2.3 * inchesOver5Feet);
        }
    }


  // Calculate Daily Calorie Target
  static double calculateDailyCalorieTarget({
    required double tdee,
    required FitnessGoal goal,
    double adjustmentFactor = 500, // Calories to add/subtract for gain/loss
  }) {
    if (tdee <= 0) {
      throw ArgumentError("TDEE must be a positive value.");
    }
    switch (goal) {
      case FitnessGoal.weightLoss:
        return tdee - adjustmentFactor;
      case FitnessGoal.maintenance:
        return tdee;
      case FitnessGoal.muscleGain:
        return tdee + adjustmentFactor;
      default:
        return tdee;
    }
  }

  // Calculate Macronutrient Needs
  // Returns a map with 'carbs', 'protein', 'fat' in grams
  // Default ratios: 40% Carbs, 30% Protein, 30% Fat
  static Map<String, double> calculateMacronutrients({
    required double calorieTarget,
    double carbRatio = 0.40,
    double proteinRatio = 0.30,
    double fatRatio = 0.30,
  }) {
    if (calorieTarget <= 0) {
      throw ArgumentError("Calorie target must be a positive value.");
    }
    if ((carbRatio + proteinRatio + fatRatio) > 1.01 || (carbRatio + proteinRatio + fatRatio) < 0.99) {
        // Allow for slight floating point inaccuracies
        throw ArgumentError("Macronutrient ratios must sum to approximately 1.0.");
    }

    double carbsInGrams = (calorieTarget * carbRatio) / 4; // 4 calories per gram of carbs
    double proteinInGrams = (calorieTarget * proteinRatio) / 4; // 4 calories per gram of protein
    double fatInGrams = (calorieTarget * fatRatio) / 9; // 9 calories per gram of fat

    return {
      'carbs': carbsInGrams,
      'protein': proteinInGrams,
      'fat': fatInGrams,
    };
  }

  // Example usage (can be removed or kept for testing)
  static void printExampleCalculations() {
    try {
      double weight = 70; // kg
      double height = 175; // cm
      int age = 30; // years
      Gender gender = Gender.male;
      ActivityLevel activity = ActivityLevel.moderate;
      FitnessGoal goal = FitnessGoal.muscleGain;

      double bmr = calculateBMR(weight: weight, height: height, age: age, gender: gender);
      print("BMR: ${bmr.toStringAsFixed(2)} kcal");

      double tdee = calculateTDEE(bmr: bmr, activityLevel: activity);
      print("TDEE: ${tdee.toStringAsFixed(2)} kcal");

      double bmi = calculateBMI(weight: weight, heightInCm: height);
      print("BMI: ${bmi.toStringAsFixed(2)} (${getBMICategory(bmi)})");

      Map<String, double> idealRange = calculateIdealWeightRange(heightInCm: height);
      print("Ideal Weight Range (BMI method): ${idealRange['min']?.toStringAsFixed(2)} kg - ${idealRange['max']?.toStringAsFixed(2)} kg");

      double idealDevine = calculateIdealWeightDevine(heightInCm: height, gender: gender);
      print("Ideal Weight (Devine): ${idealDevine.toStringAsFixed(2)} kg");

      double calorieTarget = calculateDailyCalorieTarget(tdee: tdee, goal: goal);
      print("Daily Calorie Target: ${calorieTarget.toStringAsFixed(2)} kcal for $goal");

      Map<String, double> macros = calculateMacronutrients(calorieTarget: calorieTarget);
      print("Macronutrients (g): Carbs: ${macros['carbs']?.toStringAsFixed(2)}, Protein: ${macros['protein']?.toStringAsFixed(2)}, Fat: ${macros['fat']?.toStringAsFixed(2)}");

    } catch (e) {
      print("Error in example calculations: $e");
    }
  }
}
