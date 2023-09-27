import 'package:devtalks_cluj_2023/list/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../add/add.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (context) => const ListPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListBloc()..add(Loadtasks()),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushAndRemoveUntil(AddPage.route(), (route) => false);
              },
              icon: const Icon(Icons.add),
            ),
          ],
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('List Page'),
        ),
        body: BlocBuilder<ListBloc, ListState>(
          builder: (context, state) {
            if (state is ViewLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ListLoaded) {
              return ListView.builder(
                itemCount: state.list.length,
                itemBuilder: (context, index) {
                  final task = state.list[index];

                  return ListTile(
                    onTap: () => context.read<ListBloc>().add(
                          ChangeMark(task: task),
                        ),
                    title: Text(task.title),
                    subtitle: Text(task.description),
                    leading: state.list[index].done == true
                        ? const Icon(Icons.check_box)
                        : const Icon(
                            Icons.check_box_outline_blank,
                          ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.read<ListBloc>().add(
                                  DeleteTask(
                                    task: task,
                                  ),
                                );
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text('Something went wrong'),
              );
            }
          },
        ),
      ),
    );
  }
}
