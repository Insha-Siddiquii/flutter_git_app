abstract class RepositoryListEvent {}

class GetRepositoryListEvent extends RepositoryListEvent {
  final String searchTerm;

  GetRepositoryListEvent({
    required this.searchTerm,
  });
}

class GetRepositoryListNextPageEvent extends RepositoryListEvent {
  final String searchTerm;

  GetRepositoryListNextPageEvent({
    required this.searchTerm,
  });
}

class ReloadRepositoryListEvent extends RepositoryListEvent {
  final String searchTerm;

  ReloadRepositoryListEvent({
    required this.searchTerm,
  });
}
