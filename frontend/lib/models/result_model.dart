import 'package:flutter/material.dart';
import 'clinic_model.dart';

enum Severity { mild, moderate, severe }

class DiagnosisResult {
  List<String> conditions;
  Severity severity;
  double confidence;
  List<Clinic>? clinics;
  Map<String, List<String>>? firstAid;

  DiagnosisResult({
    required this.conditions,
    required this.severity,
    this.confidence = 0.5,
    this.clinics,
    this.firstAid,
  });

  factory DiagnosisResult.fromJson(Map<String, dynamic> json) {
    return DiagnosisResult(
      conditions: List<String>.from(json['diagnosis']['conditions'] ?? []),
      confidence: (json['diagnosis']['confidence'] ?? 0.5).toDouble(),
      severity: _parseSeverity(json['diagnosis']['severity'] ?? 'mild'),
      clinics: (json['clinics'] as List?)
          ?.map((clinic) => Clinic.fromJson(clinic))
          .toList(),
      firstAid: Map<String, List<String>>.from(
        (json['firstAid'] as Map?)?.map((key, value) =>
                MapEntry(key, List<String>.from(value))) ??
            {},
      ),
    );
  }

  static Severity _parseSeverity(String severity) {
    switch (severity.toLowerCase()) {
      case 'severe':
        return Severity.severe;
      case 'moderate':
        return Severity.moderate;
      default:
        return Severity.mild;
    }
  }

  Color get color {
    switch (severity) {
      case Severity.mild:
        return Colors.green;
      case Severity.moderate:
        return Colors.orange;
      case Severity.severe:
        return Colors.red;
    }
  }

  String get severityText {
    switch (severity) {
      case Severity.mild:
        return 'Mild';
      case Severity.moderate:
        return 'Moderate';
      case Severity.severe:
        return 'Severe';
    }
  }
}