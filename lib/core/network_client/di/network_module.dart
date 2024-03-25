import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_git_app/core/modules/di_module.dart';
import 'package:flutter_git_app/core/network_client/dio_network_client.dart';
import 'package:flutter_git_app/core/network_client/network_client.dart';
import 'package:flutter_git_app/core/network_client/util/http_api_header_handler.dart';
import 'package:flutter_git_app/core/network_client/util/http_api_request_constructor.dart';
import 'package:get_it/get_it.dart';

class NetworkModule extends DiModule {
  final getIt = GetIt.I;
  @override
  FutureOr<void> setup() {
    final dio = Dio();
    final NetworkClient client = DioNetworkClientImpl(
      dio,
    );
    getIt.registerLazySingleton<HttpApiHeaderHandler>(
      HttpApiHeaderHandlerImpl.new,
    );

    getIt.registerLazySingleton<NetworkClient>(() => client);

    getIt.registerLazySingleton<HttpApiRequestConstructor>(
      HttpApiRequestConstructorImpl.new,
    );
  }
}
