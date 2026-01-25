import 'package:flutter/material.dart';

enum Severity { mild, moderate, severe }

class DiagnosisResult {
  List<String> conditions;
  Severity severity;

  DiagnosisResult({required this.conditions, required this.severity});

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