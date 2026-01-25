import 'package:flutter/material.dart';
import 'package:symptom_checker/models/result_model.dart';
import 'package:symptom_checker/widgets/custom_button.dart';
import 'clinic_suggestion_screen.dart';

class ResultScreen extends StatelessWidget {
  final DiagnosisResult result;

  const ResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnosis Result'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Probable Condition(s):',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ...result.conditions.map((condition) => Text(
                      '• $condition',
                      style: const TextStyle(fontSize: 16),
                    )),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text(
                          'Severity: ',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: result.color,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            result.severityText,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Guidance:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Text(
                      _getGuidanceText(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'Find Nearby Clinics',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ClinicSuggestionScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _getGuidanceText() {
    switch (result.severity) {
      case Severity.mild:
      case Severity.moderate:
        return '''
First Aid Instructions:

1. Rest and stay hydrated.
2. Take over-the-counter pain relievers if needed.
3. Monitor your symptoms closely.
4. If symptoms worsen, seek medical attention.

Remember to consult a healthcare professional for proper diagnosis and treatment.
        ''';
      case Severity.severe:
        return '''
WARNING: This appears to be a severe condition.

Immediate Actions:
- Seek emergency medical care immediately.
- Call emergency services if experiencing chest pain or breathing difficulties.
- Do not delay - get professional medical help right away.

Your health is important. Act now!
        ''';
    }
  }
}