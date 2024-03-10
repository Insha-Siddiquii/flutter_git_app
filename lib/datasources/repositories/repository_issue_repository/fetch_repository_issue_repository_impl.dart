import 'package:dartz/dartz.dart';
import 'package:flutter_git_app/core/exceptions/base_exception.dart';
import 'package:flutter_git_app/datasources/remote/repository_issue_remote_data_source/fetch_repository_issue_remote_data_source.dart';
import 'package:flutter_git_app/domain/entities/repository_issue_list/repository_issue_entity.dart';
import 'package:flutter_git_app/domain/repositories/repository_issue_repository/fetch_repository_issue_repository.dart';
import 'package:intl/intl.dart';

class FetchRepositoryIssueRepositoryImpl
    implements FetchRepositoryIssueRepository {
  final FetchRepositoryIssueRemoteDataSource dataSource;

  const FetchRepositoryIssueRepositoryImpl({required this.dataSource});

  @override
  Future<Either<List<RepositoryIssueEntity>, BaseException>>
      fetchRepositoryIssues(
          {required String ownerName, required String repositoryName}) async {
    final response = await dataSource.fetchRepositoryIssues(
      ownerName: ownerName,
      repositoryName: repositoryName,
    );

    return response.bimap((data) {
      return data.map((model) {
        return RepositoryIssueEntity(
          id: model.id,
          title: model.title,
          number: model.number,
          createdAt: formatDateTime(model.createdAt),
          user: User(
            name: model.user.name,
          ),
        );
      }).toList();
    }, (exception) => exception);
  }

  String formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    Duration difference = DateTime.now().difference(dateTime);

    if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays == 1) {
      return 'yesterday';
    } else {
      return DateFormat('yyyy-MM-dd').format(dateTime);
    }
  }
}
