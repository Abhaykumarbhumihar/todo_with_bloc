import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/servicelocator/serview_locator.dart';
import '../../../addTask/domain/entities/add_task_model.dart';
import '../../domain/usecase/task_list_usecase.dart';

part 'task_list_event.dart';

part 'task_list_state.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  TaskListUseCase _taskListUseCase=getIt<TaskListUseCase>();
  TaskListBloc() : super(TaskListState.initial()) {
    on<GetAllTaskListEvent>(getAllTaskLitst);
    on<DeleteTaskEvent>(deleteTaskById);
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

  Future<void> deleteTaskById(
      DeleteTaskEvent event, Emitter<TaskListState> emit) async {
    try {
      final deleteTaskResult = _taskListUseCase.deleteTask(event.taskId);
      add(GetAllTaskListEvent());
    } catch (e) {
      print("Task not deleted");
    }
  }
}
