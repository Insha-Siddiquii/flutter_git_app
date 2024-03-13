import 'package:flutter/material.dart';
import 'package:flutter_git_app/presentation/features/common/smart_refresher/loading_footer.dart';
import 'package:flutter_git_app/presentation/features/common/smart_refresher/loading_header.dart';
import 'package:flutter_git_app/presentation/features/repository_list/bloc/repository_list_bloc_state.dart';
import 'package:flutter_git_app/presentation/features/repository_list/ui/widgets/respository_list_item_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RepositoryListWidget extends StatelessWidget {
  final RefreshController refreshController;
  final RepositoryListState state;
  final void Function() onPullToRefresh;
  final void Function() onNextPageRequest;
  final void Function(
    String ownerName,
    String repositoryName,
  ) onTap;

  const RepositoryListWidget({
    required this.state,
    required this.refreshController,
    required this.onPullToRefresh,
    required this.onNextPageRequest,
    required this.onTap,
    super.key,
  });

  bool _enablePullDown() => state is! RepositoryListLoadingNextPageState;

  bool _enablePullUp() =>
      state is! RepositoryListReloadingState && state.isLastPage == false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SmartRefresher(
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
          itemCount: state.repositoryList.length,
          itemBuilder: (context, index) => RepositoryListItemWidget(
            repositoryListUiEntity: state.repositoryList[index],
            onTap: () => onTap(
              state.repositoryList[index].ownerName,
              state.repositoryList[index].name,
            ),
          ),
        ),
      ),
    );
  }
}
