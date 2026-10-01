import 'package:flutter/material.dart';

class EmergencyEntryScreen extends StatelessWidget {
  const EmergencyEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Emergency Entry')),
      body: const Center(child: Text('Emergency Entry')),
    );
  }
}
