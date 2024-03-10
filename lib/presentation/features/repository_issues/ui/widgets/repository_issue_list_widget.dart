import 'package:flutter/material.dart';
import 'package:flutter_git_app/presentation/features/repository_issues/ui/widgets/respository_issue_list_item_widget.dart';

class RepositoryIssueListWidget extends StatelessWidget {
  const RepositoryIssueListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => const RepositoryIssueListItemWidget(),
      ),
    );
  }
}
