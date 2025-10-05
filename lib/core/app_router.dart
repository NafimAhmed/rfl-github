import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../repository/github_repository.dart';
import '../ui/pages/home_page.dart';
import '../ui/pages/details_page.dart';

GoRouter buildRouter(GithubRepository repository) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomePage(repository: repository),
        routes: [
          GoRoute(
            path: 'repo/:id',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return DetailsPage(repository: repository, repoId: id);
            },
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text(state.error.toString())),
    ),
  );
}
