import 'package:equatable/equatable.dart';

class Owner extends Equatable {
  final String login;
  final String avatarUrl;

  const Owner({required this.login, required this.avatarUrl});

  factory Owner.fromJson(Map<String, dynamic> json) =>
      Owner(login: json['login'] ?? '', avatarUrl: json['avatar_url'] ?? '');

  Map<String, dynamic> toMap() => {
        'login': login,
        'avatar_url': avatarUrl,
      };

  @override
  List<Object?> get props => [login, avatarUrl];
}

class GithubRepo extends Equatable {
  final int id;
  final String name;
  final String fullName;
  final Owner owner;
  final String description;
  final int stargazersCount;
  final String language;
  final String htmlUrl;
  final DateTime updatedAt;

  const GithubRepo({
    required this.id,
    required this.name,
    required this.fullName,
    required this.owner,
    required this.description,
    required this.stargazersCount,
    required this.language,
    required this.htmlUrl,
    required this.updatedAt,
  });

  factory GithubRepo.fromJson(Map<String, dynamic> json) => GithubRepo(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        fullName: json['full_name'] ?? '',
        owner: Owner.fromJson(json['owner'] ?? {}),
        description: json['description'] ?? '',
        stargazersCount: json['stargazers_count'] ?? 0,
        language: json['language']?.toString() ?? '',
        htmlUrl: json['html_url'] ?? '',
        updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.fromMillisecondsSinceEpoch(0),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'full_name': fullName,
        'owner_login': owner.login,
        'owner_avatar_url': owner.avatarUrl,
        'description': description,
        'stargazers_count': stargazersCount,
        'language': language,
        'html_url': htmlUrl,
        'updated_at': updatedAt.toIso8601String(),
      };

  static GithubRepo fromMap(Map<String, dynamic> m) => GithubRepo(
        id: m['id'] as int,
        name: m['name'] as String,
        fullName: m['full_name'] as String,
        owner: Owner(login: m['owner_login'] as String, avatarUrl: m['owner_avatar_url'] as String),
        description: m['description'] as String? ?? '',
        stargazersCount: m['stargazers_count'] as int? ?? 0,
        language: m['language'] as String? ?? '',
        htmlUrl: m['html_url'] as String? ?? '',
        updatedAt: DateTime.tryParse(m['updated_at'] as String? ?? '') ?? DateTime.fromMillisecondsSinceEpoch(0),
      );

  @override
  List<Object?> get props => [id, name, fullName, owner, description, stargazersCount, language, htmlUrl, updatedAt];
}
