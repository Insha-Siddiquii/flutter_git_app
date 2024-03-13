import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_git_app/domain/usecases/repository_list_usecase/fetch_repository_list_usecase.dart';
import 'package:flutter_git_app/presentation/entities/repository_list/repository_list_ui_entity.dart';
import 'package:flutter_git_app/presentation/features/repository_list/bloc/repository_list_bloc_event.dart';
import 'package:flutter_git_app/presentation/features/repository_list/bloc/repository_list_bloc_state.dart';

class RepositoryListBloc
    extends Bloc<RepositoryListEvent, RepositoryListState> {
  final FetchRepositoryListUseCase useCase;
  RepositoryListBloc({
    required this.useCase,
  }) : super(
          RepositoryListInitialState.start(),
        ) {
    on<GetRepositoryListEvent>(_fetchRepositoryList);

    on<GetRepositoryListNextPageEvent>(_getRepositoryListNextPage);

    on<ReloadRepositoryListEvent>(_reloadRepositoryList);
  }

  void _fetchRepositoryList(
    GetRepositoryListEvent event,
    Emitter<RepositoryListState> emit,
  ) async {
    final oldState = state;

    emit(RepositoryListLoadingState(
      repositoryList: oldState.repositoryList,
      searchTerm: event.searchTerm,
      isLastPage: oldState.isLastPage,
    ));

    final data = await useCase.call(
      repositoryName: event.searchTerm,
      isNewSearch: true,
    );

    data.fold(
      (itemEntity) {
        if (itemEntity.isEmpty) {
          emit(RepositoryListEmptyState.empty());
          return;
        }

        final itemUiEntity = itemEntity
            .map((e) => RepositoryListUiEntity(
                  id: e.id,
                  name: e.name,
                  ownerName: e.ownerName,
                  description: e.description,
                  language: e.language,
                  openIssuesCount: e.openIssuesCount,
                ))
            .toList();

        emit(RepositoryListLoadedState(
          repositoryList: itemUiEntity,
          searchTerm: event.searchTerm,
          isLastPage: oldState.isLastPage,
        ));
      },
      (exception) => emit(
        RepositoryListErrorState(
          repositoryList: oldState.repositoryList,
          searchTerm: event.searchTerm,
          errorMessage: "Something went wrong. Please try again",
          isLastPage: oldState.isLastPage,
        ),
      ),
    );
  }

  void _getRepositoryListNextPage(
    GetRepositoryListNextPageEvent event,
    Emitter<RepositoryListState> emit,
  ) async {
    final oldState = state;

    emit(RepositoryListLoadingNextPageState(
      repositoryList: oldState.repositoryList,
      searchTerm: oldState.searchTerm,
      isLastPage: oldState.isLastPage,
    ));

    final data = await useCase.call(
      repositoryName: event.searchTerm,
    );

    data.fold(
      (itemEntity) {
        final itemUiEntity = itemEntity
            .map((e) => RepositoryListUiEntity(
                  id: e.id,
                  name: e.name,
                  ownerName: e.ownerName,
                  description: e.description,
                  language: e.language,
                  openIssuesCount: e.openIssuesCount,
                ))
            .toList();

        emit(RepositoryListLoadedState(
          repositoryList: [...oldState.repositoryList, ...itemUiEntity],
          searchTerm: event.searchTerm,
          isLastPage: itemUiEntity.isNotEmpty ? false : true,
        ));
      },
      (exception) => emit(
        RepositoryListErrorState(
          repositoryList: oldState.repositoryList,
          searchTerm: event.searchTerm,
          errorMessage: "Something went wrong. Please try again",
          isLastPage: oldState.isLastPage,
        ),
      ),
    );
  }

  void _reloadRepositoryList(
    ReloadRepositoryListEvent event,
    Emitter<RepositoryListState> emit,
  ) async {
    final oldState = state;

    emit(RepositoryListReloadingState(
      repositoryList: oldState.repositoryList,
      searchTerm: event.searchTerm,
      isLastPage: oldState.isLastPage,
    ));

    final data = await useCase.call(
      repositoryName: event.searchTerm,
      isReload: true,
    );
    data.fold(
      (itemEntity) {
        if (itemEntity.isEmpty) {
          emit(RepositoryListEmptyState.empty());
          return;
        }
        final itemUiEntity = itemEntity
            .map((e) => RepositoryListUiEntity(
                  id: e.id,
                  name: e.name,
                  ownerName: e.ownerName,
                  description: e.description,
                  language: e.language,
                  openIssuesCount: e.openIssuesCount,
                ))
            .toList();

        emit(RepositoryListLoadedState(
          repositoryList: itemUiEntity,
          searchTerm: event.searchTerm,
          isLastPage: oldState.isLastPage,
        ));
      },
      (exception) => emit(
        RepositoryListErrorState(
          repositoryList: oldState.repositoryList,
          searchTerm: event.searchTerm,
          errorMessage: "Something went wrong. Please try again",
          isLastPage: oldState.isLastPage,
        ),
      ),
    );
  }
}
