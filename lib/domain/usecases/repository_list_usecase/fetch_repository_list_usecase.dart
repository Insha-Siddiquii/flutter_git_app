import 'package:dartz/dartz.dart';
import 'package:flutter_git_app/core/exceptions/base_exception.dart';
import 'package:flutter_git_app/domain/entities/repository_list/repository_list_entity.dart';

abstract class FetchRepositoryListUseCase {
  Future<Either<List<RepositoryListEntity>, BaseException>> call({
    required String repositoryName,
  });
}
