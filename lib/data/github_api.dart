import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/github_repo.dart';

class GithubApi {
  static const String _base = 'https://api.github.com';

  Future<List<GithubRepo>> searchAndroidRepos({int page = 1, int perPage = 30}) async {
    final uri = Uri.parse('$_base/search/repositories?q=Android&sort=stars&order=desc&page=$page&per_page=$perPage');
    final res = await http.get(uri, headers: {
      'Accept': 'application/vnd.github+json',
    });

    if (res.statusCode != 200) {
      throw Exception('GitHub error: ${res.statusCode} ${res.reasonPhrase}');
    }

    final jsonBody = json.decode(res.body) as Map<String, dynamic>;
    final items = (jsonBody['items'] as List<dynamic>? ?? [])
        .cast<Map<String, dynamic>>()
        .map(GithubRepo.fromJson)
        .toList();
    return items;
  }
}
