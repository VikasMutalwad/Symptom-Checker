import 'package:flutter/material.dart';
import 'package:symptom_checker/models/user_model.dart';
import 'package:symptom_checker/models/symptom_model.dart';
import 'loading_screen.dart';

class SymptomInputScreen extends StatefulWidget {
  final User user;

  const SymptomInputScreen({super.key, required this.user});

  @override
  State<SymptomInputScreen> createState() => _SymptomInputScreenState();
}

class _SymptomInputScreenState extends State<SymptomInputScreen> {
  late List<Symptom> symptoms;
  final _additionalController = TextEditingController();
  bool _isAnalyzing = false;

  @override
  void initState() {
    super.initState();
    symptoms = [
      Symptom(name: 'Fever', icon: Icons.thermostat_outlined),
      Symptom(name: 'Cough', icon: Icons.sick_outlined),
      Symptom(name: 'Headache', icon: Icons.sick_outlined),
      Symptom(name: 'Chest Pain', icon: Icons.monitor_heart_outlined),
      Symptom(name: 'Breathing Difficulty', icon: Icons.air_outlined),
      Symptom(name: 'Fatigue', icon: Icons.battery_2_bar_outlined),
      Symptom(name: 'Nausea', icon: Icons.sick),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final selectedSymptoms = symptoms.where((s) => s.isSelected).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Symptoms'),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select all symptoms you are experiencing',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Tap to select or deselect symptoms',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white70,
                    ),
              ),
              const SizedBox(height: 24),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                itemCount: symptoms.length,
                itemBuilder: (context, index) {
                  return SymptomCard(
                    symptom: symptoms[index],
                    onTap: () {
                      setState(() {
                        symptoms[index].isSelected = !symptoms[index].isSelected;
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: _additionalController,
                    decoration: const InputDecoration(
                      labelText: 'Other symptoms (optional)',
                      hintText: 'Describe any additional symptoms...',
                      border: InputBorder.none,
                    ),
                    maxLines: 3,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedSymptoms.isEmpty || _isAnalyzing
                      ? null
                      : () async {
                          setState(() => _isAnalyzing = true);
                          final symptomData = SymptomData(
                            symptoms: selectedSymptoms,
                            additionalSymptoms: _additionalController.text.isEmpty
                                ? null
                                : _additionalController.text,
                          );
                          await Future.delayed(const Duration(milliseconds: 500));
                          if (mounted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoadingScreen(
                                  user: widget.user,
                                  symptomData: symptomData,
                                ),
                              ),
                            );
                          }
                        },
                  child: _isAnalyzing
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text('Analyze Symptoms (${selectedSymptoms.length})'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _additionalController.dispose();
    super.dispose();
  }
}

class SymptomCard extends StatefulWidget {
  final Symptom symptom;
  final VoidCallback onTap;

  const SymptomCard({
    super.key,
    required this.symptom,
    required this.onTap,
  });

  @override
  State<SymptomCard> createState() => _SymptomCardState();
}

class _SymptomCardState extends State<SymptomCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Card(
            color: widget.symptom.isSelected
                ? Theme.of(context).primaryColor.withOpacity(0.2)
                : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: widget.symptom.isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
                width: 2,
              ),
            ),
            child: InkWell(
              onTap: () {
                _animationController.forward().then((_) {
                  _animationController.reverse();
                });
                widget.onTap();
              },
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      widget.symptom.icon,
                      size: 32,
                      color: widget.symptom.isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.white70,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.symptom.name,
                      style: TextStyle(
                        color: widget.symptom.isSelected
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        fontWeight: widget.symptom.isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}