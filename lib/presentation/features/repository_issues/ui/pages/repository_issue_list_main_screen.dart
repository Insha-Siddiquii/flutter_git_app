import 'package:flutter/material.dart';
import 'package:flutter_git_app/presentation/features/repository_issues/ui/widgets/repository_issue_list_widget.dart';
import 'package:flutter_git_app/presentation/utils/ui_constants.dart';

class RepositoryIssueListMainScreen extends StatelessWidget {
  const RepositoryIssueListMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        surfaceTintColor: backgroundColor,
        iconTheme: const IconThemeData(
          color: onBackgroundSurface, //change your color here
        ),
        backgroundColor: backgroundColor,
        title: const Text(
          'Repository Issues',
          style: TextStyle(
            color: onBackgroundSurface,
          ),
        ),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
          ),
          child: Column(
            children: [
              /// Repository Issue List
              RepositoryIssueListWidget()
            ],
          ),
        ),
      ),
    );
  }
}
