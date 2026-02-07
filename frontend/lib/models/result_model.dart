import 'package:flutter/material.dart';

enum Severity { mild, moderate, severe }

class Condition {
  final String name;
  final double probability;
  final Severity severity;
  final String description;

  const Condition({
    required this.name,
    required this.probability,
    required this.severity,
    required this.description,
  });

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

class DiagnosisResult {
  final List<Condition> conditions;
  final List<String> recommendations;
  final bool urgentCare;

  const DiagnosisResult({
    required this.conditions,
    required this.recommendations,
    required this.urgentCare,
  });

  Severity get overallSeverity {
    if (conditions.any((c) => c.severity == Severity.severe)) {
      return Severity.severe;
    } else if (conditions.any((c) => c.severity == Severity.moderate)) {
      return Severity.moderate;
    }
    return Severity.mild;
  }
}