import 'package:flutter/material.dart';
import 'package:flutter_git_app/domain/entities/repository_list/repository_list_entity.dart';
import 'package:flutter_git_app/presentation/entities/repository_list/repository_list_ui_entity.dart';
import 'package:flutter_git_app/presentation/features/common/widgets/app_empty_screen.dart';
import 'package:flutter_git_app/presentation/features/common/widgets/app_error_screen.dart';
import 'package:flutter_git_app/presentation/features/common/widgets/app_loading_indicator.dart';
import 'package:flutter_git_app/presentation/features/repository_list/bloc/repository_list_bloc_state.dart';
import 'package:flutter_git_app/presentation/features/repository_list/ui/pages/repository_list_main_screen.dart';
import 'package:flutter_git_app/presentation/features/repository_list/ui/widgets/repository_list_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fake/fake.dart';
import '../../../../mock/mocks.dart';

void main() {
  LiveTestWidgetsFlutterBinding();
  group('Widget test for Repository List Main Screen', () {
    /// mocking of states and events is necessary if your widget you're pumping (in this case it's a LoginForm) utilizes those states and events.
    /// Otherwise, you're getting back real states, not the mocked ones, and when needs mocked ones
    setUpAll(() {
      registerFallbackValue(RepositoryListStateFake());
      registerFallbackValue(RepositoryListEventFake());
    });

    testWidgets('should show AppEmptyScreen on RepositoryListInitialState',
        (widgetTester) async {
      /// arrange
      final mockRepositoryListBloc = MockRepositoryListBloc();
      final mockRepositoryListModule = MockRepositoryListModule();

      when(() => mockRepositoryListModule.setup())
          .thenAnswer((_) => Future.value(null));

      when(() => mockRepositoryListModule.repositoryListBloc)
          .thenReturn(mockRepositoryListBloc);

      when(() => mockRepositoryListBloc.state)
          .thenReturn(RepositoryListInitialState.start());

      /// act
      await widgetTester.pumpWidget(
        MaterialApp(
          home: RepositoryListMainScreen(
            repositoryListModule: mockRepositoryListModule,
          ),
        ),
      );
      await widgetTester.pumpAndSettle();

      /// assert
      expect(find.byType(AppEmptyScreen), findsOneWidget);
    });

    testWidgets('should show AppErrorScreen on RepositoryListErrorState',
        (widgetTester) async {
      /// arrange
      final mockRepositoryListBloc = MockRepositoryListBloc();
      final mockRepositoryListModule = MockRepositoryListModule();

      when(() => mockRepositoryListModule.setup())
          .thenAnswer((_) => Future.value(null));

      when(() => mockRepositoryListModule.repositoryListBloc)
          .thenReturn(mockRepositoryListBloc);

      when(() => mockRepositoryListBloc.state).thenReturn(
        RepositoryListErrorState(
          repositoryList: List.empty(),
          searchTerm: "",
          errorMessage: "Something went wrong. Please try again",
          isLastPage: false,
        ),
      );

      /// act
      await widgetTester.pumpWidget(
        MaterialApp(
          home: RepositoryListMainScreen(
            repositoryListModule: mockRepositoryListModule,
          ),
        ),
      );
      await widgetTester.pumpAndSettle();

      /// assert
      expect(find.byType(AppErrorScreen), findsOneWidget);
      expect(
          find.text('Something went wrong. Please try again'), findsOneWidget);
    });

    testWidgets('should show AppEmptyScreen on RepositoryListEmptyState',
        (widgetTester) async {
      /// arrange
      final mockRepositoryListBloc = MockRepositoryListBloc();
      final mockRepositoryListModule = MockRepositoryListModule();

      when(() => mockRepositoryListModule.setup())
          .thenAnswer((_) => Future.value(null));

      when(() => mockRepositoryListModule.repositoryListBloc)
          .thenReturn(mockRepositoryListBloc);

      when(() => mockRepositoryListBloc.state).thenReturn(
        RepositoryListEmptyState.empty(),
      );

      /// act
      await widgetTester.pumpWidget(
        MaterialApp(
          home: RepositoryListMainScreen(
            repositoryListModule: mockRepositoryListModule,
          ),
        ),
      );
      await widgetTester.pumpAndSettle();

      /// assert
      expect(find.byType(AppEmptyScreen), findsOneWidget);
      expect(find.text('No result with this search. Try again with new search'),
          findsOneWidget);
    });

    testWidgets('should show AppLoadingIndicator on RepositoryListLoadingState',
        (widgetTester) async {
      /// arrange
      final mockRepositoryListBloc = MockRepositoryListBloc();
      final mockRepositoryListModule = MockRepositoryListModule();

      when(() => mockRepositoryListModule.setup())
          .thenAnswer((_) => Future.value(null));

      when(() => mockRepositoryListModule.repositoryListBloc)
          .thenReturn(mockRepositoryListBloc);

      when(() => mockRepositoryListBloc.state).thenReturn(
        RepositoryListLoadingState(
          isLastPage: false,
          repositoryList: List.empty(),
          searchTerm: '',
        ),
      );

      /// act
      await widgetTester.pumpWidget(
        MaterialApp(
          home: RepositoryListMainScreen(
            repositoryListModule: mockRepositoryListModule,
          ),
        ),
      );
      await widgetTester.pump(Duration.zero);

      /// assert
      expect(find.byType(AppLoadingIndicator), findsOneWidget);
    });

    testWidgets('should show RepositoryListWidget on RepositoryListLoadedState',
        (widgetTester) async {
      /// arrange
      final mockRepositoryListBloc = MockRepositoryListBloc();
      final mockRepositoryListModule = MockRepositoryListModule();
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

      when(() => mockRepositoryListModule.setup())
          .thenAnswer((_) => Future.value(null));

      when(() => mockRepositoryListModule.repositoryListBloc)
          .thenReturn(mockRepositoryListBloc);

      when(() => mockRepositoryListBloc.state).thenReturn(
        RepositoryListLoadedState(
          isLastPage: false,
          repositoryList: mockRepositoryListUiEntity,
          searchTerm: '',
        ),
      );

      /// act
      await widgetTester.pumpWidget(
        MaterialApp(
          home: RepositoryListMainScreen(
            repositoryListModule: mockRepositoryListModule,
          ),
        ),
      );
      await widgetTester.pump(Duration.zero);

      /// assert
      expect(find.byType(RepositoryListWidget), findsOneWidget);
    });

    testWidgets('should find TextField', (widgetTester) async {
      /// arrange
      final mockRepositoryListBloc = MockRepositoryListBloc();
      final mockRepositoryListModule = MockRepositoryListModule();

      when(() => mockRepositoryListModule.setup())
          .thenAnswer((_) => Future.value(null));

      when(() => mockRepositoryListModule.repositoryListBloc)
          .thenReturn(mockRepositoryListBloc);

      when(() => mockRepositoryListBloc.state)
          .thenReturn(RepositoryListInitialState.start());

      /// act
      await widgetTester.pumpWidget(
        MaterialApp(
          home: RepositoryListMainScreen(
            repositoryListModule: mockRepositoryListModule,
          ),
        ),
      );
      await widgetTester.enterText(find.byType(TextField), 'flut');

      /// assert
      expect(find.byType(TextField), findsOneWidget);
    });
  });
}
