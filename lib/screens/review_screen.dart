import 'package:flutter/material.dart';
import '../models/question.dart';

class ReviewScreen extends StatelessWidget {
  final List<Question> questions;
  final List<String?> userSelections;

  ReviewScreen({
    required this.questions,
    required this.userSelections,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz Review"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions[index];
          final userSelection = userSelections[index];
          final isCorrect = userSelection == question.answer;

          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question.text,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Your Answer: ${userSelection ?? "Not answered"}",
                    style: TextStyle(
                      color: isCorrect ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (!isCorrect)
                    Text(
                      "Correct Answer: ${question.answer}",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}