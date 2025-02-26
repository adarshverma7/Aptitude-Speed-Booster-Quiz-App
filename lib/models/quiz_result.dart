class QuizResult {
  final String category; // Category of the quiz (e.g., "Squares", "Cubes")
  final int correctAnswers; // Number of correct answers
  final int totalQuestions; // Total number of questions
  final Duration timeTaken; // Time taken to complete the quiz

  QuizResult({
    required this.category,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.timeTaken,
  });

  // Convert a QuizResult object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'correctAnswers': correctAnswers,
      'totalQuestions': totalQuestions,
      'timeTaken': timeTaken.inSeconds,
    };
  }

  // Create a QuizResult object from a JSON map
  factory QuizResult.fromJson(Map<String, dynamic> json) {
    return QuizResult(
      category: json['category'] ?? 'Unknown',
      correctAnswers: json['correctAnswers'] ?? 0,
      totalQuestions: json['totalQuestions'] ?? 0,
      timeTaken: Duration(seconds: json['timeTaken'] ?? 0),
    );
  }
}