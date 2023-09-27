part of 'add_bloc.dart';

abstract class AddEvent {}

class AddTaskEvent extends AddEvent {
  final Task task;

  AddTaskEvent({required this.task});
}

class LoadInitial extends AddEvent {}

class CallEdgeFunction extends AddEvent {}
