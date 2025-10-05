import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/github_repository.dart';
import '../../models/github_repo.dart';

class RepoDetailsCubit extends Cubit<GithubRepo?> {
  final GithubRepository repository;
  final int repoId;

  RepoDetailsCubit({required this.repository, required this.repoId}) : super(null);

  Future<void> load() async {
    final repo = await repository.getRepoById(repoId);
    emit(repo);
  }
}
