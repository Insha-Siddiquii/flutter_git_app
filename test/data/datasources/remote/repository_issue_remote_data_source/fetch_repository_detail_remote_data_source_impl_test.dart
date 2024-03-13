import 'package:dartz/dartz.dart';
import 'package:flutter_git_app/core/common/network_constants.dart';
import 'package:flutter_git_app/core/exceptions/network_exception.dart';
import 'package:flutter_git_app/core/network_client/model/api_param.dart';
import 'package:flutter_git_app/core/network_client/model/http_api_request.dart';
import 'package:flutter_git_app/core/network_client/network_client.dart';
import 'package:flutter_git_app/core/network_client/util/http_method.dart';
import 'package:flutter_git_app/datasources/remote/repository_issue_remote_data_source/fetch_repository_detail_remote_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mock/mocks.dart';

void main() {
  late FetchRepositoryIssueRemoteDataSourceImpl dataSource;
  late MockNetworkClient mockNetworkClient;
  late MockHttpApiRequestConstructor mockApiRequestConstructor;
  late MockHttpApiHeaderHandler mockApiHeaderHandler;

  setUp(() {
    mockNetworkClient = MockNetworkClient();
    mockApiRequestConstructor = MockHttpApiRequestConstructor();
    mockApiHeaderHandler = MockHttpApiHeaderHandler();

    dataSource = FetchRepositoryIssueRemoteDataSourceImpl(
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

  group('fetchRepositoryIssues', () {
    test('should return list of RepositoryIssueModel on success', () async {
      final responseDataList = [
        {
          'id': 1,
          'title': 'Issue 1',
          'created_at': '2024-03-13T12:00:00Z',
          'number': 12345,
          'user': {'login': 'test'}
        },
        {
          'id': 2,
          'title': 'Issue 2',
          'created_at': '2024-03-12T12:00:00Z',
          'number': 123452,
          'user': {'login': 'test'}
        }
      ];

      final mockResponse = NetworkResponse(
        statusCode: 200,
        data: {'items': responseDataList},
        headers: const {'link': 'next_link'},
      );

      const apiRequest = HttpApiRequest(
        method: HttpMethod.get,
        url: "$baseUrl/repos/owner/repo/issues",
        apiParam: ApiParam(),
      );

      when(() => mockApiRequestConstructor.constructApiRequest(
            method: HttpMethod.get,
            url: "$baseUrl/repos/owner/repo/issues",
            apiParam: any(named: 'apiParam'),
          )).thenReturn(apiRequest);

      when(() => mockNetworkClient.get(any())).thenAnswer((_) async {
        return Left(mockResponse);
      });

      when(() => mockApiHeaderHandler.extractNextPage('next_link'))
          .thenReturn('2');

      final result = await dataSource.fetchRepositoryIssues(
        ownerName: 'owner',
        repositoryName: 'repo',
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
        url: "$baseUrl/repos/owner/repo/issues",
        apiParam: ApiParam(),
      );

      when(() => mockApiRequestConstructor.constructApiRequest(
            method: HttpMethod.get,
            url: "$baseUrl/repos/owner/repo/issues",
            apiParam: any(named: 'apiParam'),
          )).thenReturn(apiRequest);

      when(() => mockNetworkClient.get(any())).thenAnswer((_) async {
        return const Left(mockResponse);
      });

      when(() => mockApiHeaderHandler.extractNextPage('next_link'))
          .thenReturn('-1');

      final result = await dataSource.fetchRepositoryIssues(
        ownerName: 'owner',
        repositoryName: 'repo',
      );

      expect(result.isLeft(), true);
    });

    test('should return a network exception on network failure', () async {
      const apiRequest = HttpApiRequest(
        method: HttpMethod.get,
        url: "$baseUrl/repos/owner/repo/issues",
        apiParam: ApiParam(),
      );
      when(() => mockApiRequestConstructor.constructApiRequest(
            method: HttpMethod.get,
            url: "$baseUrl/repos/owner/repo/issues",
            apiParam: any(named: 'apiParam'),
          )).thenReturn(apiRequest);

      when(() => mockNetworkClient.get(any())).thenAnswer((_) async {
        return const Right(NetworkException(404, 'Not Found'));
      });

      final result = await dataSource.fetchRepositoryIssues(
        ownerName: 'owner',
        repositoryName: 'repo',
      );

      expect(result.isRight(), true);
    });
  });
}
