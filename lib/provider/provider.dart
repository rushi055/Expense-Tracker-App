import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/borrow_lend.dart';

class BorrowTask extends StateNotifier<List<Task>> {
  BorrowTask() : super([]);

  void addTask(Task task) {
    state = [...state, task];
  }

  void removeTask(int index) {
    state = state.where((task) => state.indexOf(task) != index).toList();
  }
}

final borrowtaskProvider = StateNotifierProvider<BorrowTask, List<Task>>((ref) {
  return BorrowTask();
});


//-------------------------------------------------------------------------------------------------------------


class LendTask extends StateNotifier<List<Task>> {
  LendTask() : super([]);

  void addTask(Task task) {
    state = [...state, task];
  }

  void removeTask(int index) {
    state = state.where((task) => state.indexOf(task) != index).toList();
  }
}

final lendtaskProvider = StateNotifierProvider<LendTask, List<Task>>((ref) {
  return LendTask();
});
