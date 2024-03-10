import 'package:flutter_git_app/core/network_client/model/api_param.dart';
import 'package:flutter_git_app/core/network_client/model/http_api_request.dart';
import 'package:flutter_git_app/core/network_client/util/http_method.dart';

abstract class HttpApiRequestConstructor {
  HttpApiRequest constructApiRequest({
    required HttpMethod method,
    required String url,
    required ApiParam apiParam,
  });
}

class HttpApiRequestConstructorImpl implements HttpApiRequestConstructor {
  @override
  HttpApiRequest constructApiRequest({
    required HttpMethod method,
    required String url,
    required ApiParam apiParam,
  }) {
    return HttpApiRequest(
      method: method,
      url: url,
      apiParam: apiParam,
    );
  }
}
