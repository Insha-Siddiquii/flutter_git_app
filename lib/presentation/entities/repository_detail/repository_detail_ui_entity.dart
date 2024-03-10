import 'package:equatable/equatable.dart';
import 'package:flutter_git_app/domain/entities/repository_issue_list/repository_issue_entity.dart';

class RepositoryDetailUiEntity extends Equatable {
  final int id;
  final String title;
  final int number;
  final String createdAt;
  final String userName;

  const RepositoryDetailUiEntity({
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
  factory RepositoryDetailUiEntity.copyFrom(RepositoryIssueEntity entity) {
    return RepositoryDetailUiEntity(
      id: entity.id,
      title: entity.title,
      number: entity.number,
      createdAt: entity.createdAt,
      userName: entity.user.name,
    );
  }
}
