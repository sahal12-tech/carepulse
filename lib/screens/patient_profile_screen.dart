import 'package:flutter/material.dart';

class PatientProfileScreen extends StatelessWidget {
  final String patientId;

  const PatientProfileScreen({super.key, required this.patientId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Patient Profile: $patientId')),
      body: Center(child: Text('Patient Profile for $patientId')),
    );
  }
}
