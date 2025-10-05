import 'package:equatable/equatable.dart';

abstract class RepoListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RepoListLoad extends RepoListEvent {}

class RepoListRefresh extends RepoListEvent {}
