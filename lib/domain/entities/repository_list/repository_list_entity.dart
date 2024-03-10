import 'package:equatable/equatable.dart';

class RepositoryListEntity extends Equatable {
  final int id;
  final String name;
  final String ownerName;
  final String description;
  final String language;
  final int openIssuesCount;

  const RepositoryListEntity({
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
}
