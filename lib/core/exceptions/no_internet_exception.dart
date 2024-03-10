import 'package:flutter_git_app/core/exceptions/base_exception.dart';

class NoInternetException extends BaseException {
  const NoInternetException()
      : super('Internet connection is unavailable', 'OFFLINE');
}
