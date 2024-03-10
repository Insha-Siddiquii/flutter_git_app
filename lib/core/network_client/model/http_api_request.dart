import 'package:flutter_git_app/core/network_client/model/api_param.dart';
import 'package:flutter_git_app/core/network_client/util/http_method.dart';

class HttpApiRequest {
  final HttpMethod method;
  final String url;
  final ApiParam apiParam;
  final Map<String, dynamic>? headers;

  const HttpApiRequest({
    required this.method,
    required this.apiParam,
    required this.url,
    this.headers,
  });
}
