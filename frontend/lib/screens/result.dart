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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Confidence Score Display
              if (result.confidence > 0)
                Card(
                  elevation: 4,
                  color: Colors.blue[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Analysis Confidence',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: result.confidence,
                                  minHeight: 10,
                                  backgroundColor: Colors.grey[700],
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    result.confidence > 0.8
                                        ? Colors.green
                                        : Colors.orange,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              '${(result.confidence * 100).toStringAsFixed(0)}%',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 24),
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
                      const SizedBox(height: 12),
                      ...result.conditions.map((condition) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle, color: Colors.green, size: 20),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                condition,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      )),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Text(
                            'Severity: ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
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
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Please consult with a healthcare professional for proper diagnosis and treatment. This analysis is for informational purposes only.',
                    style: TextStyle(fontSize: 16, color: Colors.grey[300]),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'View Nearby Clinics',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ClinicSuggestionScreen(clinics: result.clinics ?? []),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}