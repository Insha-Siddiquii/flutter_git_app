import 'package:flutter/material.dart';
import 'package:flutter_git_app/presentation/features/repository_list/ui/widgets/repository_list_widget.dart';
import 'package:flutter_git_app/presentation/utils/ui_constants.dart';

class RepositoryListMainScreen extends StatefulWidget {
  const RepositoryListMainScreen({super.key});

  @override
  State<RepositoryListMainScreen> createState() =>
      _RepositoryListMainScreenState();
}

class _RepositoryListMainScreenState extends State<RepositoryListMainScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        surfaceTintColor: backgroundColor,
        backgroundColor: backgroundColor,
        title: const Text(
          'Repositories',
          style: TextStyle(
            color: onBackgroundSurface,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
          ),
          child: Column(
            children: [
              /// Search field
              TextField(
                controller: controller,
                cursorColor: onBackgroundSurface,
                style: const TextStyle(
                  color: onBackgroundSurface,
                ),
                decoration: const InputDecoration(
                  focusColor: onBackgroundSurface,
                  labelText: 'Find a repository...',
                  labelStyle: TextStyle(
                    color: onBackgroundSurface,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: onBackgroundSurface,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: onBackgroundSurface,
                    ),
                  ),
                  hoverColor: onBackgroundSurface,
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              const Divider(
                color: onBackgroundSurface,
              ),

              const SizedBox(
                height: 16,
              ),

              /// Repository list
              const RepositoryListWidget()
            ],
          ),
        ),
      ),
    );
  }
}
