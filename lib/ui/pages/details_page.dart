import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/github_repository.dart';
import '../../blocs/repo_details/repo_details_cubit.dart';
import '../../models/github_repo.dart';
import '../../core/date_format.dart';

class DetailsPage extends StatelessWidget {
  final GithubRepository repository;
  final int repoId;

  const DetailsPage({super.key, required this.repository, required this.repoId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RepoDetailsCubit(repository: repository, repoId: repoId)..load(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Repository Details')),
        body: BlocBuilder<RepoDetailsCubit, GithubRepo?>(
          builder: (context, repo) {
            if (repo == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage(repo.owner.avatarUrl),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(repo.fullName, style: Theme.of(context).textTheme.titleMedium),
                            const SizedBox(height: 4),
                            Text('Owner: ${repo.owner.login}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(repo.description.isEmpty ? 'No description.' : repo.description),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _Chip(label: 'Stars', value: repo.stargazersCount.toString()),
                      if (repo.language.isNotEmpty) _Chip(label: 'Language', value: repo.language),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text('Last updated: ${formatAsMmDdYyyyHhSs(repo.updatedAt)}'),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () async {
                      // Open in browser if desired using url_launcher (optional)
                    },
                    icon: const Icon(Icons.open_in_new),
                    label: const Text('Open on GitHub'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final String value;
  const _Chip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text('$label: $value'),
    );
  }
}
