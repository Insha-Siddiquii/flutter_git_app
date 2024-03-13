// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepositoryListModel _$RepositoryListModelFromJson(Map<String, dynamic> json) =>
    RepositoryListModel(
      id: json['id'] as int,
      name: json['name'] as String,
      fullName: json['full_name'] as String,
      description: json['description'] as String?,
      language: json['language'] as String?,
      openIssuesCount: json['open_issues_count'] as int,
    );

Map<String, dynamic> _$RepositoryListModelToJson(
        RepositoryListModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'full_name': instance.fullName,
      'description': instance.description,
      'language': instance.language,
      'open_issues_count': instance.openIssuesCount,
    };
