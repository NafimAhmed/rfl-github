import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class LocalDb {
  LocalDb._();
  static final LocalDb instance = LocalDb._();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'popular_gitrepos.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
CREATE TABLE repos (
  id INTEGER PRIMARY KEY,
  name TEXT,
  full_name TEXT,
  owner_login TEXT,
  owner_avatar_url TEXT,
  description TEXT,
  stargazers_count INTEGER,
  language TEXT,
  html_url TEXT,
  updated_at TEXT
);
''');
      },
    );
    return _db!;
  }
}
