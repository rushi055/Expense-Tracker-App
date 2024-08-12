import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/borrow_lend.dart';
import '../widgets/card.dart';
import '../widgets/dialog_widg.dart';
import 'package:expense_tracker/provider/provider.dart';

class LendPage extends ConsumerWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(lendtaskProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Money Lended')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return CardExpense(
                  task: task,
                  colour: Colors.blue.shade50,
                  onDelete: () {
                    ref.read(lendtaskProvider.notifier).removeTask(index);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddTaskDialog(
                      nameController: nameController,
                      amountController: amountController,
                      dateController: dateController,
                      onAdd: () {
                        final task = Task(
                          name: nameController.text,
                          amount: double.parse(amountController.text),
                          date: DateTime.parse(dateController.text),
                        );
                        ref.read(lendtaskProvider.notifier).addTask(task);
                        nameController.clear();
                        amountController.clear();
                        dateController.clear();
                        Navigator.of(context).pop();
                      },
                    );
                  },
                );
              },
              child: const Text('Add Task'),
            ),
          ),
        ],
      ),
    );
  }
}
