import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_git_app/domain/entities/repository_issue_list/repository_issue_entity.dart';
import 'package:flutter_git_app/presentation/entities/repository_issue/repository_issue_ui_entity.dart';
import 'package:flutter_git_app/presentation/features/repository_issues/bloc/bloc/repository_issues_bloc.dart';
import 'package:flutter_git_app/presentation/features/repository_issues/bloc/bloc/repository_issues_event.dart';
import 'package:flutter_git_app/presentation/features/repository_issues/bloc/bloc/repository_issues_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mock/mocks.dart';

void main() {
  late RepositoryIssueListBloc repositoryIssueListBloc;
  late MockFetchRepositoryIssueUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockFetchRepositoryIssueUseCase();
    repositoryIssueListBloc = RepositoryIssueListBloc(useCase: mockUseCase);
  });

  group('RepositoryIssueListBloc', () {
    const user = User(name: "test");
    final mockRepositoryIssueListEntity = [
      const RepositoryIssueEntity(
        id: 1,
        title: 'Issue 1',
        number: 1,
        createdAt: '2024-03-13T12:00:00Z',
        user: user,
      ),
      const RepositoryIssueEntity(
        id: 2,
        title: 'Issue 2',
        number: 2,
        createdAt: '2024-03-12T12:00:00Z',
        user: user,
      ),
    ];

    final mockRepositoryIssueListUiEntity = mockRepositoryIssueListEntity
        .map((e) => RepositoryIssueUiEntity(
              id: e.id,
              title: e.title,
              number: e.number,
              createdAt: e.createdAt,
              userName: e.user.name,
            ))
        .toList();

    blocTest<RepositoryIssueListBloc, RepositoryIssueListState>(
      'emits [RepositoryIssueListLoadingState, RepositoryIssueListLoadedState] when GetRepositoryIssueListEvent is added',
      build: () {
        when(() => mockUseCase.call(
                repositoryName: any(named: 'repositoryName'),
                ownerName: any(named: 'ownerName')))
            .thenAnswer((_) async => Left(mockRepositoryIssueListEntity));
        return repositoryIssueListBloc;
      },
      act: (bloc) => bloc.add(GetRepositoryIssueListEvent(
          ownerName: 'owner', repositoryName: 'repository')),
      expect: () => [
        const RepositoryIssueListLoadingState(
          repositoryIssueList: [],
          isLastPage: false,
        ),
        RepositoryIssueListLoadedState(
          repositoryIssueList: mockRepositoryIssueListUiEntity,
          isLastPage: false,
        ),
      ],
    );

    blocTest<RepositoryIssueListBloc, RepositoryIssueListState>(
      'emits [RepositoryIssueListLoadingState, RepositoryIssueListEmptyState] when GetRepositoryIssueListEvent is added and the list is empty',
      build: () {
        when(() => mockUseCase.call(
                repositoryName: any(named: 'repositoryName'),
                ownerName: any(named: 'ownerName')))
            .thenAnswer((_) async => const Left([]));
        return repositoryIssueListBloc;
      },
      seed: () => RepositoryIssueListLoadedState(
        repositoryIssueList: mockRepositoryIssueListUiEntity,
        isLastPage: false,
      ),
      act: (bloc) => bloc.add(GetRepositoryIssueListEvent(
          ownerName: 'owner', repositoryName: 'repository')),
      expect: () => [
        RepositoryIssueListLoadingState(
          repositoryIssueList: mockRepositoryIssueListUiEntity,
          isLastPage: false,
        ),
        const RepositoryIssueListEmptyState(
          repositoryIssueList: [],
          message: 'No open issues for this repository',
          isLastPage: false,
        ),
      ],
    );

    blocTest<RepositoryIssueListBloc, RepositoryIssueListState>(
      'emits [RepositoryIssueListLoadingNextPageState, RepositoryIssueListLoadedState] when GetRepositoryIssueListNextPageEvent is added',
      build: () {
        when(() => mockUseCase.call(
                repositoryName: any(named: 'repositoryName'),
                ownerName: any(named: 'ownerName')))
            .thenAnswer((_) async => Left(mockRepositoryIssueListEntity));
        return repositoryIssueListBloc;
      },
      seed: () => RepositoryIssueListLoadedState(
        repositoryIssueList: mockRepositoryIssueListUiEntity,
        isLastPage: false,
      ),
      act: (bloc) => bloc.add(GetRepositoryIssueListNextPageEvent(
          ownerName: 'owner', repositoryName: 'repository')),
      expect: () => [
        RepositoryIssueListLoadingNextPageState(
          repositoryIssueList: mockRepositoryIssueListUiEntity,
          isLastPage: false,
        ),
        RepositoryIssueListLoadedState(
          repositoryIssueList: [
            ...mockRepositoryIssueListUiEntity,
            ...mockRepositoryIssueListUiEntity
          ],
          isLastPage: false,
        ),
      ],
    );

    blocTest<RepositoryIssueListBloc, RepositoryIssueListState>(
      'emits [RepositoryIssueListReloadingState, RepositoryIssueListLoadedState] when ReloadRepositoryIssueListEvent is added',
      build: () {
        when(() => mockUseCase.call(
                repositoryName: any(named: 'repositoryName'),
                ownerName: any(named: 'ownerName'),
                isReload: any(named: 'isReload')))
            .thenAnswer((_) async => Left(mockRepositoryIssueListEntity));
        return repositoryIssueListBloc;
      },
      seed: () => RepositoryIssueListLoadedState(
        repositoryIssueList: mockRepositoryIssueListUiEntity,
        isLastPage: false,
      ),
      act: (bloc) => bloc.add(ReloadRepositoryIssueListEvent(
          ownerName: 'owner', repositoryName: 'repository')),
      expect: () => [
        RepositoryIssueListReloadingState(
          repositoryIssueList: mockRepositoryIssueListUiEntity,
          isLastPage: false,
        ),
        RepositoryIssueListLoadedState(
          repositoryIssueList: mockRepositoryIssueListUiEntity,
          isLastPage: false,
        ),
      ],
    );

    blocTest<RepositoryIssueListBloc, RepositoryIssueListState>(
      'emits [RepositoryIssueListReloadingState, RepositoryIssueListEmptyState] when ReloadRepositoryIssueListEvent is added and the list is empty',
      build: () {
        when(() => mockUseCase.call(
                repositoryName: any(named: 'repositoryName'),
                ownerName: any(named: 'ownerName'),
                isReload: any(named: 'isReload')))
            .thenAnswer((_) async => const Left([]));
        return repositoryIssueListBloc;
      },
      seed: () => RepositoryIssueListLoadedState(
        repositoryIssueList: mockRepositoryIssueListUiEntity,
        isLastPage: false,
      ),
      act: (bloc) => bloc.add(ReloadRepositoryIssueListEvent(
          ownerName: 'owner', repositoryName: 'repository')),
      expect: () => [
        RepositoryIssueListReloadingState(
          repositoryIssueList: mockRepositoryIssueListUiEntity,
          isLastPage: false,
        ),
        const RepositoryIssueListEmptyState(
          repositoryIssueList: [],
          message: 'No open issues for this repository',
          isLastPage: false,
        ),
      ],
    );
  });
}
