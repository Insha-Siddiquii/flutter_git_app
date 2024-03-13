import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_git_app/core/exceptions/base_exception.dart';
import 'package:flutter_git_app/core/exceptions/network_exception.dart';
import 'package:flutter_git_app/core/exceptions/network_timeout_exception.dart';
import 'package:flutter_git_app/core/exceptions/unknown_network_exception.dart';
import 'package:flutter_git_app/core/network_client/model/http_api_request.dart';
import 'package:flutter_git_app/core/network_client/network_client.dart';

class DioNetworkClientImpl extends NetworkClient {
  final Dio _dio;

  DioNetworkClientImpl(
    this._dio,
  );

  @override
  @visibleForTesting
  Future<Either<NetworkResponse, BaseException>> get(
      HttpApiRequest apiRequest) async {
    try {
      final response = await _dio.get(apiRequest.url,
          queryParameters: apiRequest.apiParam.queryParams,
          options: Options(
            headers: apiRequest.headers,
          ));
      return _onRequestResponse(response);
    } on DioException catch (exception) {
      return _onExceptionResponse(exception);
    }
  }

  Either<NetworkResponse, BaseException> _onExceptionResponse(
      DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Right(
          NetworkTimeOutException(
            error.message!,
          ),
        );
      default:
        break;
    }
    return const Right(
      UnknownNetworkException(
        "Error happened while handling the error response",
      ),
    );
  }

  Either<NetworkResponse, BaseException> _onRequestResponse(
      Response<dynamic> response) {
    final HttpResponse data =
        response.data is Map ? response.data : {'items': response.data ?? ''};
    if (response.statusCode != null && response.statusCode! == 200) {
      return Left(
        NetworkResponse(
          data: data,
          statusCode: response.statusCode!,
          headers: response.headers.map.map(
            (key, value) => MapEntry(key, value.isNotEmpty ? value.first : ''),
          ),
        ),
      );
    } else {
      return Right(
        NetworkException(
          response.statusCode ?? -1,
          "It is a network exception",
        ),
      );
    }
  }
}
