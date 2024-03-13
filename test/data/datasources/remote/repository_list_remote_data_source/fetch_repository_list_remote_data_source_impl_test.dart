import 'package:dartz/dartz.dart';
import 'package:flutter_git_app/core/common/network_constants.dart';
import 'package:flutter_git_app/core/exceptions/network_exception.dart';
import 'package:flutter_git_app/core/network_client/model/api_param.dart';
import 'package:flutter_git_app/core/network_client/model/http_api_request.dart';
import 'package:flutter_git_app/core/network_client/network_client.dart';
import 'package:flutter_git_app/core/network_client/util/http_method.dart';
import 'package:flutter_git_app/datasources/remote/repository_list_remote_data_source/fetch_repository_list_remote_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mock/mocks.dart';

void main() {
  late FetchRepositoryListRemoteDataSourceImpl dataSource;
  late MockNetworkClient mockNetworkClient;
  late MockHttpApiRequestConstructor mockApiRequestConstructor;
  late MockHttpApiHeaderHandler mockApiHeaderHandler;

  setUp(() {
    mockNetworkClient = MockNetworkClient();
    mockApiRequestConstructor = MockHttpApiRequestConstructor();
    mockApiHeaderHandler = MockHttpApiHeaderHandler();

    dataSource = FetchRepositoryListRemoteDataSourceImpl(
      networkClient: mockNetworkClient,
      apiRequestConstructor: mockApiRequestConstructor,
      apiHeaderHandler: mockApiHeaderHandler,
    );
  });

  setUpAll(() {
    registerFallbackValue(const ApiParam());
    registerFallbackValue(const HttpApiRequest(
      method: HttpMethod.get,
      url: "$baseUrl/search/repositories",
      apiParam: ApiParam(),
    ));
  });

  group('fetchRemoteRepositoryList', () {
    test('should return list of RepositoryListModel on success', () async {
      final responseDataList = [
        {
          'id': 1,
          'name': 'Repo 1',
          'full_name': 'user/repo1',
          'description': 'test',
          "language": 'dart',
          'open_issues_count': 10
        },
        {
          'id': 1,
          'name': 'Repo 2',
          'full_name': 'user/repo2',
          'description': 'test',
          "language": 'dart',
          'open_issues_count': 10
        },
      ];
      const apiRequest = HttpApiRequest(
        method: HttpMethod.get,
        url: "$baseUrl/search/repositories",
        apiParam: ApiParam(),
      );

      final mockResponse = NetworkResponse(
        statusCode: 200,
        data: {'items': responseDataList},
        headers: const {'link': 'next_link'},
      );

      when(() => mockApiRequestConstructor.constructApiRequest(
            method: HttpMethod.get,
            url: "$baseUrl/search/repositories",
            apiParam: any(named: 'apiParam'),
          )).thenReturn(apiRequest);

      when(() => mockNetworkClient.get(any())).thenAnswer((_) async {
        return Left(mockResponse);
      });

      when(() => mockApiHeaderHandler.extractNextPage('next_link'))
          .thenReturn('2');

      final result = await dataSource.fetchRemoteRepositoryList(
        repositoryName: 'flutter',
      );

      expect(result.isLeft(), true);
    });

    test('should return empty list on reaching page end', () async {
      const mockResponse = NetworkResponse(
        statusCode: 200,
        data: {'items': []},
        headers: {'link': 'next_link'},
      );

      const apiRequest = HttpApiRequest(
        method: HttpMethod.get,
        url: "$baseUrl/search/repositories",
        apiParam: ApiParam(),
      );

      when(() => mockApiRequestConstructor.constructApiRequest(
            method: HttpMethod.get,
            url: "$baseUrl/search/repositories",
            apiParam: any(named: 'apiParam'),
          )).thenReturn(apiRequest);

      when(() => mockNetworkClient.get(any())).thenAnswer((_) async {
        return const Left(mockResponse);
      });

      when(() => mockApiHeaderHandler.extractNextPage('next_link'))
          .thenReturn('-1');

      final result = await dataSource.fetchRemoteRepositoryList(
        repositoryName: 'flutter',
      );

      expect(result.isLeft(), true);
    });

    test('should return a network exception on network failure', () async {
      const apiRequest = HttpApiRequest(
        method: HttpMethod.get,
        url: "$baseUrl/search/repositories",
        apiParam: ApiParam(),
      );
      when(() => mockApiRequestConstructor.constructApiRequest(
            method: HttpMethod.get,
            url: "$baseUrl/search/repositories",
            apiParam: any(named: 'apiParam'),
          )).thenReturn(apiRequest);

      when(() => mockNetworkClient.get(any())).thenAnswer((_) async {
        return const Right(NetworkException(404, 'Not Found'));
      });

      final result = await dataSource.fetchRemoteRepositoryList(
        repositoryName: 'flutter',
      );

      expect(result.isRight(), true);
    });
  });
}
