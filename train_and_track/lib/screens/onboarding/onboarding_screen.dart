import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:train_and_track/screens/main_screen.dart'; // Navigate to main app after completion
import 'package:train_and_track/utils/constants.dart';

// Define a model for onboarding data if it becomes complex
// For now, we'll manage with a Map<String, dynamic>
// class OnboardingData {
//   String? age;
//   String? gender;
//   // ... other fields
// }

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 10; // Total number of onboarding questions

  // Store answers
  final Map<String, dynamic> _answers = {};

  // Define your questions here
  // Each item in the list could be a map or a custom class defining the question
  final List<Map<String, dynamic>> _questions = [
    {
      'id': 'age',
      'title': 'What is your age?',
      'type': 'number', // 'text', 'choice', 'multiple_choice'
      'options': [], // For 'choice' or 'multiple_choice'
      'hint': 'Enter your age in years',
    },
    {
      'id': 'gender',
      'title': 'What is your gender?',
      'type': 'choice',
      'options': ['Male', 'Female', 'Other', 'Prefer not to say'],
    },
    {
      'id': 'weight',
      'title': 'What is your current weight?',
      'type': 'number',
      'hint': 'Enter weight in kg or lbs', // Consider adding unit selection
      'suffix': 'kg', // Default unit
    },
    {
      'id': 'height',
      'title': 'What is your current height?',
      'type': 'number',
      'hint': 'Enter height in cm or ft/in',
      'suffix': 'cm', // Default unit
    },
    {
      'id': 'fitnessGoal',
      'title': 'What is your primary fitness goal?',
      'type': 'choice',
      'options': ['Weight Loss', 'Muscle Gain', 'Maintenance', 'Improve Endurance'],
    },
    {
      'id': 'activityLevel',
      'title': 'Describe your daily activity level (excluding workouts):',
      'type': 'choice',
      'options': ['Sedentary (office job)', 'Light (walks, some movement)', 'Moderate (active job/regular movement)', 'Active (physically demanding job)'],
    },
    {
      'id': 'dietaryPreferences',
      'title': 'Any dietary preferences or restrictions?',
      'type': 'multiple_choice', // Or 'text' for free form
      'options': ['Vegetarian', 'Vegan', 'Gluten-Free', 'Dairy-Free', 'None'],
      'hint': 'Select all that apply or describe',
    },
    {
      'id': 'targetWeight',
      'title': 'What is your target weight? (Optional)',
      'type': 'number',
      'hint': 'Enter target weight (kg/lbs)',
      'suffix': 'kg',
      'optional': true,
    },
    {
      'id': 'workoutFrequency',
      'title': 'How many days a week do you plan to work out?',
      'type': 'choice',
      'options': ['1-2 days', '3-4 days', '5+ days', 'Not sure yet'],
    },
    {
      'id': 'waterIntakeGoal',
      'title': 'What is your daily water intake goal?',
      'type': 'number',
      'hint': 'e.g., 8 glasses or 2 liters',
      'suffix': 'liters',
    },
    // Add more questions as needed to reach 10
  ];


  void _nextPage() {
    if (_currentPage < _questions.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _updateAnswer(String questionId, dynamic answer) {
    setState(() {
      _answers[questionId] = answer;
    });
    print("Updated answers: $_answers"); // For debugging
  }

  Future<void> _completeOnboarding() async {
    // Save answers (e.g., to SharedPreferences or backend)
    final prefs = await SharedPreferences.getInstance();
    // Example: Storing a summary or just the completion flag
    // You might want to store each answer individually or as a JSON string
    prefs.setBool(kOnboardingCompleteKey, true);
    _answers.forEach((key, value) {
      if (value is List) { // For multiple choice
        prefs.setStringList('onboarding_$key', value.cast<String>());
      } else {
        prefs.setString('onboarding_$key', value.toString());
      }
    });

    print("Onboarding completed with answers: $_answers");

    // Navigate to the main app screen
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainScreen()), // TODO: Replace with actual MainScreen
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Up Your Profile (${_currentPage + 1}/${_questions.length})'),
        centerTitle: true,
        leading: _currentPage > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: _previousPage,
              )
            : null,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _questions.length,
              physics: const NeverScrollableScrollPhysics(), // Disable swipe
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                final question = _questions[index];
                return _buildQuestionPage(question);
              },
            ),
          ),
          _buildNavigationControls(),
        ],
      ),
    );
  }

  Widget _buildQuestionPage(Map<String, dynamic> question) {
    String questionId = question['id'];
    String title = question['title'];
    String type = question['type'];
    List<String> options = question['options']?.cast<String>() ?? [];
    String? hint = question['hint'];
    String? suffix = question['suffix'];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title, style: kHeadlineTextStyle.copyWith(fontSize: 22), textAlign: TextAlign.center),
          const SizedBox(height: kMediumPadding),
          if (type == 'number' || type == 'text')
            TextFormField(
              initialValue: _answers[questionId]?.toString(),
              decoration: InputDecoration(
                hintText: hint,
                labelText: title,
                suffixText: suffix,
                border: const OutlineInputBorder(),
              ),
              keyboardType: type == 'number' ? TextInputType.number : TextInputType.text,
              onChanged: (value) => _updateAnswer(questionId, value),
              // TODO: Add validation if needed
            ),
          if (type == 'choice')
            ...options.map((option) => RadioListTile<String>(
                  title: Text(option),
                  value: option,
                  groupValue: _answers[questionId] as String?,
                  onChanged: (value) => _updateAnswer(questionId, value),
                )),
          if (type == 'multiple_choice')
            ...options.map((option) {
              List<String> currentSelections = (_answers[questionId] as List?)?.cast<String>() ?? [];
              return CheckboxListTile(
                title: Text(option),
                value: currentSelections.contains(option),
                onChanged: (bool? selected) {
                  List<String> updatedSelections = List.from(currentSelections);
                  if (selected == true) {
                    if (!updatedSelections.contains(option)) {
                      updatedSelections.add(option);
                    }
                  } else {
                    updatedSelections.remove(option);
                  }
                  _updateAnswer(questionId, updatedSelections);
                },
              );
            }),
          const SizedBox(height: kLargePadding),
        ],
      ),
    );
  }

  Widget _buildNavigationControls() {
    bool isLastPage = _currentPage == _questions.length - 1;
    bool canProceed = _answers.containsKey(_questions[_currentPage]['id']) && _answers[_questions[_currentPage]['id']] != null;
    if (_questions[_currentPage]['type'] == 'multiple_choice' && (_answers[_questions[_currentPage]['id']] as List?)?.isEmpty == true) {
        // Allow proceeding for multiple choice even if empty, if not required
        // Or enforce selection: canProceed = (_answers[_questions[_currentPage]['id']] as List).isNotEmpty;
    } else if (_questions[_currentPage]['type'] != 'multiple_choice' && _answers[_questions[_currentPage]['id']]?.toString().isEmpty == true) {
        canProceed = _questions[_currentPage]['optional'] == true; // Allow empty if optional
    }


    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentPage > 0)
            TextButton(
              onPressed: _previousPage,
              child: const Text('Previous'),
            )
          else
            const SizedBox(), // Placeholder for alignment

          ElevatedButton(
            onPressed: (canProceed || _questions[_currentPage]['optional'] == true) ? _nextPage : null,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(isLastPage ? 'Finish Setup' : 'Next'),
          ),
        ],
      ),
    );
  }
}
