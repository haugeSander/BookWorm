// ignore_for_file: sort_child_properties_last

import 'package:book_worm/models/user.dart';
import 'package:book_worm/services/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditGoals extends StatefulWidget {
  const EditGoals({super.key});

  @override
  _EditGoalsState createState() => _EditGoalsState();
}

class _EditGoalsState extends State<EditGoals> {
  final _formKey = GlobalKey<FormState>();
  final IsarService _isarService = IsarService();
  User? user;
  int readingGoal = 0;
  DateTime? readingGoalTime;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    user = await _isarService.getUser().then((future) => future);
    if (user != null) {
      readingGoal = user!.readingGoal;
      readingGoalTime = user!.achieveBy;
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _saveGoal() async {
    if (_formKey.currentState!.validate()) {
      User? updatedUser = user;

      if (updatedUser != null) {
        updatedUser.achieveBy = readingGoalTime!;
        updatedUser.readingGoal = readingGoal;
        await _isarService.updateUser(updatedUser);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Goals'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reading Goal',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () {
                              setState(() {
                                if (readingGoal > 0) readingGoal--;
                              });
                            },
                          ),
                          const SizedBox(width: 16),
                          Text(
                            '$readingGoal',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(width: 16),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () {
                              setState(() {
                                readingGoal++;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Books to read',
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Achieve By',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: readingGoalTime ?? DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 3650)),
                          );
                          if (picked != null && picked != readingGoalTime) {
                            setState(() {
                              readingGoalTime = picked;
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                readingGoalTime != null
                                    ? DateFormat('MMMM dd, yyyy')
                                        .format(readingGoalTime!)
                                    : 'Select a date',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const Icon(Icons.calendar_today),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveGoal,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Text('Save Changes', style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
