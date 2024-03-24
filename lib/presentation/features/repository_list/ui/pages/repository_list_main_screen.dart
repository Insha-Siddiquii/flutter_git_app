import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_git_app/di/repository_list/repository_list_module.dart';
import 'package:flutter_git_app/presentation/features/common/widgets/app_empty_screen.dart';
import 'package:flutter_git_app/presentation/features/common/widgets/app_error_screen.dart';
import 'package:flutter_git_app/presentation/features/common/widgets/app_loading_indicator.dart';
import 'package:flutter_git_app/presentation/features/repository_issues/ui/pages/repository_issue_list_main_screen.dart';
import 'package:flutter_git_app/presentation/features/repository_list/bloc/repository_list_bloc.dart';
import 'package:flutter_git_app/presentation/features/repository_list/bloc/repository_list_bloc_event.dart';
import 'package:flutter_git_app/presentation/features/repository_list/bloc/repository_list_bloc_state.dart';
import 'package:flutter_git_app/presentation/features/repository_list/ui/widgets/repository_list_widget.dart';
import 'package:flutter_git_app/presentation/utils/ui_constants.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RepositoryListMainScreen extends StatefulWidget {
  final RepositoryListModule? repositoryListModule;
  const RepositoryListMainScreen({
    this.repositoryListModule,
    super.key,
  });

  @override
  State<RepositoryListMainScreen> createState() =>
      _RepositoryListMainScreenState();
}

class _RepositoryListMainScreenState extends State<RepositoryListMainScreen> {
  final TextEditingController controller = TextEditingController();
  late RepositoryListModule _repositoryListModule;
  late RepositoryListBloc _bloc;
  late RefreshController _refreshController;

  @override
  void initState() {
    _initDependencies();
    super.initState();
  }

  void _initDependencies() {
    _repositoryListModule =
        widget.repositoryListModule ?? RepositoryListModuleImpl();
    _repositoryListModule.setup();
    _bloc = _repositoryListModule.repositoryListBloc;
    _refreshController = RefreshController(initialRefresh: false);
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _repositoryListModule.dispose();
    super.dispose();
  }

  void _fetchRepositoryList(String searchTerm) {
    _bloc.add(GetRepositoryListEvent(searchTerm: searchTerm));
  }

  void _isSearchTrigger(String value) {
    if (value.length >= 4) {
      _fetchRepositoryList(value);
    }
  }

  void _fetchNextPage() => _bloc.add(GetRepositoryListNextPageEvent(
        searchTerm: controller.text,
      ));

  void _reloadRepository() => _bloc.add(ReloadRepositoryListEvent(
        searchTerm: controller.text,
      ));

  void _onRepositoryListBlocStateChanged(
    BuildContext context,
    RepositoryListState state,
  ) {
    if (state is RepositoryListLoadedState) {
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
        backgroundColor: backgroundColor,
        title: const Text(
          'Repositories',
          style: TextStyle(
            color: onBackgroundSurface,
          ),
        ),
      ),
      body: SafeArea(
        child: RepositoryProvider(
          create: (context) => _repositoryListModule,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 16.0,
            ),
            child: Column(
              children: [
                /// Search field
                TextField(
                  controller: controller,
                  cursorColor: onBackgroundSurface,
                  style: const TextStyle(
                    color: onBackgroundSurface,
                  ),
                  decoration: const InputDecoration(
                    focusColor: onBackgroundSurface,
                    labelText: 'Find a repository...',
                    labelStyle: TextStyle(
                      color: onBackgroundSurface,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: onBackgroundSurface,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: onBackgroundSurface,
                      ),
                    ),
                    hoverColor: onBackgroundSurface,
                  ),
                  onChanged: (value) => _isSearchTrigger(value),
                ),

                const SizedBox(
                  height: 16,
                ),

                const Divider(
                  color: onBackgroundSurface,
                ),

                const SizedBox(
                  height: 16,
                ),

                BlocConsumer<RepositoryListBloc, RepositoryListState>(
                  bloc: _bloc,
                  listener: _onRepositoryListBlocStateChanged,
                  builder: (context, state) {
                    if (state is RepositoryListInitialState) {
                      return AppEmptyScreen(
                        message: state.message,
                      );
                    } else if (state is RepositoryListErrorState) {
                      return AppErrorScreen(
                        onPressed: () => _fetchRepositoryList(controller.text),
                        errorMessage: state.errorMessage,
                      );
                    } else if (state is RepositoryListEmptyState) {
                      return AppEmptyScreen(
                        message: state.message,
                      );
                    } else if (state is RepositoryListLoadingState) {
                      return const AppLoadingIndicator();
                    } else {
                      return RepositoryListWidget(
                        state: state,
                        refreshController: _refreshController,
                        onPullToRefresh: _reloadRepository,
                        onNextPageRequest: _fetchNextPage,
                        onTap: (ownerName, repositoryName) =>
                            Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                RepositoryIssueListMainScreen(
                              ownerName: ownerName,
                              repositoryName: repositoryName,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
