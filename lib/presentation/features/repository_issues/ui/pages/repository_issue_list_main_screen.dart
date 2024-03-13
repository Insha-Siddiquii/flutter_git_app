import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_git_app/di/repository_details/repository_details_module.dart';
import 'package:flutter_git_app/presentation/features/common/widgets/app_empty_screen.dart';
import 'package:flutter_git_app/presentation/features/common/widgets/app_error_screen.dart';
import 'package:flutter_git_app/presentation/features/common/widgets/app_loading_indicator.dart';
import 'package:flutter_git_app/presentation/features/repository_issues/bloc/bloc/repository_issues_bloc.dart';
import 'package:flutter_git_app/presentation/features/repository_issues/bloc/bloc/repository_issues_event.dart';
import 'package:flutter_git_app/presentation/features/repository_issues/bloc/bloc/repository_issues_state.dart';
import 'package:flutter_git_app/presentation/features/repository_issues/ui/widgets/repository_issue_list_widget.dart';
import 'package:flutter_git_app/presentation/utils/ui_constants.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RepositoryIssueListMainScreen extends StatefulWidget {
  final String ownerName;
  final String repositoryName;
  const RepositoryIssueListMainScreen({
    super.key,
    required this.ownerName,
    required this.repositoryName,
  });

  @override
  State<RepositoryIssueListMainScreen> createState() =>
      _RepositoryIssueListMainScreenState();
}

class _RepositoryIssueListMainScreenState
    extends State<RepositoryIssueListMainScreen> {
  late RepositoryIssueListModule _module;
  late RepositoryIssueListBloc _bloc;
  late RefreshController _refreshController;
  late String ownerName;
  late String repositoryName;

  @override
  void initState() {
    _initDependencies();
    ownerName = widget.ownerName;
    repositoryName = widget.repositoryName;
    _fetchRepositoryIssueList();
    super.initState();
  }

  void _initDependencies() {
    _module = RepositoryIssueListModuleImpl();
    _module.setup();
    _bloc = _module.repositoryIssueListBloc;
    _refreshController = RefreshController(initialRefresh: false);
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _module.dispose();
    super.dispose();
  }

  void _fetchRepositoryIssueList() {
    _bloc.add(GetRepositoryIssueListEvent(
      ownerName: ownerName,
      repositoryName: repositoryName,
    ));
  }

  void _fetchNextPage() => _bloc.add(GetRepositoryIssueListNextPageEvent(
        ownerName: ownerName,
        repositoryName: repositoryName,
      ));

  void _reloadRepositoryIssues() => _bloc.add(ReloadRepositoryIssueListEvent(
        ownerName: ownerName,
        repositoryName: repositoryName,
      ));

  void _onRepositoryIssueListBlocStateChanged(
    BuildContext context,
    RepositoryIssueListState state,
  ) {
    if (state is RepositoryIssueListLoadedState) {
      if (_refreshController.isLoading) {
        _refreshController.loadComplete();
      }
      if (_refreshController.isRefresh) {
        _refreshController.refreshCompleted();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        surfaceTintColor: backgroundColor,
        iconTheme: const IconThemeData(
          color: onBackgroundSurface,
        ),
        backgroundColor: backgroundColor,
        title: const Text(
          'Repository Issues',
          style: TextStyle(
            color: onBackgroundSurface,
          ),
        ),
      ),
      body: SafeArea(
        child: RepositoryProvider(
          create: (context) => _module,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 16.0,
            ),
            child:
                BlocConsumer<RepositoryIssueListBloc, RepositoryIssueListState>(
              bloc: _bloc,
              listener: _onRepositoryIssueListBlocStateChanged,
              builder: (context, state) {
                if (state is RepositoryIssueListLoadingState) {
                  return const AppLoadingIndicator();
                } else if (state is RepositoryIssueListEmptyState) {
                  return AppEmptyScreen(
                    message: state.message,
                  );
                } else if (state is RepositoryIssueListErrorState) {
                  return AppErrorScreen(
                    onPressed: () => _fetchRepositoryIssueList(),
                    errorMessage: state.errorMessage,
                  );
                } else {
                  return RepositoryIssueListWidget(
                    state: state,
                    refreshController: _refreshController,
                    onPullToRefresh: _reloadRepositoryIssues,
                    onNextPageRequest: _fetchNextPage,
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
