import 'package:flutter/material.dart';
import 'package:flutter_git_app/presentation/features/common/smart_refresher/loading_header.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LoadingFooter extends StatelessWidget {
  final LoadStatus? status;

  const LoadingFooter({
    this.status,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (status == null ||
        status == LoadStatus.idle ||
        status == LoadStatus.noMore ||
        status == LoadStatus.failed) {
      return const SizedBox.shrink();
    }
    return const LoadingHeaderWidget();
  }
}
