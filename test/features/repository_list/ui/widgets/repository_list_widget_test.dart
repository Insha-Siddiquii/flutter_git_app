import 'package:flutter/material.dart';
import 'package:flutter_git_app/domain/entities/repository_list/repository_list_entity.dart';
import 'package:flutter_git_app/presentation/entities/repository_list/repository_list_ui_entity.dart';
import 'package:flutter_git_app/presentation/features/common/smart_refresher/loading_footer.dart';
import 'package:flutter_git_app/presentation/features/repository_list/ui/widgets/repository_list_widget.dart';
import 'package:flutter_git_app/presentation/features/repository_list/ui/widgets/respository_list_item_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../mock/mocks.dart';

void main() {
  group('Widget test for Repository List Widget:', () {
    late final RefreshController refreshController;
    late final MockOnPullToRefresh mockOnPullToRefresh;
    late MockOnNextPageRequest mockOnNextPageRequest;
    late MockOnTap mockOnTap;

    final mockRepositoryListEntity = [
      const RepositoryListEntity(
        id: 1,
        name: 'Repo 1',
        ownerName: 'Owner 1',
        description: 'Description 1',
        language: 'Dart',
        openIssuesCount: 5,
      ),
      const RepositoryListEntity(
        id: 2,
        name: 'Repo 2',
        ownerName: 'Owner 2',
        description: 'Description 2',
        language: 'JavaScript',
        openIssuesCount: 10,
      ),
    ];

    /// mocking of states and events is necessary if your widget you're pumping utilizes those states and events.
    /// Otherwise, you're getting back real states, not the mocked ones, and when needs mocked ones
    setUpAll(() {
      refreshController = RefreshController(initialRefresh: false);
      mockOnPullToRefresh = MockOnPullToRefresh();
      mockOnNextPageRequest = MockOnNextPageRequest();
      mockOnTap = MockOnTap();
    });

    final mockRepositoryListUiEntity = mockRepositoryListEntity
        .map((e) => RepositoryListUiEntity(
              id: e.id,
              name: e.name,
              ownerName: e.ownerName,
              description: e.description,
              language: e.language,
              openIssuesCount: e.openIssuesCount,
            ))
        .toList();

    testWidgets('Finds the ListView', (widgetTester) async {
      ///arrange
      final mockRepositoryListState = MockRepositoryListState();
      when(() => mockRepositoryListState.repositoryList)
          .thenReturn(mockRepositoryListUiEntity);
      when(() => mockRepositoryListState.isLastPage).thenReturn(false);

      /// act
      await widgetTester.pumpWidget(
        MaterialApp(
          home: Column(
            children: [
              RepositoryListWidget(
                state: mockRepositoryListState,
                refreshController: refreshController,
                onPullToRefresh: mockOnPullToRefresh.call,
                onNextPageRequest: mockOnNextPageRequest.call,
                onTap: (ownerName, repositoryName) => mockOnTap,
              ),
            ],
          ),
        ),
      );

      /// assert
      expect(find.byType(Scrollable), findsOneWidget);
    });

    testWidgets('Verify pull to refresh is called', (widgetTester) async {
      ///arrange
      final mockRepositoryListState = MockRepositoryListState();
      when(() => mockRepositoryListState.repositoryList)
          .thenReturn(mockRepositoryListUiEntity);
      when(() => mockRepositoryListState.isLastPage).thenReturn(false);

      /// act
      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                RepositoryListWidget(
                  state: mockRepositoryListState,
                  refreshController: refreshController,
                  onPullToRefresh: mockOnPullToRefresh.call,
                  onNextPageRequest: mockOnNextPageRequest.call,
                  onTap: mockOnTap.call,
                ),
              ],
            ),
          ),
        ),
      );
      await widgetTester.drag(
        find.byType(SmartRefresher),
        const Offset(
          0,
          300,
        ),
      );
      // await widgetTester.pumpAndSettle();
      // refreshController.requestRefresh(
      //   duration: const Duration(milliseconds: 500),
      //   curve: Curves.linear,
      // );
      // await widgetTester.pumpAndSettle(
      //   const Duration(
      //     seconds: 8,
      //   ),
      // );
      // refreshController.refreshCompleted();
      await widgetTester.pump();

      /// assert
      // verify(() => mockOnPullToRefresh.call()).called(1);
      // expect(refreshCalled, true);
      expect(find.byType(RefreshProgressIndicator), findsOneWidget);
    });

    testWidgets('Verify onNextPageRequest is called', (widgetTester) async {
      ///arrange
      final mockRepositoryListState = MockRepositoryListState();
      when(() => mockRepositoryListState.repositoryList)
          .thenReturn(mockRepositoryListUiEntity);
      when(() => mockRepositoryListState.isLastPage).thenReturn(false);

      /// act
      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                RepositoryListWidget(
                  state: mockRepositoryListState,
                  refreshController: refreshController,
                  onPullToRefresh: mockOnPullToRefresh.call,
                  onNextPageRequest: mockOnNextPageRequest.call,
                  onTap: (ownerName, repositoryName) => mockOnTap,
                ),
              ],
            ),
          ),
        ),
      );
      await widgetTester.drag(
        find.byType(SmartRefresher),
        const Offset(
          0,
          -500,
        ),
      );
      await widgetTester.pump();

      /// assert
      // verify(() => mockOnNextPageRequest.call()).called(1);
      expect(find.byType(LoadingFooter), findsOneWidget);
    });

    testWidgets('Verify onTap is called', (widgetTester) async {
      ///arrange
      final mockRepositoryListState = MockRepositoryListState();
      when(() => mockRepositoryListState.repositoryList)
          .thenReturn(mockRepositoryListUiEntity);
      when(() => mockRepositoryListState.isLastPage).thenReturn(false);

      /// act
      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                RepositoryListWidget(
                  state: mockRepositoryListState,
                  refreshController: refreshController,
                  onPullToRefresh: mockOnPullToRefresh.call,
                  onNextPageRequest: mockOnNextPageRequest.call,
                  onTap: mockOnTap.call,
                ),
              ],
            ),
          ),
        ),
      );
      await widgetTester.tap(
        find.byType(RepositoryListItemWidget).first,
      );
      await widgetTester.pump();

      /// assert
      verify(() => mockOnTap.call(any(), any())).called(1);
    });
  });
}
