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
      );
    }
  }

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
    ];
  }
}