import 'package:dartz/dartz.dart';
import 'package:flutter_git_app/core/exceptions/base_exception.dart';
import 'package:flutter_git_app/domain/entities/repository_issue_list/repository_issue_entity.dart';

abstract class FetchRepositoryIssueRepository {
  Future<Either<List<RepositoryIssueEntity>, BaseException>>
      fetchRepositoryIssues({
    required String ownerName,
    required String repositoryName,
  });
}
