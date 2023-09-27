part of 'list_bloc.dart';

abstract class ListState {}

final class ListInitial extends ListState {}

final class ViewLoading extends ListState {}

class ListLoaded extends ListState {
  final List<Task> list;

  ListLoaded({required this.list});
}
