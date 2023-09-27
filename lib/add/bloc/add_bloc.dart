import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../list/models/task.dart';

part 'add_event.dart';
part 'add_state.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  AddBloc() : super(AddInitial()) {
    on<AddTaskEvent>((event, emit) async {
      emit(AddLoading());

      try {
        await Supabase.instance.client
            .from('tasks')
            .insert(event.task.toJson());
      } catch (e) {
        print(e);
        emit(AddLoaded());
        return;
      }

      emit(AddLoaded());
    });
    on<LoadInitial>((event, emit) => emit(AddInitial()));
    on<CallEdgeFunction>((event, emit) async {
      emit(AddLoading());

      final res = await Supabase.instance.client.functions
          .invoke('add_task', body: {'name': 'Alex'});
      final data = res.data;

      print(data);

      emit(AddEdgeResult(message: data.toString()));
    });
  }
}
