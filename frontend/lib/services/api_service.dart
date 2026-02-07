import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:symptom_checker/models/result_model.dart';
import 'package:symptom_checker/models/clinic_model.dart';

class ApiService {
  // API Configuration
  static const String baseUrl = 'http://10.0.2.2:5000'; // Android emulator localhost
  // For physical device, replace with: 'http://YOUR_MACHINE_IP:5000'
  
  static const String analyzeEndpoint = '/api/analyze-symptoms';
  static const String clinicsEndpoint = '/api/clinics';
  static const String symptomsEndpoint = '/api/symptoms';

<<<<<<< HEAD
  // Analyze symptoms and get diagnosis
  Future<DiagnosisResult> analyzeSymptoms(
    List<String> symptoms,
    String? additional,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$analyzeEndpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'symptoms': symptoms,
          'additionalInfo': additional ?? '',
          'userDetails': {},
        }),
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['error'] == false) {
          return DiagnosisResult.fromJson(data['data']);
        } else {
          throw Exception(data['message'] ?? 'Analysis failed');
        }
      } else if (response.statusCode == 400) {
        final data = jsonDecode(response.body);
        throw Exception(data['message'] ?? 'Invalid input');
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error analyzing symptoms: $e');
      // Return mock data as fallback
      return _getMockDiagnosis(symptoms);
    }
  }

  // Get nearby clinics
  Future<List<Clinic>> getNearbyClinics() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl$clinicsEndpoint'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['error'] == false) {
          final List<dynamic> clinicsJson = data['data'];
          return clinicsJson
              .map((clinic) => Clinic.fromJson(clinic))
              .toList();
        }
      }
      return _getMockClinics();
    } catch (e) {
      print('Error fetching clinics: $e');
      return _getMockClinics();
    }
  }

  // Get available symptoms
  Future<List<String>> getAvailableSymptoms() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl$symptomsEndpoint'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['error'] == false) {
          return List<String>.from(data['data']);
        }
      }
      return _getMockSymptoms();
    } catch (e) {
      print('Error fetching symptoms: $e');
      return _getMockSymptoms();
    }
  }

  // Mock data for fallback
  DiagnosisResult _getMockDiagnosis(List<String> symptoms) {
    if (symptoms.contains('Chest Pain') ||
        symptoms.contains('Breathing Difficulty')) {
      return DiagnosisResult(
        conditions: ['Possible Heart Condition', 'Respiratory Issue'],
        confidence: 0.75,
        severity: Severity.severe,
        clinics: _getMockClinics(),
        firstAid: {'Heart Condition': ['Call emergency', 'Rest immediately']},
      );
    } else if (symptoms.contains('Fever') && symptoms.contains('Cough')) {
      return DiagnosisResult(
        conditions: ['Common Cold', 'Flu'],
        confidence: 0.72,
        severity: Severity.moderate,
        clinics: _getMockClinics(),
        firstAid: {
          'Flu': ['Rest', 'Stay hydrated', 'Contact doctor']
        },
      );
    } else {
      return DiagnosisResult(
        conditions: ['Mild Viral Infection'],
        confidence: 0.65,
        severity: Severity.mild,
        clinics: _getMockClinics(),
        firstAid: {
          'Mild Viral Infection': ['Rest', 'Stay hydrated']
        },
=======
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
>>>>>>> vikas
      );
    }
  }

<<<<<<< HEAD
  List<Clinic> _getMockClinics() {
    return [
      Clinic(name: 'City General Hospital', distance: '2.5 km', rating: 4.8),
      Clinic(name: 'Downtown Clinic', distance: '1.8 km', rating: 4.6),
      Clinic(
          name: 'Health First Medical Center', distance: '3.2 km', rating: 4.7),
    ];
  }

  List<String> _getMockSymptoms() {
    return [
      'Fever',
      'Cough',
      'Headache',
      'Chest Pain',
      'Breathing Difficulty',
      'Fatigue',
      'Nausea',
      'Sore Throat',
=======
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
>>>>>>> vikas
    ];
  }
}