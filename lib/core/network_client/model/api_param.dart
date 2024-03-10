import 'package:equatable/equatable.dart';

class ApiParam extends Equatable {
  final Map<String, dynamic>? queryParams;

  const ApiParam({
    this.queryParams,
  });

  @override
  List<Object?> get props => [
        queryParams,
      ];

  ApiParam copyWith({
    Map<String, dynamic>? queryParams,
  }) {
    return ApiParam(
      queryParams: queryParams ?? this.queryParams,
    );
  }
}
