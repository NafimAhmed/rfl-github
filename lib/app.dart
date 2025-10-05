import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/repo_list/repo_list_event.dart';
import 'core/app_router.dart';
import 'data/github_api.dart';
import 'data/local_db.dart';
import 'repository/github_repository.dart';
import 'blocs/repo_list/repo_list_bloc.dart';

class PopularGitReposApp extends StatelessWidget {
  const PopularGitReposApp({super.key});

  @override
  Widget build(BuildContext context) {
    final api = GithubApi();
    final db = LocalDb.instance;
    final repository = GithubRepository(api: api, db: db);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => RepoListBloc(repository: repository)..add(RepoListLoad()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Popular GitRepos',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blue,
        ),
        routerConfig: buildRouter(repository),
      ),
    );
  }
}
