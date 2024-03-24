import 'package:flutter_git_app/presentation/features/repository_list/bloc/repository_list_bloc_event.dart';
import 'package:flutter_git_app/presentation/features/repository_list/bloc/repository_list_bloc_state.dart';
import 'package:mocktail/mocktail.dart';

class RepositoryListStateFake extends Fake implements RepositoryListState {}

class RepositoryListEventFake extends Fake implements RepositoryListEvent {}
