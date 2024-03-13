import 'package:flutter/material.dart';
import 'package:flutter_git_app/presentation/entities/repository_list/repository_list_ui_entity.dart';
import 'package:flutter_git_app/presentation/utils/ui_constants.dart';

class RepositoryListItemWidget extends StatelessWidget {
  final RepositoryListUiEntity repositoryListUiEntity;
  final void Function() onTap;
  const RepositoryListItemWidget({
    super.key,
    required this.repositoryListUiEntity,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Repository Name
          Text(
            repositoryListUiEntity.name,
            style: const TextStyle(
              color: headingColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          /// Repository Description
          if (repositoryListUiEntity.description.isNotEmpty) ...[
            Text(
              repositoryListUiEntity.description,
              style: const TextStyle(
                color: onBackgroundSurface,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 2,
            ),
          ],
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.horizontal,
            children: [
              /// Repository Language
              if (repositoryListUiEntity.language.isNotEmpty) ...[
                const Icon(
                  Icons.terminal,
                  color: headingColor,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  repositoryListUiEntity.language,
                  style: const TextStyle(
                    color: onBackgroundSurface,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
              ],

              /// Repository Opened Issues
              if (repositoryListUiEntity.openIssuesCount != 0) ...[
                const Icon(
                  Icons.circle,
                  color: Colors.red,
                  size: 16,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  "${repositoryListUiEntity.openIssuesCount.toString()} opened issues",
                  style: const TextStyle(
                    color: onBackgroundSurface,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
              ],

              /// Repository Owner
              const Icon(
                Icons.face,
                color: headingColor,
                size: 16,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                "owned by ${repositoryListUiEntity.ownerName}",
                style: const TextStyle(
                  color: onBackgroundSurface,
                ),
              ),
            ],
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
      ),
    );
  }
}
