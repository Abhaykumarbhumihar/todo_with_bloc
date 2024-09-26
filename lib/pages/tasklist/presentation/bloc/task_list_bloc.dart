import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../addTask/domain/entities/add_task_model.dart';
import '../../domain/usecase/task_list_usecase.dart';

part 'task_list_event.dart';

part 'task_list_state.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  TaskListUseCase _taskListUseCase;
  TaskListBloc(this._taskListUseCase) : super(TaskListState.initial()) {
    on<GetAllTaskListEvent>(getAllTaskLitst);
  }

  Future<void> getAllTaskLitst(
      GetAllTaskListEvent event, Emitter<TaskListState> emit) async {
    try {
      final taskList = await _taskListUseCase.getAllTaskList();
      taskList.sort((a, b) {
        if (a.date == null || a.date.isEmpty) {
          return 1; // Move tasks with no date to the end
        } else if (b.date == null || b.date.isEmpty) {
          return -1; // Move tasks with no date to the end
        } else {
          DateTime dateA = DateTime.parse(a.date);
          DateTime dateB = DateTime.parse(b.date);
          return dateA.compareTo(dateB); // Sort in ascending order
        }
      });
      emit(state.copyWith(addTodoTask: taskList));
    } catch (e) {
      emit(state.copyWith(addTodoTask: []));
    }
  }






}
