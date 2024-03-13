import 'package:flutter/material.dart';
import 'package:flutter_git_app/presentation/utils/ui_constants.dart';

class AppEmptyScreen extends StatelessWidget {
  final String message;
  const AppEmptyScreen({
    required this.message,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              message,
              style: const TextStyle(
                fontSize: 20.0,
                color: onBackgroundSurface,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
            const SizedBox(
              height: 12.0,
            ),
          ],
        ),
      ),
    );
  }
}
