import 'package:flutter/material.dart';
import 'dart:math';

class TrigonometryPage extends StatelessWidget {
  // List of angles in degrees
  final List<int> angles = [
    0, 30, 45, 60, 90, 120, 135, 150, 180, 210, 225, 240, 270, 300, 315, 330, 360
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          'Trigonometry Values',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildTrigonometryTables(),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to calculate trigonometric values
  Map<String, String> _calculateTrigValues(int angle) {
    double radians = angle * (pi / 180); // Convert degrees to radians
    String tanValue;

    if (angle % 180 == 90) {
      tanValue = '∞'; // Undefined for 90, 270, etc.
    } else {
      tanValue = tan(radians).toStringAsFixed(3);
    }

    return {
      'sin': sin(radians).toStringAsFixed(3),
      'cos': cos(radians).toStringAsFixed(3),
      'tan': tanValue,
    };
  }

  // Build the trigonometry tables in two columns
  Widget _buildTrigonometryTables() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: angles
                .sublist(0, (angles.length / 2).ceil())
                .map((angle) => _buildTrigonometryTable(angle))
                .toList(),
          ),
        ),
        Expanded(
          child: Column(
            children: angles
                .sublist((angles.length / 2).ceil())
                .map((angle) => _buildTrigonometryTable(angle))
                .toList(),
          ),
        ),
      ],
    );
  }

  // Build a single trigonometry table for a given angle
  Widget _buildTrigonometryTable(int angle) {
    Map<String, String> trigValues = _calculateTrigValues(angle);
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Angle: $angle°',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'sin($angle°) = ${trigValues['sin']}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'cos($angle°) = ${trigValues['cos']}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'tan($angle°) = ${trigValues['tan']}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
