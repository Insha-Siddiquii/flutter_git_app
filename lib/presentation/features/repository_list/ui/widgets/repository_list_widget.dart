import 'package:flutter/material.dart';
import 'package:flutter_git_app/presentation/features/repository_list/ui/widgets/respository_list_item_widget.dart';

class RepositoryListWidget extends StatelessWidget {
  const RepositoryListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => const RepositoryListItemWidget(),
      ),
    );
  }
}
