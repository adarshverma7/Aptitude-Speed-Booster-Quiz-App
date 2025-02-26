import 'package:shared_preferences/shared_preferences.dart';
import '../models/quiz_result.dart';

class StorageUtils {
  // Key prefix for high scores
  static const String _highScoreKeyPrefix = "highScore_";

  /// Saves the high score for a specific quiz type.
  /// Only updates the high score if the new score is greater than the current high score.
  static Future<void> saveHighScore(String quizType, int score) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String key = _getHighScoreKey(quizType);
      final int currentHighScore = prefs.getInt(key) ?? 0;

      if (score > currentHighScore) {
        await prefs.setInt(key, score);
      }
    } catch (e) {
      // Handle any errors that occur during the save operation
      print("Error saving high score: $e");
    }
  }

  /// Retrieves the high score for a specific quiz type.
  /// Returns 0 if no high score is found.
  static Future<int> getHighScore(String quizType) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String key = _getHighScoreKey(quizType);
      return prefs.getInt(key) ?? 0;
    } catch (e) {
      // Handle any errors that occur during the retrieval operation
      print("Error retrieving high score: $e");
      return 0;
    }
  }

  /// Generates the key for storing high scores based on the quiz type.
  static String _getHighScoreKey(String quizType) {
    return "$_highScoreKeyPrefix$quizType";
  }
}