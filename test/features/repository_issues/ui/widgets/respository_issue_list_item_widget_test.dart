import 'package:flutter/material.dart';
import 'package:flutter_git_app/presentation/entities/repository_issue/repository_issue_ui_entity.dart';
import 'package:flutter_git_app/presentation/features/repository_issues/ui/widgets/respository_issue_list_item_widget.dart';
import 'package:flutter_test/flutter_test.dart';

/// Basics widget test assuming that the integration with bloc and parent widgets is provided and all happy data flow is provided
void main() {
  group('RepositoryIssueListItemWidget', () {
    testWidgets('renders issue title', (WidgetTester tester) async {
      const entity = RepositoryIssueUiEntity(
        title: 'Test Issue',
        number: 1,
        createdAt: '2022-03-25',
        userName: 'Test User',
        id: 1,
      );

      await tester.pumpWidget(const MaterialApp(
        home: RepositoryIssueListItemWidget(
          itemUiEntity: entity,
        ),
      ));

      expect(find.text('Test Issue'), findsOneWidget);
    });

    testWidgets('renders issue number and date', (WidgetTester tester) async {
      const entity = RepositoryIssueUiEntity(
        title: 'Test Issue',
        number: 1,
        createdAt: '2022-03-25',
        userName: 'Test User',
        id: 1,
      );

      await tester.pumpWidget(const MaterialApp(
        home: RepositoryIssueListItemWidget(
          itemUiEntity: entity,
        ),
      ));

      expect(find.text('#1'), findsOneWidget);
      expect(find.text('opened 2022-03-25 by Test User'), findsOneWidget);
    });
  });
}
