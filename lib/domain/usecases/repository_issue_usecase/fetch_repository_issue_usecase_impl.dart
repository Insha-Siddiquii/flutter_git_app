import 'package:dartz/dartz.dart';
import 'package:flutter_git_app/core/exceptions/base_exception.dart';
import 'package:flutter_git_app/domain/entities/repository_issue_list/repository_issue_entity.dart';
import 'package:flutter_git_app/domain/repositories/repository_issue_repository/fetch_repository_issue_repository.dart';
import 'package:flutter_git_app/domain/usecases/repository_issue_usecase/fetch_repository_issue_usecase.dart';

class FetchRepositoryIssueUseCaseImpl implements FetchRepositoryIssueUseCase {
  final FetchRepositoryIssueRepository repository;

  const FetchRepositoryIssueUseCaseImpl({
    required this.repository,
  });

  @override
  Future<Either<List<RepositoryIssueEntity>, BaseException>> call({
    required String ownerName,
    required String repositoryName,
    bool isReload = false,
  }) {
    return repository.fetchRepositoryIssues(
      ownerName: ownerName,
      repositoryName: repositoryName,
      isReload: isReload,
    );
  }
}
