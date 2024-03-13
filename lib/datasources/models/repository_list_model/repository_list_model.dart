import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'repository_list_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RepositoryListModel extends Equatable {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'full_name')
  final String fullName;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'language')
  final String? language;
  @JsonKey(name: 'open_issues_count')
  final int openIssuesCount;

  const RepositoryListModel({
    required this.id,
    required this.name,
    required this.fullName,
    required this.description,
    required this.language,
    required this.openIssuesCount,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        fullName,
        description,
        language,
        openIssuesCount,
      ];

  factory RepositoryListModel.fromJson(Map<String, dynamic> json) =>
      _$RepositoryListModelFromJson(json);

  Map<String, dynamic> toJson() => _$RepositoryListModelToJson(this);
}
