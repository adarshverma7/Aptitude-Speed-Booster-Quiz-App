import 'package:flutter/material.dart';

class TablesPage extends StatefulWidget {
  @override
  _TablesPageState createState() => _TablesPageState();
}

class _TablesPageState extends State<TablesPage> {
  int selectedRangeStart = 2;
  int selectedRangeEnd = 10;

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
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          'Multiplication Tables',
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
                fillColor: Colors.purple[50], // Light purple background
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              value: ranges.firstWhere(
                    (range) => range['start'] == selectedRangeStart && range['end'] == selectedRangeEnd,
                orElse: () => ranges[0],
              ),
              onChanged: (value) {
                setState(() {
                  selectedRangeStart = value!['start']!;
                  selectedRangeEnd = value['end']!;
                });
              },
              items: ranges.map((range) {
                return DropdownMenuItem<Map<String, int>>(
                  value: range,
                  child: Text('${range['start']} - ${range['end']}', style: TextStyle(fontSize: 18)),
                );
              }).toList(),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: List.generate(selectedRangeEnd - selectedRangeStart + 1, (index) {
                    int number = selectedRangeStart + index;
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      color: Colors.grey[200],
                      child: ExpansionTile(
                        title: Text(
                          'Table of $number',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        ),
                        children: List.generate(10, (index) {
                          int multiplier = index + 1;
                          int result = number * multiplier;
                          return ListTile(
                            title: Text(
                              '$number x $multiplier = $result',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          );
                        }),
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
