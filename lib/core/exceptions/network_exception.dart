import 'package:flutter_git_app/core/exceptions/base_exception.dart';

class NetworkException extends BaseException {
  final int httpCode;
  final String details;
  final String errorType;

  const NetworkException(this.httpCode, this.details,
      {this.errorType = 'INTERNAL_SERVER_ERROR'})
      : super('It is a network layer exception', errorType);

  @override
  List<Object?> get props => [message, type, httpCode, details];
}
