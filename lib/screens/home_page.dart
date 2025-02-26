import 'package:flutter/material.dart';
import '../widgets/category_card.dart';
import '../widgets/custom_app_bar.dart';
import 'quiz_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[200],
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ADVANCE Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0), // Fixed syntax
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), // Fixed syntax
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '|  ',
                        style: TextStyle(
                          color: Colors.purple,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'ADVANCE',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0), // Fixed syntax
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1.2,
                children: [
                  CategoryCard(
                    title: 'Square (²)',
                    icon: Icons.exposure,
                    onTap: () => _showRangeSelectionDialog(context, "square"),
                  ),
                  CategoryCard(
                    title: 'Cube (³)',
                    icon: Icons.all_inclusive,
                    onTap: () => _showRangeSelectionDialog(context, "cube"),
                  ),
                  CategoryCard(
                    title: 'Square Root (√)',
                    icon: Icons.filter_2,
                    onTap: () => _showRangeSelectionDialog(context, "square_root"),
                  ),
                  CategoryCard(
                    title: 'Cube Root (∛)',
                    icon: Icons.filter_3,
                    onTap: () => _showRangeSelectionDialog(context, "cube_root"),
                  ),
                  CategoryCard(
                    title: 'Table (×)',
                    icon: Icons.table_chart,
                    onTap: () => _showRangeSelectionDialog(context, "table"),
                  ),
                  CategoryCard(
                    title: 'Cryptogram (🔒)',
                    icon: Icons.lock,
                    onTap: () => _showRangeSelectionDialog(context, "cryptogram"),
                  ),
                  CategoryCard(
                    title: 'Trigonometry (sin, cos)',
                    icon: Icons.functions,
                    onTap: () => _showRangeSelectionDialog(context, "trigonometry"),
                  ),
                  CategoryCard(
                    title: 'Mixed Questions (∞)',
                    icon: Icons.shuffle,
                    onTap: () => _showRangeSelectionDialog(context, "mixed"),
                  ),
                ],
              ),
            ),

            // BASIC Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0), // Fixed syntax
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), // Fixed syntax
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '|  ',
                        style: TextStyle(
                          color: Colors.purple,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'BASIC',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0), // Fixed syntax
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1.2,
                children: [
                  CategoryCard(
                    title: 'Addition (+)',
                    icon: Icons.add,
                    onTap: () => _showRangeSelectionDialog(context, "addition"),
                  ),
                  CategoryCard(
                    title: 'Subtraction (−)',
                    icon: Icons.remove,
                    onTap: () => _showRangeSelectionDialog(context, "subtraction"),
                  ),
                  CategoryCard(
                    title: 'Multiplication (×)',
                    icon: Icons.clear,
                    onTap: () => _showRangeSelectionDialog(context, "multiplication"),
                  ),
                  CategoryCard(
                    title: 'Division (÷)',
                    icon: Icons.more_horiz,
                    onTap: () => _showRangeSelectionDialog(context, "division"),
                  ),
                  CategoryCard(
                    title: 'Percentage (%)',
                    icon: Icons.percent,
                    onTap: () => _showRangeSelectionDialog(context, "percentage"),
                  ),
                  CategoryCard(
                    title: 'Complexity (±)',
                    icon: Icons.calculate,
                    onTap: () => _showRangeSelectionDialog(context, "complexity"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRangeSelectionDialog(BuildContext context, String category) {
    int startRange = 5; // Default start range
    int endRange = 20; // Default end range
    int numberOfQuestions = 10; // Default number of questions

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Customize Quiz"),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Range Selection for Numeric Categories
                  if (category == "square" ||
                      category == "cube" ||
                      category == "square_root" ||
                      category == "cube_root" ||
                      category == "table" ||
                      category == "addition" ||
                      category == "subtraction" ||
                      category == "multiplication" ||
                      category == "division" ||
                      category == "percentage" ||
                      category == "complexity")
                    Column(
                      children: [
                        Text("Select Range:"),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Start",
                                  hintText: "5", // Default hint
                                ),
                                keyboardType: TextInputType.number,
                                initialValue: startRange.toString(), // Default value
                                onChanged: (value) {
                                  setState(() {
                                    startRange = int.tryParse(value) ?? 5; // Fallback to 5 if invalid
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: "End",
                                  hintText: "20", // Default hint
                                ),
                                keyboardType: TextInputType.number,
                                initialValue: endRange.toString(), // Default value
                                onChanged: (value) {
                                  setState(() {
                                    endRange = int.tryParse(value) ?? 20; // Fallback to 20 if invalid
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                  // Range Selection for Non-Numeric Categories
                  if (category == "cryptogram" || category == "trigonometry" || category == "mixed")
                    Text("Range: Not Applicable"),

                  SizedBox(height: 20),
                  Text("Number of Questions:"),
                  Slider(
                    value: numberOfQuestions.toDouble(),
                    min: 5,
                    max: 50,
                    divisions: 9,
                    label: numberOfQuestions.toString(),
                    onChanged: (value) {
                      setState(() {
                        numberOfQuestions = value.toInt();
                      });
                    },
                  ),
                  Text("Selected: $numberOfQuestions"),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _startQuiz(context, category, startRange, endRange, numberOfQuestions);
              },
              child: Text("Start"),
            ),
          ],
        );
      },
    );
  }

  void _startQuiz(BuildContext context, String category, int startRange, int endRange, int numberOfQuestions) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizPage(
          quizType: category,
          startRange: startRange,
          endRange: endRange,
          numberOfQuestions: numberOfQuestions,
        ),
      ),
    );
  }
}