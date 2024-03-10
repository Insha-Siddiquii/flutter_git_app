import 'package:flutter_git_app/core/exceptions/base_exception.dart';

class NetworkTimeOutException extends BaseException {
  const NetworkTimeOutException(String message)
      : super(message, 'TIMEOUT_EXCEPTION');
}
