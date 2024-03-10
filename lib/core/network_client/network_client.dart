import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_git_app/core/exceptions/base_exception.dart';
import 'package:flutter_git_app/core/network_client/model/http_api_request.dart';

typedef HttpResponse = Map<String, dynamic>;

class NetworkResponse extends Equatable {
  final HttpResponse data;
  final int statusCode;
  final Map<String, String> headers;

  const NetworkResponse({
    required this.data,
    required this.statusCode,
    this.headers = const {},
  });

  @override
  List<Object?> get props => [data, statusCode, headers];
}

abstract class NetworkClient {
  Future<Either<NetworkResponse, BaseException>> get(HttpApiRequest apiRequest);
}
