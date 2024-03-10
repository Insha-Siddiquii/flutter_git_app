import 'package:flutter/material.dart';
import 'package:flutter_git_app/presentation/utils/ui_constants.dart';

class RepositoryIssueListItemWidget extends StatelessWidget {
  const RepositoryIssueListItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Issue title
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.report_outlined,
              color: Colors.green,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  "Link to Issue. Changing Flutter branches seems to make Dart-Code behave flakily",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),

        SizedBox(
          height: 8,
        ),

        Padding(
          padding: EdgeInsets.only(left: 26.0),
          child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.horizontal,
              children: [
                /// Issue number
                Text(
                  "#144902",
                  style: TextStyle(
                    color: onBackgroundSurface,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),

                /// Issue date

                Text(
                  "opened 1 hour ago by andrewKate",
                  style: TextStyle(
                    color: onBackgroundSurface,
                  ),
                ),
              ]),
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
    );
  }
}
