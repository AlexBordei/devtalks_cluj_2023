// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'list_bloc.dart';

abstract class ListEvent {}

class Loadtasks extends ListEvent {
  bool done;
  Loadtasks({
    this.done = false,
  });
}

class StreamTasks extends ListEvent {
  final List<Task> list;

  StreamTasks({required this.list});
}

class DeleteTask extends ListEvent {
  final Task task;

  DeleteTask({required this.task});
}

class ChangeMark extends ListEvent {
  final Task task;

  ChangeMark({required this.task});
}
