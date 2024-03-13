import 'package:dartz/dartz.dart';
import 'package:flutter_git_app/core/common/network_constants.dart';
import 'package:flutter_git_app/core/exceptions/base_exception.dart';
import 'package:flutter_git_app/core/exceptions/network_exception.dart';
import 'package:flutter_git_app/core/network_client/model/api_param.dart';
import 'package:flutter_git_app/core/network_client/network_client.dart';
import 'package:flutter_git_app/core/network_client/util/http_api_header_handler.dart';
import 'package:flutter_git_app/core/network_client/util/http_api_request_constructor.dart';
import 'package:flutter_git_app/core/network_client/util/http_method.dart';
import 'package:flutter_git_app/datasources/models/repository_list_model/repository_list_model.dart';
import 'package:flutter_git_app/datasources/remote/repository_list_remote_data_source/fetch_repository_list_remote_data_source.dart';

class FetchRepositoryListRemoteDataSourceImpl
    implements FetchRepositoryListRemoteDataSource {
  final NetworkClient networkClient;
  final HttpApiRequestConstructor apiRequestConstructor;
  final HttpApiHeaderHandler apiHeaderHandler;
  String page = '';

  FetchRepositoryListRemoteDataSourceImpl({
    required this.networkClient,
    required this.apiRequestConstructor,
    required this.apiHeaderHandler,
  });

  @override
  Future<Either<List<RepositoryListModel>, BaseException>>
      fetchRemoteRepositoryList({
    required String repositoryName,
    bool isReload = false,
    bool isNewSearch = false,
  }) async {
    final List<RepositoryListModel> repoListModel = List.empty(growable: true);

    /// for the first time

    if (page.isEmpty || isReload || isNewSearch) {
      page = "1";
    }

    /// reaches page end

    if (page == "-1") {
      return Left(repoListModel);
    }

    /// contruct api request

    final apiRequest = apiRequestConstructor.constructApiRequest(
      method: HttpMethod.get,
      url: "$baseUrl/search/repositories",
      apiParam: _constructApiParam(
        repositoryName,
        page,
      ),
    );

    /// calls the network service

    final response = await networkClient.get(apiRequest);

    /// handles the response

    return response.fold((networkResponse) {
      try {
        String linkHeader = networkResponse.headers["link"] ?? "";
        page = apiHeaderHandler.extractNextPage(linkHeader);

        final responseDataList = networkResponse.data["items"];

        for (var element in responseDataList) {
          repoListModel.add(RepositoryListModel.fromJson(element));
        }

        return Left(repoListModel);
      } catch (e) {
        return Right(
          NetworkException(
            networkResponse.statusCode,
            e.toString(),
          ),
        );
      }
    }, Right.new);
  }

  ApiParam _constructApiParam(String repositoryName, String page) {
    return ApiParam(queryParams: {
      'q': repositoryName,
      'sort': 'full_name',
      'per_page': perPage,
      'page': page,
    });
  }
}
