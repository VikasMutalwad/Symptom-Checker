import 'package:symptom_checker/models/result_model.dart';
import 'package:symptom_checker/models/clinic_model.dart';

class ApiService {
  // Mock API for diagnosis
  Future<DiagnosisResult> analyzeSymptoms(List<String> symptoms, String? additional) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 2));

    // Mock logic based on symptoms
    if (symptoms.contains('Chest Pain') || symptoms.contains('Breathing Difficulty')) {
      return DiagnosisResult(
        conditions: ['Possible Heart Condition', 'Respiratory Issue'],
        severity: Severity.severe,
      );
    } else if (symptoms.contains('Fever') && symptoms.contains('Cough')) {
      return DiagnosisResult(
        conditions: ['Common Cold', 'Flu'],
        severity: Severity.moderate,
      );
    } else {
      return DiagnosisResult(
        conditions: ['Mild Viral Infection'],
        severity: Severity.mild,
      );
    }
  }

  // Mock API for clinics
  Future<List<Clinic>> getNearbyClinics() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Clinic(name: 'City General Hospital', distance: '2.5 km'),
      Clinic(name: 'Downtown Clinic', distance: '1.8 km'),
      Clinic(name: 'Health First Medical Center', distance: '3.2 km'),
    ];
  }
}