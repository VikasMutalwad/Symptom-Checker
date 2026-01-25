import 'package:flutter/material.dart';
import 'package:symptom_checker/models/symptom_model.dart';

class SymptomCheckbox extends StatelessWidget {
  final Symptom symptom;
  final ValueChanged<bool?> onChanged;

  const SymptomCheckbox({
    super.key,
    required this.symptom,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        symptom.name,
        style: const TextStyle(fontSize: 16),
      ),
      value: symptom.isSelected,
      onChanged: onChanged,
      activeColor: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}