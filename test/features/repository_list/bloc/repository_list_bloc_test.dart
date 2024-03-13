import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_git_app/core/exceptions/network_exception.dart';
import 'package:flutter_git_app/domain/entities/repository_list/repository_list_entity.dart';
import 'package:flutter_git_app/domain/usecases/repository_list_usecase/fetch_repository_list_usecase.dart';
import 'package:flutter_git_app/presentation/entities/repository_list/repository_list_ui_entity.dart';
import 'package:flutter_git_app/presentation/features/repository_list/bloc/repository_list_bloc.dart';
import 'package:flutter_git_app/presentation/features/repository_list/bloc/repository_list_bloc_event.dart';
import 'package:flutter_git_app/presentation/features/repository_list/bloc/repository_list_bloc_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mock/mocks.dart';

void main() {
  late RepositoryListBloc repositoryListBloc;
  late FetchRepositoryListUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockFetchRepositoryListUseCase();
    repositoryListBloc = RepositoryListBloc(useCase: mockUseCase);
  });

  tearDown(() {
    repositoryListBloc.close();
  });

  group('RepositoryListBloc', () {
    final mockRepositoryListEntity = [
      const RepositoryListEntity(
        id: 1,
        name: 'Repo 1',
        ownerName: 'Owner 1',
        description: 'Description 1',
        language: 'Dart',
        openIssuesCount: 5,
      ),
      const RepositoryListEntity(
        id: 2,
        name: 'Repo 2',
        ownerName: 'Owner 2',
        description: 'Description 2',
        language: 'JavaScript',
        openIssuesCount: 10,
      ),
    ];

    final mockRepositoryListUiEntity = mockRepositoryListEntity
        .map((e) => RepositoryListUiEntity(
              id: e.id,
              name: e.name,
              ownerName: e.ownerName,
              description: e.description,
              language: e.language,
              openIssuesCount: e.openIssuesCount,
            ))
        .toList();

    blocTest<RepositoryListBloc, RepositoryListState>(
      'emits [RepositoryListLoadingState, RepositoryListLoadedState] when GetRepositoryListEvent is added',
      build: () {
        when(() => mockUseCase.call(
              repositoryName: any(named: 'repositoryName'),
              isNewSearch: true,
            )).thenAnswer((_) async => Left(mockRepositoryListEntity));
        return repositoryListBloc;
      },
      act: (bloc) => bloc.add(GetRepositoryListEvent(searchTerm: 'flutter')),
      expect: () => [
        const RepositoryListLoadingState(
          repositoryList: [],
          searchTerm: 'flutter',
          isLastPage: false,
        ),
        RepositoryListLoadedState(
          repositoryList: mockRepositoryListUiEntity,
          searchTerm: 'flutter',
          isLastPage: false,
        ),
      ],
    );

    blocTest<RepositoryListBloc, RepositoryListState>(
      'emits [RepositoryListLoadingNextPageState, RepositoryListLoadedState] when GetRepositoryListNextPageEvent is added',
      build: () {
        when(() =>
                mockUseCase.call(repositoryName: any(named: 'repositoryName')))
            .thenAnswer((_) async => Left(mockRepositoryListEntity));
        return repositoryListBloc;
      },
      seed: () => RepositoryListLoadedState(
        repositoryList: mockRepositoryListUiEntity,
        searchTerm: "flutter",
        isLastPage: false,
      ),
      act: (bloc) =>
          bloc.add(GetRepositoryListNextPageEvent(searchTerm: 'flutter')),
      expect: () => [
        RepositoryListLoadingNextPageState(
          repositoryList: mockRepositoryListUiEntity,
          searchTerm: 'flutter',
          isLastPage: false,
        ),
        RepositoryListLoadedState(
          repositoryList: [
            ...mockRepositoryListUiEntity,
            ...mockRepositoryListUiEntity
          ],
          searchTerm: 'flutter',
          isLastPage: false,
        ),
      ],
    );

    blocTest<RepositoryListBloc, RepositoryListState>(
      'emits [RepositoryListReloadingState, RepositoryListLoadedState] when ReloadRepositoryListEvent is added',
      build: () {
        when(() => mockUseCase.call(
                repositoryName: any(named: 'repositoryName'), isReload: true))
            .thenAnswer((_) async => Left(mockRepositoryListEntity));
        return repositoryListBloc;
      },
      seed: () => RepositoryListLoadedState(
        repositoryList: mockRepositoryListUiEntity,
        searchTerm: "flutter",
        isLastPage: false,
      ),
      act: (bloc) => bloc.add(ReloadRepositoryListEvent(searchTerm: 'flutter')),
      expect: () => [
        RepositoryListReloadingState(
          repositoryList: mockRepositoryListUiEntity,
          searchTerm: 'flutter',
          isLastPage: false,
        ),
        RepositoryListLoadedState(
          repositoryList: mockRepositoryListUiEntity,
          searchTerm: 'flutter',
          isLastPage: false,
        ),
      ],
    );

    blocTest<RepositoryListBloc, RepositoryListState>(
      'emits [RepositoryListErrorState] when FetchRepositoryListUseCase returns a failure',
      build: () {
        when(() => mockUseCase.call(
                  repositoryName: any(named: 'repositoryName'),
                  isNewSearch: true,
                ))
            .thenAnswer(
                (_) async => const Right(NetworkException(404, 'Error')));
        return repositoryListBloc;
      },
      seed: () => RepositoryListLoadedState(
        repositoryList: mockRepositoryListUiEntity,
        searchTerm: "flutter",
        isLastPage: false,
      ),
      act: (bloc) => bloc.add(GetRepositoryListEvent(searchTerm: 'flutter')),
      expect: () => [
        RepositoryListLoadingState(
          repositoryList: mockRepositoryListUiEntity,
          searchTerm: 'flutter',
          isLastPage: false,
        ),
        RepositoryListErrorState(
          repositoryList: mockRepositoryListUiEntity,
          searchTerm: 'flutter',
          errorMessage: 'Something went wrong. Please try again',
          isLastPage: false,
        ),
      ],
    );

    blocTest<RepositoryListBloc, RepositoryListState>(
      'emits [RepositoryListEmptyState] when FetchRepositoryListUseCase returns an empty list',
      build: () {
        when(() => mockUseCase.call(
              repositoryName: any(named: 'repositoryName'),
              isNewSearch: true,
            )).thenAnswer((_) async => const Left([]));
        return repositoryListBloc;
      },
      seed: () => RepositoryListLoadedState(
        repositoryList: mockRepositoryListUiEntity,
        searchTerm: "flutter",
        isLastPage: false,
      ),
      act: (bloc) => bloc.add(GetRepositoryListEvent(searchTerm: 'flutter')),
      expect: () => [
        RepositoryListLoadingState(
          repositoryList: mockRepositoryListUiEntity,
          searchTerm: 'flutter',
          isLastPage: false,
        ),
        const RepositoryListEmptyState(
          repositoryList: [],
          searchTerm: '',
          message: 'No result with this search. Try again with new search',
          isLastPage: false,
        ),
      ],
    );
  });
}
