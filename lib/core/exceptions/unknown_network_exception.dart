import 'package:flutter_git_app/core/exceptions/network_exception.dart';

const unknownNetworkException = 'UNKNOWN_NETWORK_ERROR';

class UnknownNetworkException extends NetworkException {
  const UnknownNetworkException(String message)
      : super(-1, message, errorType: unknownNetworkException);
}
