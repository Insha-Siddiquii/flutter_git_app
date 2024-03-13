import 'package:dartz/dartz.dart';
import 'package:flutter_git_app/core/common/network_constants.dart';
import 'package:flutter_git_app/core/exceptions/base_exception.dart';
import 'package:flutter_git_app/core/exceptions/network_exception.dart';
import 'package:flutter_git_app/core/network_client/model/api_param.dart';
import 'package:flutter_git_app/core/network_client/network_client.dart';
import 'package:flutter_git_app/core/network_client/util/http_api_header_handler.dart';
import 'package:flutter_git_app/core/network_client/util/http_api_request_constructor.dart';
import 'package:flutter_git_app/core/network_client/util/http_method.dart';
import 'package:flutter_git_app/datasources/models/repository_issue_model/repository_issue_model.dart';
import 'package:flutter_git_app/datasources/remote/repository_issue_remote_data_source/fetch_repository_issue_remote_data_source.dart';

class FetchRepositoryIssueRemoteDataSourceImpl
    implements FetchRepositoryIssueRemoteDataSource {
  final NetworkClient networkClient;
  final HttpApiRequestConstructor apiRequestConstructor;
  final HttpApiHeaderHandler apiHeaderHandler;
  String page = '';

  FetchRepositoryIssueRemoteDataSourceImpl({
    required this.networkClient,
    required this.apiHeaderHandler,
    required this.apiRequestConstructor,
  });

  @override
  Future<Either<List<RepositoryIssueModel>, BaseException>>
      fetchRepositoryIssues({
    required String ownerName,
    required String repositoryName,
    bool isReload = false,
  }) async {
    final List<RepositoryIssueModel> listIssues = List.empty(growable: true);

    /// for the first time

    if (page.isEmpty || isReload) {
      page = "1";
    }

    /// reaches page end

    if (page == "-1") {
      return Left(listIssues);
    }

    /// contruct api request

    final apiRequest = apiRequestConstructor.constructApiRequest(
      method: HttpMethod.get,
      url: "$baseUrl/repos/$ownerName/$repositoryName/issues",
      apiParam: _constructApiParam(
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
          listIssues.add(RepositoryIssueModel.fromJson(element));
        }

        return Left(listIssues);
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

  ApiParam _constructApiParam(String page) {
    return ApiParam(queryParams: {
      'state': 'open',
      'sort': 'created',
      'direction': 'desc',
      'page': page,
      'per_page': perPage,
    });
  }
}
