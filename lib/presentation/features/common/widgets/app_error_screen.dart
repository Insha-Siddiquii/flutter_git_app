import 'package:flutter/material.dart';
import 'package:flutter_git_app/presentation/utils/ui_constants.dart';

class AppErrorScreen extends StatelessWidget {
  final void Function() onPressed;
  final String errorMessage;
  const AppErrorScreen({
    required this.onPressed,
    required this.errorMessage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            errorMessage,
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
          ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(onBackgroundSurface),
            ),
            child: const Text(
              "Try again",
              style: TextStyle(
                fontSize: 20.0,
                color: onBackgroundSurface,
              ),
            ),
          )
        ],
      ),
    );
  }
}
