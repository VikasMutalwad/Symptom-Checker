import 'package:flutter/material.dart';

class Symptom {
  String name;
  IconData icon;
  bool isSelected;

  Symptom({required this.name, required this.icon, this.isSelected = false});
}

class SymptomData {
  List<Symptom> symptoms;
  String? additionalSymptoms;

  SymptomData({required this.symptoms, this.additionalSymptoms});

  List<String> get selectedSymptoms =>
      symptoms.where((s) => s.isSelected).map((s) => s.name).toList();
}