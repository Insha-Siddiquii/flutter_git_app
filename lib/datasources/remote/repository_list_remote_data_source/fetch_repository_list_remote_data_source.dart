import 'package:dartz/dartz.dart';
import 'package:flutter_git_app/core/exceptions/base_exception.dart';
import 'package:flutter_git_app/datasources/models/repository_list_model/repository_list_model.dart';

abstract class FetchRepositoryListRemoteDataSource {
  Future<Either<List<RepositoryListModel>, BaseException>>
      fetchRemoteRepositoryList({
    required String repositoryName,
  });
}
