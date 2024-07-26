abstract class OnPullToRefresh {
  void call();
}

abstract class OnTap {
  void call(
    String ownerName,
    String repositoryName,
  );
}

abstract class OnNextPageRequest {
  void call();
}
