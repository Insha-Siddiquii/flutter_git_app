import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'repository_issue_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RepositoryIssueModel extends Equatable {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'number')
  final int number;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'user')
  final User user;

  const RepositoryIssueModel({
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

  factory RepositoryIssueModel.fromJson(Map<String, dynamic> json) =>
      _$RepositoryIssueModelFromJson(json);

  Map<String, dynamic> toJson() => _$RepositoryIssueModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class User extends Equatable {
  @JsonKey(name: 'login')
  final String name;

  const User({
    required this.name,
  });

  @override
  List<Object?> get props => [
        name,
      ];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
