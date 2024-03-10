// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_issue_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepositoryIssueModel _$RepositoryIssueModelFromJson(
        Map<String, dynamic> json) =>
    RepositoryIssueModel(
      id: json['id'] as int,
      title: json['title'] as String,
      number: json['number'] as int,
      createdAt: json['created_at'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RepositoryIssueModelToJson(
        RepositoryIssueModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'number': instance.number,
      'created_at': instance.createdAt,
      'user': instance.user.toJson(),
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['login'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'login': instance.name,
    };
