import 'package:flutter/material.dart';
import 'package:flutter_git_app/presentation/features/common/smart_refresher/loading_footer.dart';
import 'package:flutter_git_app/presentation/features/common/smart_refresher/loading_header.dart';
import 'package:flutter_git_app/presentation/features/repository_issues/bloc/bloc/repository_issues_state.dart';
import 'package:flutter_git_app/presentation/features/repository_issues/ui/widgets/respository_issue_list_item_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RepositoryIssueListWidget extends StatelessWidget {
  final RefreshController refreshController;
  final RepositoryIssueListState state;
  final void Function() onPullToRefresh;
  final void Function() onNextPageRequest;
  const RepositoryIssueListWidget({
    required this.state,
    required this.refreshController,
    required this.onPullToRefresh,
    required this.onNextPageRequest,
    super.key,
  });

  bool _enablePullDown() => state is! RepositoryIssueListLoadingNextPageState;

  bool _enablePullUp() =>
      state is! RepositoryIssueListReloadingState && state.isLastPage == false;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      enablePullDown: _enablePullDown(),
      enablePullUp: _enablePullUp(),
      onRefresh: onPullToRefresh,
      onLoading: onNextPageRequest,
      header: CustomHeader(
        builder: (context, mode) => const LoadingHeaderWidget(),
      ),
      footer: CustomFooter(
        builder: (context, status) => LoadingFooter(status: status),
      ),
      child: ListView.builder(
        itemCount: state.repositoryIssueList.length,
        itemBuilder: (context, index) => RepositoryIssueListItemWidget(
          itemUiEntity: state.repositoryIssueList[index],
        ),
      ),
    );
  }
}
