import 'package:equatable/equatable.dart';
import 'package:flutter_git_app/domain/entities/repository_issue_list/repository_issue_entity.dart';

class RepositoryIssueUiEntity extends Equatable {
  final int id;
  final String title;
  final int number;
  final String createdAt;
  final String userName;

  const RepositoryIssueUiEntity({
    required this.id,
    required this.title,
    required this.number,
    required this.createdAt,
    required this.userName,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        number,
        createdAt,
        userName,
      ];
  factory RepositoryIssueUiEntity.copyFrom(RepositoryIssueEntity entity) {
    return RepositoryIssueUiEntity(
      id: entity.id,
      title: entity.title,
      number: entity.number,
      createdAt: entity.createdAt,
      userName: entity.user.name,
    );
  }
}
