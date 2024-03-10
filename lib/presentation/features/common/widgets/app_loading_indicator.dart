import 'package:flutter/material.dart';
import 'package:flutter_git_app/presentation/utils/ui_constants.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: onBackgroundSurface,
      ),
    );
  }
}
