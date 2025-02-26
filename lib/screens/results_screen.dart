import 'package:flutter/material.dart';
import '../models/question.dart';

class ResultsScreen extends StatelessWidget {
  final List<Question> questions;
  final List<String?> userSelections;
  final int correctAnswers;
  final List<double> timePerQuestion;

  ResultsScreen({
    required this.questions,
    required this.userSelections,
    required this.correctAnswers,
    required this.timePerQuestion,
  });

  double get accuracy => (correctAnswers / questions.length) * 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz Results"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Summary Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "Accuracy: ${accuracy.toStringAsFixed(2)}%",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  "Score: $correctAnswers/${questions.length}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // Detailed Results List
          Expanded(
            child: ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final question = questions[index];
                final userAnswer = userSelections[index];
                final isCorrect = userAnswer == question.answer;
                final timeTaken = timePerQuestion[index];

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(question.text),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Your answer: $userAnswer"),
                        Text("Correct answer: ${question.answer}"),
                        Text("Time taken: ${timeTaken.toStringAsFixed(2)}s"),
                      ],
                    ),
                    trailing: Icon(
                      isCorrect ? Icons.check : Icons.close,
                      color: isCorrect ? Colors.green : Colors.red,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}