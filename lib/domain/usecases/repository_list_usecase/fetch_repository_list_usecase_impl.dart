import 'package:dartz/dartz.dart';
import 'package:flutter_git_app/core/exceptions/base_exception.dart';
import 'package:flutter_git_app/domain/entities/repository_list/repository_list_entity.dart';
import 'package:flutter_git_app/domain/repositories/repository_list_repository/fetch_repository_list_repository.dart';
import 'package:flutter_git_app/domain/usecases/repository_list_usecase/fetch_repository_list_usecase.dart';

class FetchRepositoryListUseCaseImpl implements FetchRepositoryListUseCase {
  final FetchRepositoryListRepository repository;
  const FetchRepositoryListUseCaseImpl({
    required this.repository,
  });

  @override
  Future<Either<List<RepositoryListEntity>, BaseException>> call({
    required String repositoryName,
  }) {
    return repository.fetchRepositoryList(repositoryName: repositoryName);
  }
}
