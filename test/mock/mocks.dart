import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_git_app/core/network_client/network_client.dart';
import 'package:flutter_git_app/core/network_client/util/http_api_header_handler.dart';
import 'package:flutter_git_app/core/network_client/util/http_api_request_constructor.dart';
import 'package:flutter_git_app/datasources/remote/repository_issue_remote_data_source/fetch_repository_issue_remote_data_source.dart';
import 'package:flutter_git_app/datasources/remote/repository_list_remote_data_source/fetch_repository_list_remote_data_source.dart';
import 'package:flutter_git_app/domain/repositories/repository_issue_repository/fetch_repository_issue_repository.dart';
import 'package:flutter_git_app/domain/repositories/repository_list_repository/fetch_repository_list_repository.dart';
import 'package:flutter_git_app/domain/usecases/repository_issue_usecase/fetch_repository_issue_usecase.dart';
import 'package:flutter_git_app/domain/usecases/repository_list_usecase/fetch_repository_list_usecase.dart';
import 'package:flutter_git_app/presentation/features/repository_list/bloc/repository_list_bloc.dart';
import 'package:flutter_git_app/presentation/features/repository_list/bloc/repository_list_bloc_event.dart';
import 'package:flutter_git_app/presentation/features/repository_list/bloc/repository_list_bloc_state.dart';
import 'package:mocktail/mocktail.dart';

class MockFetchRepositoryListUseCase extends Mock
    implements FetchRepositoryListUseCase {}

class MockFetchRepositoryIssueUseCase extends Mock
    implements FetchRepositoryIssueUseCase {}

class MockFetchRepositoryListRepository extends Mock
    implements FetchRepositoryListRepository {}

class MockFetchRepositoryIssueListRepository extends Mock
    implements FetchRepositoryIssueRepository {}

class MockFetchRepositoryListRemoteDataSource extends Mock
    implements FetchRepositoryListRemoteDataSource {}

class MockFetchRepositoryIssueListRemoteDataSource extends Mock
    implements FetchRepositoryIssueRemoteDataSource {}

class MockNetworkClient extends Mock implements NetworkClient {}

class MockHttpApiRequestConstructor extends Mock
    implements HttpApiRequestConstructor {}

class MockHttpApiHeaderHandler extends Mock implements HttpApiHeaderHandler {}

class MockRepositoryListBloc
    extends MockBloc<RepositoryListEvent, RepositoryListState>
    implements RepositoryListBloc {}
