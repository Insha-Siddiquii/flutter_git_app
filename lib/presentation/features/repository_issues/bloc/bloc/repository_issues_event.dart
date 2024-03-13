abstract class RepositoryIssueListEvent {}

class GetRepositoryIssueListEvent extends RepositoryIssueListEvent {
  final String ownerName;
  final String repositoryName;

  GetRepositoryIssueListEvent({
    required this.ownerName,
    required this.repositoryName,
  });
}

class GetRepositoryIssueListNextPageEvent extends RepositoryIssueListEvent {
  final String ownerName;
  final String repositoryName;

  GetRepositoryIssueListNextPageEvent({
    required this.ownerName,
    required this.repositoryName,
  });
}

class ReloadRepositoryIssueListEvent extends RepositoryIssueListEvent {
  final String ownerName;
  final String repositoryName;

  ReloadRepositoryIssueListEvent({
    required this.ownerName,
    required this.repositoryName,
  });
}
