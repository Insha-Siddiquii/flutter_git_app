import 'package:dartz/dartz.dart';
import 'package:flutter_git_app/core/exceptions/base_exception.dart';
import 'package:flutter_git_app/datasources/models/repository_issue_model/repository_issue_model.dart';

abstract class FetchRepositoryIssueRemoteDataSource {
  Future<Either<List<RepositoryIssueModel>, BaseException>>
      fetchRepositoryIssues({
    required String ownerName,
    required String repositoryName,
    bool isReload = false,
  });
}
