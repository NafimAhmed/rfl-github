import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/github_repository.dart';
import '../../models/github_repo.dart';
import 'repo_list_event.dart';
import 'repo_list_state.dart';

class RepoListBloc extends Bloc<RepoListEvent, RepoListState> {
  final GithubRepository repository;

  RepoListBloc({required this.repository}) : super(RepoListInitial()) {
    on<RepoListLoad>((event, emit) async {
      emit(RepoListLoading());
      try {
        final List<GithubRepo> data = await repository.getRepos();
        emit(RepoListLoaded(data));
      } catch (e) {
        emit(RepoListError(e.toString()));
      }
    });

    on<RepoListRefresh>((event, emit) async {
      try {
        final List<GithubRepo> data = await repository.getRepos(forceRefresh: true);
        emit(RepoListLoaded(data));
      } catch (e) {
        emit(RepoListError(e.toString()));
      }
    });
  }
}
