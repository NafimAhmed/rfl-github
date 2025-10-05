import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../repository/github_repository.dart';
import '../../blocs/repo_list/repo_list_bloc.dart';
import '../../blocs/repo_list/repo_list_event.dart';
import '../../blocs/repo_list/repo_list_state.dart';
import '../widgets/repo_list_item.dart';

class HomePage extends StatelessWidget {
  final GithubRepository repository;
  const HomePage({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular GitRepos'),
        actions: [
          IconButton(
            onPressed: () => context.read<RepoListBloc>().add(RepoListRefresh()),
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          )
        ],
      ),
      body: BlocBuilder<RepoListBloc, RepoListState>(
        builder: (context, state) {
          if (state is RepoListLoading || state is RepoListInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RepoListError) {
            return Center(
              child: Text(state.message, textAlign: TextAlign.center),
            );
          } else if (state is RepoListLoaded) {
            final repos = state.repos;
            if (repos.isEmpty) {
              return const Center(child: Text('No data available.'));
            }
            return ListView.separated(
              itemCount: repos.length,
              separatorBuilder: (_, __) => const Divider(height: 0),
              itemBuilder: (context, index) {
                final repo = repos[index];
                return RepoListItem(
                  repo: repo,
                  onTap: () => context.push('/repo/${repo.id}'),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
