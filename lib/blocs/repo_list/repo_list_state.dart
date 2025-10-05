import 'package:equatable/equatable.dart';
import '../../models/github_repo.dart';

abstract class RepoListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RepoListInitial extends RepoListState {}

class RepoListLoading extends RepoListState {}

class RepoListLoaded extends RepoListState {
  final List<GithubRepo> repos;
  RepoListLoaded(this.repos);

  @override
  List<Object?> get props => [repos];
}

class RepoListError extends RepoListState {
  final String message;
  RepoListError(this.message);

  @override
  List<Object?> get props => [message];
}
