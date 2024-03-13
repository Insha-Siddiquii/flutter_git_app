import 'package:flutter/material.dart';
import 'package:flutter_git_app/presentation/utils/ui_constants.dart';

class LoadingHeaderWidget extends StatelessWidget {
  const LoadingHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: RefreshProgressIndicator(
        color: headingColor,
        backgroundColor: Colors.white,
      ),
    );
  }
}
