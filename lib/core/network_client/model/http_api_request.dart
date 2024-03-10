import 'package:flutter_git_app/core/network_client/model/api_param.dart';
import 'package:flutter_git_app/core/network_client/util/http_method.dart';

abstract class HttpApiRequest {
  HttpMethod method = HttpMethod.get;
  late String url;
  ApiParam apiParam = const ApiParam();
}
