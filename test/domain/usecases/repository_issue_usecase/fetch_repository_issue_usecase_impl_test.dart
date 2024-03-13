import 'package:dartz/dartz.dart';
import 'package:flutter_git_app/core/exceptions/unknown_network_exception.dart';
import 'package:flutter_git_app/domain/entities/repository_issue_list/repository_issue_entity.dart';
import 'package:flutter_git_app/domain/repositories/repository_issue_repository/fetch_repository_issue_repository.dart';
import 'package:flutter_git_app/domain/usecases/repository_issue_usecase/fetch_repository_issue_usecase_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mock/mocks.dart';

void main() {
  late FetchRepositoryIssueUseCaseImpl useCase;
  late FetchRepositoryIssueRepository mockRepository;

  setUp(() {
    mockRepository = MockFetchRepositoryIssueListRepository();
    useCase = FetchRepositoryIssueUseCaseImpl(repository: mockRepository);
  });

  group('FetchRepositoryIssueListUseCaseImpl', () {
    const repositoryName = 'flutter';
    const ownerName = 'test';
    const user = User(name: "test");
    const repositoryListEntity = [
      RepositoryIssueEntity(
        id: 1,
        title: 'Issue 1',
        number: 1,
        createdAt: '2024-03-13T12:00:00Z',
        user: user,
      )
    ];
    const exception = UnknownNetworkException('Failed to fetch data');

    test('should return a list of repositories issues on success', () async {
      when(() => mockRepository.fetchRepositoryIssues(
            repositoryName: any(named: 'repositoryName'),
            ownerName: any(named: 'ownerName'),
          )).thenAnswer((_) async => const Left(repositoryListEntity));

      final result = await useCase.call(
          repositoryName: repositoryName, ownerName: ownerName);

      expect(result, equals(const Left(repositoryListEntity)));
    });

    test('should return a  exception on failure', () async {
      when(() => mockRepository.fetchRepositoryIssues(
            repositoryName: any(named: 'repositoryName'),
            ownerName: any(named: 'ownerName'),
          )).thenAnswer((_) async => const Right(exception));

      final result = await useCase.call(
          repositoryName: repositoryName, ownerName: ownerName);

      expect(result, equals(const Right(exception)));
    });
  });
}
