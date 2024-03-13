import 'package:flutter/material.dart';
import 'package:flutter_git_app/presentation/entities/repository_issue/repository_issue_ui_entity.dart';
import 'package:flutter_git_app/presentation/utils/ui_constants.dart';

class RepositoryIssueListItemWidget extends StatelessWidget {
  final RepositoryIssueUiEntity itemUiEntity;
  const RepositoryIssueListItemWidget({
    super.key,
    required this.itemUiEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Issue title
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.report_outlined,
              color: Colors.green,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  itemUiEntity.title,
                  style: const TextStyle(
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

        const SizedBox(
          height: 8,
        ),

        Padding(
          padding: const EdgeInsets.only(left: 26.0),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.horizontal,
            children: [
              /// Issue number
              Text(
                "#${itemUiEntity.number.toString()}",
                style: const TextStyle(
                  color: onBackgroundSurface,
                ),
              ),
              const SizedBox(
                width: 8,
              ),

              /// Issue date

              Text(
                "opened ${itemUiEntity.createdAt} by ${itemUiEntity.userName}",
                style: const TextStyle(
                  color: onBackgroundSurface,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        const Divider(
          color: onBackgroundSurface,
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
