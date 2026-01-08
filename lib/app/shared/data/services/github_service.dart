import 'dart:convert';
import 'package:http/http.dart' as http;

/// Service for fetching GitHub repository information.
class GitHubService {
  static const String _baseUrl = 'https://api.github.com/repos';

  /// Fetches the star count for a GitHub repository.
  ///
  /// [owner] - The repository owner (e.g., 'yunweneric')
  /// [repo] - The repository name (e.g., 'flutter-widgethub')
  ///
  /// Returns the number of stars, or null if the request fails.
  static Future<int?> getStarCount(String owner, String repo) async {
    try {
      final url = Uri.parse('$_baseUrl/$owner/$repo');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        return data['stargazers_count'] as int?;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
