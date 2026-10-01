import 'package:flutter/material.dart';

class PatientDirectoryScreen extends StatelessWidget {
  const PatientDirectoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Patient Directory')),
      body: const Center(child: Text('Patient Directory')),
    );
  }
}
