import 'package:devtalks_cluj_2023/list/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/add_bloc.dart';

class AddPage extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  AddPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (context) => AddPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushAndRemoveUntil(ListPage.route(), (route) => false);
            },
            icon: const Icon(Icons.list),
          ),
        ],
        title: const Text(
          'Add task',
        ),
      ),
      body: BlocProvider(
        create: (context) => AddBloc(),
        child: BlocConsumer<AddBloc, AddState>(
          listener: (context, state) {
            if (state is AddEdgeResult) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is AddLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is AddLoaded) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Task added'),
                    ElevatedButton(
                      onPressed: () {
                        context.read<AddBloc>().add(
                              LoadInitial(),
                            );
                      },
                      child: Text('Add another one'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            ListPage.route(), (route) => false);
                      },
                      child: Text('Go to tasks list'),
                    ),
                    IconButton(
                        icon: const Icon(Icons.star),
                        onPressed: () {
                          context.read<AddBloc>().add(CallEdgeFunction());
                        }),
                  ],
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                      },
                    ),
                    TextFormField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AddBloc>().add(
                                AddTaskEvent(
                                  task: Task(
                                      title: titleController.text,
                                      description: descriptionController.text,
                                      done: false),
                                ),
                              );
                        }
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
