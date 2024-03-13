import 'dart:async';

import 'package:flutter_git_app/core/modules/di_module.dart';
import 'package:flutter_git_app/core/network_client/network_client.dart';
import 'package:flutter_git_app/core/network_client/util/http_api_header_handler.dart';
import 'package:flutter_git_app/core/network_client/util/http_api_request_constructor.dart';
import 'package:flutter_git_app/datasources/remote/repository_list_remote_data_source/fetch_repository_list_remote_data_source.dart';
import 'package:flutter_git_app/datasources/remote/repository_list_remote_data_source/fetch_repository_list_remote_data_source_impl.dart';
import 'package:flutter_git_app/datasources/repositories/repository_list_repository/fetch_repository_list_repository_impl.dart';
import 'package:flutter_git_app/domain/repositories/repository_list_repository/fetch_repository_list_repository.dart';
import 'package:flutter_git_app/domain/usecases/repository_list_usecase/fetch_repository_list_usecase.dart';
import 'package:flutter_git_app/domain/usecases/repository_list_usecase/fetch_repository_list_usecase_impl.dart';
import 'package:flutter_git_app/presentation/features/repository_list/bloc/repository_list_bloc.dart';
import 'package:get_it/get_it.dart';

abstract class RepositoryListModule extends DiModule {
  RepositoryListBloc get repositoryListBloc;
}

class RepositoryListModuleImpl extends RepositoryListModule {
  late RepositoryListBloc _repositoryListBloc;
  final getIt = GetIt.I;

  @override
  RepositoryListBloc get repositoryListBloc => _repositoryListBloc;

  @override
  FutureOr<void> setup() {
    final FetchRepositoryListRemoteDataSource dataSource =
        FetchRepositoryListRemoteDataSourceImpl(
      apiHeaderHandler: getIt.call<HttpApiHeaderHandler>(),
      networkClient: getIt.call<NetworkClient>(),
      apiRequestConstructor: getIt.call<HttpApiRequestConstructor>(),
    );

    final FetchRepositoryListRepository repository =
        FetchRepositoryListRepositoryImpl(
      dataSource: dataSource,
    );

    final FetchRepositoryListUseCase useCase = FetchRepositoryListUseCaseImpl(
      repository: repository,
    );

    _repositoryListBloc = RepositoryListBloc(useCase: useCase);

    GetIt.I.registerSingleton<RepositoryListBloc>(_repositoryListBloc);
  }

  @override
  void dispose() {
    getIt.get<RepositoryListBloc>().close();
    getIt.unregister<RepositoryListBloc>();
  }
}
