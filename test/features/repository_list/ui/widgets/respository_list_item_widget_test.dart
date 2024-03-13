import 'package:flutter/material.dart';
import 'package:flutter_git_app/presentation/entities/repository_list/repository_list_ui_entity.dart';
import 'package:flutter_git_app/presentation/features/repository_list/ui/widgets/respository_list_item_widget.dart';
import 'package:flutter_test/flutter_test.dart';

/// Basics widget test assuming that the integration with bloc and parent widgets is provided and all happy data flow is provided

void main() {
  group('RepositoryListItemWidget', () {
    testWidgets('renders repository name', (WidgetTester tester) async {
      const entity = RepositoryListUiEntity(
        name: 'Test Repository',
        description: '',
        language: '',
        openIssuesCount: 0,
        ownerName: 'Test Owner',
        id: 1,
      );

      await tester.pumpWidget(MaterialApp(
        home: RepositoryListItemWidget(
          repositoryListUiEntity: entity,
          onTap: () {},
        ),
      ));

      expect(find.text('Test Repository'), findsOneWidget);
    });

    testWidgets('renders repository description when not empty',
        (WidgetTester tester) async {
      const entity = RepositoryListUiEntity(
        name: 'Test Repository',
        description: 'Test Description',
        language: '',
        openIssuesCount: 0,
        ownerName: 'Test Owner',
        id: 1,
      );

      await tester.pumpWidget(MaterialApp(
        home: RepositoryListItemWidget(
          repositoryListUiEntity: entity,
          onTap: () {},
        ),
      ));

      expect(find.text('Test Description'), findsOneWidget);
    });

    testWidgets('does not render repository description when empty',
        (WidgetTester tester) async {
      const entity = RepositoryListUiEntity(
        name: 'Test Repository',
        description: '',
        language: '',
        openIssuesCount: 0,
        ownerName: 'Test Owner',
        id: 1,
      );

      await tester.pumpWidget(MaterialApp(
        home: RepositoryListItemWidget(
          repositoryListUiEntity: entity,
          onTap: () {},
        ),
      ));

      expect(find.text('Test Description'), findsNothing);
    });

    testWidgets('renders repository language when not empty',
        (WidgetTester tester) async {
      const entity = RepositoryListUiEntity(
        name: 'Test Repository',
        description: '',
        language: 'Dart',
        openIssuesCount: 0,
        ownerName: 'Test Owner',
        id: 1,
      );

      await tester.pumpWidget(MaterialApp(
        home: RepositoryListItemWidget(
          repositoryListUiEntity: entity,
          onTap: () {},
        ),
      ));

      expect(find.text('Dart'), findsOneWidget);
    });

    testWidgets('does not render repository language when empty',
        (WidgetTester tester) async {
      const entity = RepositoryListUiEntity(
        name: 'Test Repository',
        description: '',
        language: '',
        openIssuesCount: 0,
        ownerName: 'Test Owner',
        id: 1,
      );

      await tester.pumpWidget(MaterialApp(
        home: RepositoryListItemWidget(
          repositoryListUiEntity: entity,
          onTap: () {},
        ),
      ));

      expect(find.text('Dart'), findsNothing);
    });

    testWidgets('renders open issues count when not zero',
        (WidgetTester tester) async {
      const entity = RepositoryListUiEntity(
        name: 'Test Repository',
        description: '',
        language: '',
        openIssuesCount: 5,
        ownerName: 'Test Owner',
        id: 1,
      );

      await tester.pumpWidget(MaterialApp(
        home: RepositoryListItemWidget(
          repositoryListUiEntity: entity,
          onTap: () {},
        ),
      ));

      expect(find.text('5 opened issues'), findsOneWidget);
    });

    testWidgets('does not render open issues count when zero',
        (WidgetTester tester) async {
      const entity = RepositoryListUiEntity(
        name: 'Test Repository',
        description: '',
        language: '',
        openIssuesCount: 0,
        ownerName: 'Test Owner',
        id: 1,
      );

      await tester.pumpWidget(MaterialApp(
        home: RepositoryListItemWidget(
          repositoryListUiEntity: entity,
          onTap: () {},
        ),
      ));

      expect(find.text('0 opened issues'), findsNothing);
    });

    testWidgets('renders repository owner', (WidgetTester tester) async {
      const entity = RepositoryListUiEntity(
        name: 'Test Repository',
        description: '',
        language: '',
        openIssuesCount: 0,
        ownerName: 'Test Owner',
        id: 1,
      );

      await tester.pumpWidget(MaterialApp(
        home: RepositoryListItemWidget(
          repositoryListUiEntity: entity,
          onTap: () {},
        ),
      ));

      expect(find.text('owned by Test Owner'), findsOneWidget);
    });
  });
}
