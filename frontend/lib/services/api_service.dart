import 'package:symptom_checker/models/result_model.dart';
import 'package:symptom_checker/models/clinic_model.dart';

class ApiService {
  // Mock API for diagnosis
  Future<DiagnosisResult> analyzeSymptoms(List<String> symptoms, String? additional) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 2));

    // Mock logic based on symptoms
    if (symptoms.contains('Chest Pain') || symptoms.contains('Breathing Difficulty')) {
      return const DiagnosisResult(
        conditions: [
          Condition(
            name: 'Possible Heart Condition',
            probability: 0.85,
            severity: Severity.severe,
            description: 'Chest pain requires immediate medical attention.',
          ),
        ],
        recommendations: ['Seek emergency care immediately', 'Call emergency services'],
        urgentCare: true,
      );
    } else if (symptoms.contains('Fever') && symptoms.contains('Cough')) {
      return const DiagnosisResult(
        conditions: [
          Condition(
            name: 'Common Cold',
            probability: 0.75,
            severity: Severity.mild,
            description: 'A viral infection of the upper respiratory tract.',
          ),
          Condition(
            name: 'Influenza',
            probability: 0.60,
            severity: Severity.moderate,
            description: 'A contagious respiratory illness.',
          ),
        ],
        recommendations: ['Rest and hydrate', 'Take over-the-counter medications'],
        urgentCare: false,
      );
    } else {
      return const DiagnosisResult(
        conditions: [
          Condition(
            name: 'Mild Viral Infection',
            probability: 0.70,
            severity: Severity.mild,
            description: 'Common symptoms that may resolve with rest.',
          ),
        ],
        recommendations: ['Rest and monitor symptoms', 'Stay hydrated'],
        urgentCare: false,
      );
    }
  }

  // Mock API for clinics
  Future<List<Clinic>> getNearbyClinics() async {
    await Future.delayed(const Duration(seconds: 1));
    return const [
      Clinic(
        name: 'City General Hospital',
        distance: '2.5 km',
        address: '123 Main St',
        phone: '+1 (555) 123-4567',
      ),
      Clinic(
        name: 'Downtown Clinic',
        distance: '1.8 km',
        address: '456 Health Ave',
        phone: '+1 (555) 234-5678',
      ),
      Clinic(
        name: 'Health First Medical Center',
        distance: '3.2 km',
        address: '789 Care Blvd',
        phone: '+1 (555) 345-6789',
      ),
    ];
  }
}