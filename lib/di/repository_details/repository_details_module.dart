import 'dart:async';

import 'package:flutter_git_app/core/modules/di_module.dart';
import 'package:flutter_git_app/core/network_client/network_client.dart';
import 'package:flutter_git_app/core/network_client/util/http_api_header_handler.dart';
import 'package:flutter_git_app/core/network_client/util/http_api_request_constructor.dart';
import 'package:flutter_git_app/datasources/remote/repository_issue_remote_data_source/fetch_repository_detail_remote_data_source_impl.dart';
import 'package:flutter_git_app/datasources/remote/repository_issue_remote_data_source/fetch_repository_issue_remote_data_source.dart';
import 'package:flutter_git_app/datasources/repositories/repository_issue_repository/fetch_repository_issue_repository_impl.dart';
import 'package:flutter_git_app/domain/repositories/repository_issue_repository/fetch_repository_issue_repository.dart';
import 'package:flutter_git_app/domain/usecases/repository_issue_usecase/fetch_repository_issue_usecase.dart';
import 'package:flutter_git_app/domain/usecases/repository_issue_usecase/fetch_repository_issue_usecase_impl.dart';
import 'package:flutter_git_app/presentation/features/repository_issues/bloc/bloc/repository_issues_bloc.dart';
import 'package:get_it/get_it.dart';

abstract class RepositoryIssueListModule extends DiModule {
  RepositoryIssueListBloc get repositoryIssueListBloc;
}

class RepositoryIssueListModuleImpl extends RepositoryIssueListModule {
  late RepositoryIssueListBloc _repositoryIssueListBloc;
  final getIt = GetIt.I;

  @override
  RepositoryIssueListBloc get repositoryIssueListBloc =>
      _repositoryIssueListBloc;

  @override
  FutureOr<void> setup() {
    final FetchRepositoryIssueRemoteDataSource dataSource =
        FetchRepositoryIssueRemoteDataSourceImpl(
      apiHeaderHandler: getIt.call<HttpApiHeaderHandler>(),
      networkClient: getIt.call<NetworkClient>(),
      apiRequestConstructor: getIt.call<HttpApiRequestConstructor>(),
    );

    final FetchRepositoryIssueRepository repository =
        FetchRepositoryIssueRepositoryImpl(
      dataSource: dataSource,
    );

    final FetchRepositoryIssueUseCase useCase = FetchRepositoryIssueUseCaseImpl(
      repository: repository,
    );

    _repositoryIssueListBloc = RepositoryIssueListBloc(useCase: useCase);

    GetIt.I
        .registerSingleton<RepositoryIssueListBloc>(_repositoryIssueListBloc);
  }

  @override
  void dispose() {
    getIt.get<RepositoryIssueListBloc>().close();
    getIt.unregister<RepositoryIssueListBloc>();
  }
}
