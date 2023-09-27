import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/task.dart';

part 'list_event.dart';
part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  late dynamic subscription;

  ListBloc() : super(ListInitial()) {
    on<ChangeMark>((event, emit) async {
      emit(ViewLoading());

      final updatedTask = event.task.copyWith(done: !event.task.done);

      await Supabase.instance.client
          .from('tasks')
          .update(updatedTask.toJson())
          .eq('id', updatedTask.id);
    });
    on<Loadtasks>((event, emit) async {
      emit(ViewLoading());
      final tasksData = await Supabase.instance.client.from('tasks').select();

      List<Task> tasks =
          tasksData.map((json) => Task.fromJson(json)).toList().cast<Task>();

      emit(ListLoaded(list: tasks));
    });
    on<StreamTasks>(
      (event, emit) => emit(
        ListLoaded(list: event.list),
      ),
    );
    on<DeleteTask>((event, emit) async {
      emit(ViewLoading());

      await Supabase.instance.client.from('tasks').delete().eq(
            'id',
            event.task.id,
          );
    });

    subscription = Supabase.instance.client
        .from('tasks')
        .stream(primaryKey: ['id']).listen((List<Map<String, dynamic>> data) {
      List<Task> tasks =
          data.map((json) => Task.fromJson(json)).toList().cast<Task>();

      add(StreamTasks(list: tasks));
    });
  }

  @override
  Future<void> close() {
    subscription.cancel();
    return super.close();
  }
}
