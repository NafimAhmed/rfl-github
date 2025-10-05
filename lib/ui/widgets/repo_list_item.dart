import 'package:flutter/material.dart';
import '../../models/github_repo.dart';

class RepoListItem extends StatelessWidget {
  final GithubRepo repo;
  final VoidCallback? onTap;
  const RepoListItem({super.key, required this.repo, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(backgroundImage: NetworkImage(repo.owner.avatarUrl)),
      title: Text(repo.name),
      subtitle: Text('${repo.owner.login} • ★ ${repo.stargazersCount}'),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
