import 'package:dartz/dartz.dart';
import 'package:flutter_git_app/core/exceptions/unknown_network_exception.dart';
import 'package:flutter_git_app/domain/entities/repository_list/repository_list_entity.dart';
import 'package:flutter_git_app/domain/repositories/repository_list_repository/fetch_repository_list_repository.dart';
import 'package:flutter_git_app/domain/usecases/repository_list_usecase/fetch_repository_list_usecase_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mock/mocks.dart';

void main() {
  late FetchRepositoryListUseCaseImpl useCase;
  late FetchRepositoryListRepository mockRepository;

  setUp(() {
    mockRepository = MockFetchRepositoryListRepository();
    useCase = FetchRepositoryListUseCaseImpl(repository: mockRepository);
  });

  group('FetchRepositoryListUseCaseImpl', () {
    const repositoryName = 'flutter';
    const repositoryListEntity = [
      RepositoryListEntity(
        id: 1,
        name: 'Repo 1',
        ownerName: 'Owner 1',
        description: 'Description 1',
        language: 'Dart',
        openIssuesCount: 5,
      )
    ];
    const exception = UnknownNetworkException('Failed to fetch data');

    test('should return a list of repositories on success', () async {
      when(() => mockRepository.fetchRepositoryList(
            repositoryName: any(named: 'repositoryName'),
            isNewSearch: any(named: 'isNewSearch'),
            isReload: any(named: 'isReload'),
          )).thenAnswer((_) async => const Left(repositoryListEntity));

      final result = await useCase.call(repositoryName: repositoryName);

      expect(result, equals(const Left(repositoryListEntity)));
    });

    test('should return a  exception on failure', () async {
      when(() => mockRepository.fetchRepositoryList(
            repositoryName: any(named: 'repositoryName'),
            isNewSearch: any(named: 'isNewSearch'),
            isReload: any(named: 'isReload'),
          )).thenAnswer((_) async => const Right(exception));

      final result = await useCase.call(repositoryName: repositoryName);

      expect(result, equals(const Right(exception)));
    });
  });
}
