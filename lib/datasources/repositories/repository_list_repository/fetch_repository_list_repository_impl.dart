import 'package:dartz/dartz.dart';
import 'package:flutter_git_app/core/exceptions/base_exception.dart';
import 'package:flutter_git_app/datasources/remote/repository_list_remote_data_source/fetch_repository_list_remote_data_source.dart';
import 'package:flutter_git_app/domain/entities/repository_list/repository_list_entity.dart';
import 'package:flutter_git_app/domain/repositories/repository_list_repository/fetch_repository_list_repository.dart';

class FetchRepositoryListRepositoryImpl
    implements FetchRepositoryListRepository {
  final FetchRepositoryListRemoteDataSource dataSource;

  const FetchRepositoryListRepositoryImpl({
    required this.dataSource,
  });
  @override
  Future<Either<List<RepositoryListEntity>, BaseException>>
      fetchRepositoryList({
    required String repositoryName,
    bool isReload = false,
    bool isNewSearch = false,
  }) async {
    final response = await dataSource.fetchRemoteRepositoryList(
      repositoryName: repositoryName,
      isNewSearch: isNewSearch,
      isReload: isReload,
    );

    return response.bimap(
        (data) => data
            .map((model) => RepositoryListEntity(
                  id: model.id,
                  name: model.name,
                  ownerName: _getOwnerName(model.fullName),
                  description: model.description ?? "",
                  language: model.language ?? "",
                  openIssuesCount: model.openIssuesCount,
                ))
            .toList(),
        (exception) => exception);
  }

  String _getOwnerName(String fullName) {
    return fullName.split("/").first;
  }
}
