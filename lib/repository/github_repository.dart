import 'package:sqflite/sqflite.dart';
import '../data/github_api.dart';
import '../data/local_db.dart';
import '../models/github_repo.dart';

class GithubRepository {
  final GithubApi api;
  final LocalDb db;

  GithubRepository({required this.api, required this.db});

  Future<List<GithubRepo>> getRepos({bool forceRefresh = false}) async {
    final database = await db.database;

    Future<List<GithubRepo>> loadFromDb() async {
      final rows = await database.query('repos', orderBy: 'stargazers_count DESC');
      return rows.map(GithubRepo.fromMap).toList();
    }

    if (!forceRefresh) {
      final cached = await loadFromDb();
      if (cached.isNotEmpty) {
        // Try background refresh but return cache immediately
        try {
          final remote = await api.searchAndroidRepos();
          await _replaceRepos(database, remote);
        } catch (_) {}
        return cached;
      }
    }

    // Fetch from network then cache
    final remote = await api.searchAndroidRepos();
    await _replaceRepos(database, remote);
    return await loadFromDb();
  }

  Future<GithubRepo?> getRepoById(int id) async {
    final database = await db.database;
    final rows = await database.query('repos', where: 'id = ?', whereArgs: [id], limit: 1);
    if (rows.isEmpty) return null;
    return GithubRepo.fromMap(rows.first);
  }

  Future<void> _replaceRepos(Database database, List<GithubRepo> repos) async {
    final batch = database.batch();
    batch.delete('repos'); // Replace for simplicity
    for (final r in repos) {
      batch.insert('repos', r.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }
}
