import 'package:flutter/material.dart';

class CubesPage extends StatefulWidget {
  @override
  _CubesPageState createState() => _CubesPageState();
}

class _CubesPageState extends State<CubesPage> {
  int _start = 2;
  int _end = 10;

  final List<Map<String, int>> ranges = [
    {'start': 2, 'end': 10},
    {'start': 11, 'end': 20},
    {'start': 21, 'end': 30},
    {'start': 31, 'end': 40},
    {'start': 41, 'end': 50},
    {'start': 51, 'end': 60},
    {'start': 61, 'end': 70},
    {'start': 71, 'end': 80},
    {'start': 81, 'end': 90},
    {'start': 91, 'end': 100},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          'Cubes Table',
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField<Map<String, int>>(
              decoration: InputDecoration(
                labelText: 'Select Range',
                filled: true,
                fillColor: Colors.purple[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              value: ranges[0],
              onChanged: (value) {
                setState(() {
                  _start = value!['start']!;
                  _end = value['end']!;
                });
              },
              items: ranges.map((range) {
                return DropdownMenuItem<Map<String, int>>(
                  value: range,
                  child: Text('${range['start']} - ${range['end']}'),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: List.generate(_end - _start + 1, (index) {
                    int number = _start + index;
                    int cube = number * number * number;
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      color: Colors.grey[200],
                      child: ListTile(
                        title: Text(
                          '$number³ = $cube',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
