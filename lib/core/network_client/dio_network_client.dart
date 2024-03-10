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
  Future<Either<HttpResponse, BaseException>> get(
      HttpApiRequest apiRequest) async {
    try {
      final response = await _dio.get(
        apiRequest.url,
        queryParameters: apiRequest.apiParam.queryParams,
      );
      return _onRequestResponse(response);
    } on DioException catch (e) {
      return _onExceptionResponse(e);
    }
  }

  Either<HttpResponse, BaseException> _onExceptionResponse(DioException error) {
    if (error.response != null) {
      return _onRequestResponse(error.response!);
    } else {
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
    }
    return Right(
      UnknownNetworkException(
        {
          'message': 'Error happened while handling the error response',
          'type': error.type.name,
          'details': error.message,
        },
      ),
    );
  }

  Either<HttpResponse, BaseException> _onRequestResponse(
      Response<dynamic> response) {
    final HttpResponse data =
        response.data is Map ? response.data : {'data': response.data ?? ''};
    if (response.statusCode != null && response.statusCode! == 200) {
      return Left(data);
    } else {
      return Right(NetworkException(response.statusCode ?? -1, data));
    }
  }
}
