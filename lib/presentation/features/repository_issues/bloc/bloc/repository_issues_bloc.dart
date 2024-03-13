import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_git_app/domain/usecases/repository_issue_usecase/fetch_repository_issue_usecase.dart';
import 'package:flutter_git_app/presentation/entities/repository_issue/repository_issue_ui_entity.dart';
import 'package:flutter_git_app/presentation/features/repository_issues/bloc/bloc/repository_issues_event.dart';
import 'package:flutter_git_app/presentation/features/repository_issues/bloc/bloc/repository_issues_state.dart';

class RepositoryIssueListBloc
    extends Bloc<RepositoryIssueListEvent, RepositoryIssueListState> {
  final FetchRepositoryIssueUseCase useCase;
  RepositoryIssueListBloc({
    required this.useCase,
  }) : super(
          RepositoryIssueListInitialState.start(),
        ) {
    on<GetRepositoryIssueListEvent>(_fetchRepositoryIssueList);

    on<GetRepositoryIssueListNextPageEvent>(_getRepositoryIssueListNextPage);

    on<ReloadRepositoryIssueListEvent>(_reloadRepositoryIssueList);
  }

  void _fetchRepositoryIssueList(
    GetRepositoryIssueListEvent event,
    Emitter<RepositoryIssueListState> emit,
  ) async {
    final oldState = state;

    emit(RepositoryIssueListLoadingState(
      repositoryIssueList: oldState.repositoryIssueList,
      isLastPage: oldState.isLastPage,
    ));

    final data = await useCase.call(
      repositoryName: event.repositoryName,
      ownerName: event.ownerName,
    );

    data.fold(
      (itemEntity) {
        if (itemEntity.isEmpty) {
          emit(RepositoryIssueListEmptyState.empty());
          return;
        }

        final itemUiEntity = itemEntity
            .map((e) => RepositoryIssueUiEntity(
                  id: e.id,
                  title: e.title,
                  number: e.number,
                  createdAt: e.createdAt,
                  userName: e.user.name,
                ))
            .toList();

        emit(RepositoryIssueListLoadedState(
          repositoryIssueList: itemUiEntity,
          isLastPage: oldState.isLastPage,
        ));
      },
      (exception) => emit(
        RepositoryIssueListErrorState(
          repositoryIssueList: oldState.repositoryIssueList,
          errorMessage: "Something went wrong. Please try again",
          isLastPage: oldState.isLastPage,
        ),
      ),
    );
  }

  void _getRepositoryIssueListNextPage(
    GetRepositoryIssueListNextPageEvent event,
    Emitter<RepositoryIssueListState> emit,
  ) async {
    final oldState = state;

    emit(RepositoryIssueListLoadingNextPageState(
      repositoryIssueList: oldState.repositoryIssueList,
      isLastPage: oldState.isLastPage,
    ));

    final data = await useCase.call(
      repositoryName: event.repositoryName,
      ownerName: event.ownerName,
    );

    data.fold(
      (itemEntity) {
        final itemUiEntity = itemEntity
            .map((e) => RepositoryIssueUiEntity(
                  id: e.id,
                  title: e.title,
                  number: e.number,
                  createdAt: e.createdAt,
                  userName: e.user.name,
                ))
            .toList();

        emit(RepositoryIssueListLoadedState(
          repositoryIssueList: [
            ...oldState.repositoryIssueList,
            ...itemUiEntity
          ],
          isLastPage: itemUiEntity.isNotEmpty ? false : true,
        ));
      },
      (exception) => emit(
        RepositoryIssueListErrorState(
          repositoryIssueList: oldState.repositoryIssueList,
          errorMessage: "Something went wrong. Please try again",
          isLastPage: oldState.isLastPage,
        ),
      ),
    );
  }

  void _reloadRepositoryIssueList(
    ReloadRepositoryIssueListEvent event,
    Emitter<RepositoryIssueListState> emit,
  ) async {
    final oldState = state;

    emit(RepositoryIssueListReloadingState(
      repositoryIssueList: oldState.repositoryIssueList,
      isLastPage: oldState.isLastPage,
    ));

    final data = await useCase.call(
      repositoryName: event.repositoryName,
      ownerName: event.ownerName,
      isReload: true,
    );
    data.fold(
      (itemEntity) {
        if (itemEntity.isEmpty) {
          emit(RepositoryIssueListEmptyState.empty());
          return;
        }
        final itemUiEntity = itemEntity
            .map((e) => RepositoryIssueUiEntity(
                  id: e.id,
                  title: e.title,
                  number: e.number,
                  createdAt: e.createdAt,
                  userName: e.user.name,
                ))
            .toList();

        emit(RepositoryIssueListLoadedState(
          repositoryIssueList: itemUiEntity,
          isLastPage: oldState.isLastPage,
        ));
      },
      (exception) => emit(
        RepositoryIssueListErrorState(
          repositoryIssueList: oldState.repositoryIssueList,
          errorMessage: "Something went wrong. Please try again",
          isLastPage: oldState.isLastPage,
        ),
      ),
    );
  }
}
