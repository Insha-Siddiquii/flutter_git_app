import 'package:dartz/dartz.dart';
import 'package:flutter_git_app/core/exceptions/base_exception.dart';
import 'package:flutter_git_app/core/exceptions/unknown_network_exception.dart';
import 'package:flutter_git_app/datasources/models/repository_issue_model/repository_issue_model.dart';
import 'package:flutter_git_app/datasources/remote/repository_issue_remote_data_source/fetch_repository_issue_remote_data_source.dart';
import 'package:flutter_git_app/datasources/repositories/repository_issue_repository/fetch_repository_issue_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mock/mocks.dart';

void main() {
  late FetchRepositoryIssueRepositoryImpl repository;
  late FetchRepositoryIssueRemoteDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockFetchRepositoryIssueListRemoteDataSource();
    repository = FetchRepositoryIssueRepositoryImpl(dataSource: mockDataSource);
  });

  group('FetchRepositoryIssueListRepositoryImpl', () {
    const repositoryName = 'flutter';
    const ownerName = 'test';

    test('should return a list of RepositoryIssueListEntity on success',
        () async {
      const user = User(name: "test");
      const result = Left<List<RepositoryIssueModel>, BaseException>([
        RepositoryIssueModel(
          id: 1,
          title: 'Repository 1',
          number: 12345,
          createdAt: '2024-03-13T11:53:58Z',
          user: user,
        ),
        RepositoryIssueModel(
          id: 1,
          title: 'Repository 2',
          number: 12343,
          createdAt: '2024-03-13T11:53:58Z',
          user: user,
        ),
      ]);
      when(() => mockDataSource.fetchRepositoryIssues(
            repositoryName: any(named: 'repositoryName'),
            ownerName: any(named: 'ownerName'),
          )).thenAnswer((_) => Future.value(result));

      final response = await repository.fetchRepositoryIssues(
        repositoryName: repositoryName,
        ownerName: ownerName,
      );

      expect(response.isLeft(), true);
    });

    test('should return a Exception on failure', () async {
      when(() => mockDataSource.fetchRepositoryIssues(
                repositoryName: any(named: 'repositoryName'),
                ownerName: any(named: 'ownerName'),
              ))
          .thenAnswer((_) async =>
              const Right(UnknownNetworkException('Failed to fetch')));

      final result = await repository.fetchRepositoryIssues(
        repositoryName: repositoryName,
        ownerName: ownerName,
      );

      expect(
        result,
        equals(
          const Right(UnknownNetworkException('Failed to fetch')),
        ),
      );
    });
  });
}
