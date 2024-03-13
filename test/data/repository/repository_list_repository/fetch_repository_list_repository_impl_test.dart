import 'package:dartz/dartz.dart';
import 'package:flutter_git_app/core/exceptions/base_exception.dart';
import 'package:flutter_git_app/core/exceptions/unknown_network_exception.dart';
import 'package:flutter_git_app/datasources/models/repository_list_model/repository_list_model.dart';
import 'package:flutter_git_app/datasources/remote/repository_list_remote_data_source/fetch_repository_list_remote_data_source.dart';
import 'package:flutter_git_app/datasources/repositories/repository_list_repository/fetch_repository_list_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mock/mocks.dart';

void main() {
  late FetchRepositoryListRepositoryImpl repository;
  late FetchRepositoryListRemoteDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockFetchRepositoryListRemoteDataSource();
    repository = FetchRepositoryListRepositoryImpl(dataSource: mockDataSource);
  });

  group('FetchRepositoryListRepositoryImpl', () {
    const repositoryName = 'flutter';

    test('should return a list of RepositoryListEntity on success', () async {
      const result = Left<List<RepositoryListModel>, BaseException>([
        RepositoryListModel(
          id: 1,
          name: 'Repository 1',
          fullName: 'owner1/repo1',
          description: 'Description 1',
          language: 'Dart',
          openIssuesCount: 5,
        ),
        RepositoryListModel(
          id: 2,
          name: 'Repository 2',
          fullName: 'owner2/repo2',
          description: 'Description 2',
          language: 'Flutter',
          openIssuesCount: 10,
        ),
      ]);
      when(() => mockDataSource.fetchRemoteRepositoryList(
            repositoryName: any(named: 'repositoryName'),
            isNewSearch: any(named: 'isNewSearch'),
            isReload: any(named: 'isReload'),
          )).thenAnswer((_) => Future.value(result));

      final response = await repository.fetchRepositoryList(
        repositoryName: repositoryName,
      );

      expect(response.isLeft(), true);
    });

    test('should return a Exception on failure', () async {
      when(() => mockDataSource.fetchRemoteRepositoryList(
                repositoryName: any(named: 'repositoryName'),
                isNewSearch: any(named: 'isNewSearch'),
                isReload: any(named: 'isReload'),
              ))
          .thenAnswer((_) async =>
              const Right(UnknownNetworkException('Failed to fetch')));

      final result = await repository.fetchRepositoryList(
        repositoryName: repositoryName,
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
