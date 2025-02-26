import 'package:flutter/material.dart';

class AlphabetsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          'Alphabets with Numbers',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: List.generate(13, (index) {
              // A-M
              String alphabet1 = String.fromCharCode(65 + index); // A to M
              int number1 = index + 1; // 1 to 13
              // Z-N
              String alphabet2 = String.fromCharCode(90 - index); // Z to N
              int number2 = 26 - index; // 26 to 14

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8),
                color: index % 2 == 0 ? Colors.white : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // First Column (A-M)
                      Text(
                        alphabet1,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                      // Second Column (1-13)
                      Text(
                        number1.toString(),
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Third Column (Z-N)
                      Text(
                        alphabet2,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                      // Fourth Column (26-14)
                      Text(
                        number2.toString(),
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
