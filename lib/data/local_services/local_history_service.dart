import 'dart:convert';

import 'package:movies/data/models/watch_list_response/favourite_movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalHistoryService {
  static String _buildKey(String userId) => 'movie_history_$userId';

  static Future<void> saveVisitedMovie(FavouriteMovie movie, String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _buildKey(userId);
    final historyList = await getHistory(userId);

    // Remove if already exists
    historyList.removeWhere((m) => m.movieId == movie.movieId);

    // Insert on top
    historyList.insert(0, movie);

    // Limit to 10
    final trimmed = historyList.take(10).toList();

    final encoded = trimmed.map((m) => jsonEncode(m.toJson())).toList();
    await prefs.setStringList(key, encoded);
  }

  static Future<List<FavouriteMovie>> getHistory(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _buildKey(userId);
    final data = prefs.getStringList(key) ?? [];

    return data
        .map((jsonStr) => FavouriteMovie.fromJson(jsonDecode(jsonStr)))
        .toList();
  }
}
