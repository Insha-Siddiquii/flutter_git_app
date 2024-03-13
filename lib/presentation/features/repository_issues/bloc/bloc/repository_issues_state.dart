import 'package:equatable/equatable.dart';
import 'package:flutter_git_app/presentation/entities/repository_issue/repository_issue_ui_entity.dart';

abstract class RepositoryIssueListState extends Equatable {
  final List<RepositoryIssueUiEntity> repositoryIssueList;
  final bool isLastPage;

  const RepositoryIssueListState({
    required this.repositoryIssueList,
    required this.isLastPage,
  });

  @override
  List<Object?> get props => [
        repositoryIssueList,
        isLastPage,
      ];
}

/// INITIAL STATE
class RepositoryIssueListInitialState extends RepositoryIssueListState {
  const RepositoryIssueListInitialState({
    required super.repositoryIssueList,
    required super.isLastPage,
  });

  RepositoryIssueListInitialState.start()
      : this(
          repositoryIssueList: List.empty(),
          isLastPage: false,
        );
}

/// ON SUCCESS DATA
class RepositoryIssueListLoadedState extends RepositoryIssueListState {
  const RepositoryIssueListLoadedState({
    required super.repositoryIssueList,
    required super.isLastPage,
  });
}

/// ON LOADING
class RepositoryIssueListLoadingState extends RepositoryIssueListState {
  const RepositoryIssueListLoadingState({
    required super.repositoryIssueList,
    required super.isLastPage,
  });
}

/// ON REQUESTING NEXT PAGE WITH OLD DATA
class RepositoryIssueListLoadingNextPageState extends RepositoryIssueListState {
  const RepositoryIssueListLoadingNextPageState({
    required super.repositoryIssueList,
    required super.isLastPage,
  });

  RepositoryIssueListLoadingNextPageState.clone(
    RepositoryIssueListState oldState,
  ) : this(
          repositoryIssueList: oldState.repositoryIssueList,
          isLastPage: oldState.isLastPage,
        );
}

/// ON RELOADING WITH OLD DATA
class RepositoryIssueListReloadingState extends RepositoryIssueListState {
  const RepositoryIssueListReloadingState({
    required super.repositoryIssueList,
    required super.isLastPage,
  });

  RepositoryIssueListReloadingState.clone(
    RepositoryIssueListState oldState,
  ) : this(
          repositoryIssueList: oldState.repositoryIssueList,
          isLastPage: oldState.isLastPage,
        );
}

/// ON ERROR STATE
class RepositoryIssueListErrorState extends RepositoryIssueListState {
  final String errorMessage;
  const RepositoryIssueListErrorState({
    required super.repositoryIssueList,
    required this.errorMessage,
    required super.isLastPage,
  });
  @override
  List<Object?> get props => [
        ...super.props,
        errorMessage,
      ];
}

/// ON EMPTY STATE
class RepositoryIssueListEmptyState extends RepositoryIssueListState {
  final String message;
  const RepositoryIssueListEmptyState({
    required super.repositoryIssueList,
    required this.message,
    required super.isLastPage,
  });
  @override
  List<Object?> get props => [
        ...super.props,
        message,
      ];

  RepositoryIssueListEmptyState.empty()
      : this(
          repositoryIssueList: List.empty(),
          message: "No open issues for this repository",
          isLastPage: false,
        );
}
