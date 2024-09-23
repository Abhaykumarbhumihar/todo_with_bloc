import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../addTask/domain/entities/add_task_model.dart';
import '../../domain/usecase/get_todo_task_usecase..dart';

part 'all_list_event.dart';

part 'all_list_state.dart';

class AllListBloc extends Bloc<AllListEvent, AllListState> {
  GetTodoTaskUseCase _getTodoTaskUseCase;

  AllListBloc(this._getTodoTaskUseCase) : super(AllListState.initial()) {
    on<GetTodoTaskList>(getAllTaskList);
  }

  Future<void> getAllTaskList(
      GetTodoTaskList event, Emitter<AllListState> emit) async {
    try {
      emit(state.copyWith(isTaskLoading: true));
      final todoTaskList = await _getTodoTaskUseCase.getCategory();
      if (todoTaskList.isNotEmpty) {
        emit(state.copyWith(
            addTodoTask: todoTaskList,
            successMessage: "Todo task list get",
            isTaskLoading: false));
      } else {
        emit(state.copyWith(
            successMessage: "Failed to get todo task list",
            isTaskLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(
          isTaskLoading: false,
          successMessage: "Failed to get todo task list $e"));
    }
  }
}
