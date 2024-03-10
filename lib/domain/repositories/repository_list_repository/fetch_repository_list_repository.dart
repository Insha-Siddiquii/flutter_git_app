import 'package:dartz/dartz.dart';
import 'package:flutter_git_app/core/exceptions/base_exception.dart';
import 'package:flutter_git_app/domain/entities/repository_list/repository_list_entity.dart';

abstract class FetchRepositoryListRepository {
  Future<Either<List<RepositoryListEntity>, BaseException>>
      fetchRepositoryList({
    required String repositoryName,
  });
}
