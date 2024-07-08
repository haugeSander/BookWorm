import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    List<Step> allSteps = _getSteps();
    return Scaffold(
        body: Stepper(
      type: StepperType.horizontal,
      steps: allSteps,
      currentStep: currentStep,
      onStepContinue: () {
        if (currentStep == (allSteps.length - 1)) {
          Navigator.pop(context);
        } else {
          setState(() => currentStep++);
        }
      },
      onStepCancel: () {
        if (currentStep == 0) {
          Navigator.pop(context);
        } else {
          setState(() => currentStep--);
        }
      },
    ));
  }

  List<Step> _getSteps() => [
        Step(
            isActive: currentStep >= 0,
            title: const Text("First step"),
            content: Container()),
        Step(
            isActive: currentStep >= 1,
            title: const Text("Second step"),
            content: Container()),
        Step(
            isActive: currentStep >= 2,
            title: const Text("Third step"),
            content: Container()),
        Step(
            isActive: currentStep >= 3,
            title: const Text("Finished"),
            content: Container())
      ];
}
