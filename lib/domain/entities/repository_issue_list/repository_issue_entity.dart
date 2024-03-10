import 'package:equatable/equatable.dart';

class RepositoryIssueEntity extends Equatable {
  final int id;
  final String title;
  final int number;
  final String createdAt;
  final User user;

  const RepositoryIssueEntity({
    required this.id,
    required this.title,
    required this.number,
    required this.createdAt,
    required this.user,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        number,
        createdAt,
        user,
      ];
}

class User extends Equatable {
  final String name;

  const User({
    required this.name,
  });

  @override
  List<Object?> get props => [
        name,
      ];
}
