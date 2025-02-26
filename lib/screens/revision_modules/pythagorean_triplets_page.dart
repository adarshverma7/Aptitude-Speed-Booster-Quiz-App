import 'package:flutter/material.dart';

class PythagoreanTripletsPage extends StatelessWidget {
  // Predefined list of Pythagorean triplets
  final List<List<int>> triplets = [
    [3, 4, 5],
    [5, 12, 13],
    [7, 24, 25],
    [8, 15, 17],
    [9, 40, 41],
    [11, 60, 61],
    [12, 35, 37],
    [13, 84, 85],
    [16, 63, 65],
    [20, 21, 29],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          'Pythagorean Triplets',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 16.0), // Add top and bottom padding
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(), // Disable GridView's scrolling
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2, // Responsive columns
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemCount: triplets.length,
              itemBuilder: (context, index) {
                return _buildTripletCard(triplets[index]);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTripletCard(List<int> triplet) {
    return Card(
      elevation: 4, // Add shadow for better visual appeal
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Add interactivity (e.g., show a dialog or navigate to a details page)
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${triplet[0]}² + ${triplet[1]}² = ${triplet[2]}²',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'i.e. :  ${triplet[0]}, ${triplet[1]}, ${triplet[2]}',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}