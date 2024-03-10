import 'package:flutter/material.dart';
import 'package:flutter_git_app/presentation/features/repository_issues/ui/pages/repository_issue_list_main_screen.dart';
import 'package:flutter_git_app/presentation/utils/ui_constants.dart';

class RepositoryListItemWidget extends StatelessWidget {
  const RepositoryListItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (BuildContext context) =>
              const RepositoryIssueListMainScreen(),
        ),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Repository Name
          Text(
            "flutter_git_app",
            style: TextStyle(
              color: headingColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          /// Repository Description
          Text(
            "Load and get full control of your Rive files in a Flutter project using this library.",
            style: TextStyle(
              color: onBackgroundSurface,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 2,
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.horizontal,
            children: [
              /// Repository Language
              Icon(
                Icons.terminal,
                color: headingColor,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                "Dart",
                style: TextStyle(
                  color: onBackgroundSurface,
                ),
              ),
              SizedBox(
                width: 8,
              ),

              /// Repository Opened Issues
              Icon(
                Icons.circle,
                color: Colors.red,
                size: 16,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                "24 opened issues",
                style: TextStyle(
                  color: onBackgroundSurface,
                ),
              ),
              SizedBox(
                width: 8,
              ),

              /// Repository Owner
              Icon(
                Icons.face,
                color: headingColor,
                size: 16,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                "owned by InshaDev",
                style: TextStyle(
                  color: onBackgroundSurface,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Divider(
            color: onBackgroundSurface,
          ),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
