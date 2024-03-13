import 'package:equatable/equatable.dart';
import 'package:flutter_git_app/presentation/entities/repository_list/repository_list_ui_entity.dart';

abstract class RepositoryListState extends Equatable {
  final String searchTerm;
  final List<RepositoryListUiEntity> repositoryList;
  final bool isLastPage;

  const RepositoryListState({
    required this.searchTerm,
    required this.repositoryList,
    required this.isLastPage,
  });

  @override
  List<Object?> get props => [
        searchTerm,
        repositoryList,
        isLastPage,
      ];
}

/// INITIAL STATE
class RepositoryListInitialState extends RepositoryListState {
  final String message;
  const RepositoryListInitialState({
    required super.searchTerm,
    required super.repositoryList,
    required super.isLastPage,
    required this.message,
  });

  RepositoryListInitialState.start()
      : this(
          repositoryList: List.empty(),
          searchTerm: "",
          message: "Seems like no search begins yet. Try with new search",
          isLastPage: false,
        );

  @override
  List<Object?> get props => [
        ...super.props,
        message,
      ];
}

/// ON SUCCESS DATA
class RepositoryListLoadedState extends RepositoryListState {
  const RepositoryListLoadedState({
    required super.repositoryList,
    required super.searchTerm,
    required super.isLastPage,
  });
}

/// ON LOADING
class RepositoryListLoadingState extends RepositoryListState {
  const RepositoryListLoadingState({
    required super.repositoryList,
    required super.searchTerm,
    required super.isLastPage,
  });
}

/// ON REQUESTING NEXT PAGE WITH OLD DATA
class RepositoryListLoadingNextPageState extends RepositoryListState {
  const RepositoryListLoadingNextPageState({
    required super.searchTerm,
    required super.repositoryList,
    required super.isLastPage,
  });

  RepositoryListLoadingNextPageState.clone(
    RepositoryListState oldState,
  ) : this(
          repositoryList: oldState.repositoryList,
          searchTerm: oldState.searchTerm,
          isLastPage: oldState.isLastPage,
        );
}

/// ON RELOADING WITH OLD DATA
class RepositoryListReloadingState extends RepositoryListState {
  const RepositoryListReloadingState({
    required super.searchTerm,
    required super.repositoryList,
    required super.isLastPage,
  });

  RepositoryListReloadingState.clone(
    RepositoryListState oldState,
  ) : this(
            repositoryList: oldState.repositoryList,
            searchTerm: oldState.searchTerm,
            isLastPage: oldState.isLastPage);
}

/// ON ERROR STATE
class RepositoryListErrorState extends RepositoryListState {
  final String errorMessage;
  const RepositoryListErrorState({
    required super.searchTerm,
    required super.repositoryList,
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
class RepositoryListEmptyState extends RepositoryListState {
  final String message;
  const RepositoryListEmptyState({
    required super.searchTerm,
    required super.repositoryList,
    required this.message,
    required super.isLastPage,
  });
  @override
  List<Object?> get props => [
        ...super.props,
        message,
      ];

  RepositoryListEmptyState.empty()
      : this(
          repositoryList: List.empty(),
          searchTerm: "",
          message: "No result with this search. Try again with new search",
          isLastPage: false,
        );
}
