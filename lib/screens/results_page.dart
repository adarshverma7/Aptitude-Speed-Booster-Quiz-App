import 'package:flutter/material.dart';
import '../models/question.dart';
import 'quiz_page.dart';

class ResultsPage extends StatelessWidget {
  final List<Question> questions;
  final List<String?> userSelections;
  final int correctAnswers;
  final List<double> timePerQuestion;

  ResultsPage({
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
        title: Text("Results"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizPage(
                    quizType: "mixed", // Replace with the desired quiz type
                    startRange: 1, // Replace with the desired start range
                    endRange: 10, // Replace with the desired end range
                    numberOfQuestions: 10, // Replace with the desired number of questions
                  ),
                ),
              );
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
      // "Play Again" button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => QuizPage(
                  quizType: "mixed", // Replace with the desired quiz type
                  startRange: 1, // Replace with the desired start range
                  endRange: 10, // Replace with the desired end range
                  numberOfQuestions: 10, // Replace with the desired number of questions
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.purple,
          ),
          child: Text(
            "Play Again",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}