import 'package:equatable/equatable.dart';
import 'package:flutter_git_app/domain/entities/repository_list/repository_list_entity.dart';

class RepositoryListUiEntity extends Equatable {
  final int id;
  final String name;
  final String ownerName;
  final String description;
  final String language;
  final int openIssuesCount;

  const RepositoryListUiEntity({
    required this.id,
    required this.name,
    required this.ownerName,
    required this.description,
    required this.language,
    required this.openIssuesCount,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        ownerName,
        description,
        language,
        openIssuesCount,
      ];

  factory RepositoryListUiEntity.copyFrom(RepositoryListEntity entity) {
    return RepositoryListUiEntity(
      id: entity.id,
      name: entity.name,
      ownerName: entity.ownerName,
      description: entity.description,
      language: entity.description,
      openIssuesCount: entity.openIssuesCount,
    );
  }
}
