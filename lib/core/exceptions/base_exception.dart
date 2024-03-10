import 'package:equatable/equatable.dart';

abstract class BaseException extends Equatable {
  final String message;

  final String type;

  const BaseException(this.message, this.type);

  @override
  String toString() {
    return message;
  }

  @override
  List<Object?> get props => [message, type];
}
