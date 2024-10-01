import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/servicelocator/serview_locator.dart';
import '../../../addTask/domain/entities/add_task_model.dart';
import '../../../addTask/domain/entities/category.dart';
import '../../domain/usecase/get_todo_task_usecase.dart';

part 'all_list_event.dart';

part 'all_list_state.dart';

class AllListBloc extends Bloc<AllListEvent, AllListState> {
  GetTodoTaskUseCase _getTodoTaskUseCase=getIt<GetTodoTaskUseCase>();
  AllListBloc() : super(AllListState.initial()) {
    on<GetTodoTaskList>(getAllTaskList);
    on<GetCategoryForFilterEvent>(getAllCategory);
    on<SelectedCategoryForFilterEvent>(selectCategoryForFilter);
    on<QuickTextChange>(quickTaskTextEmpty);
  }

  Future<void> getAllTaskList(
      GetTodoTaskList event, Emitter<AllListState> emit) async {
    try {
      // Emit loading state
      emit(state.copyWith(isTaskLoading: true));

      // Fetch the task list
      final todoTaskList = await _getTodoTaskUseCase.getTodoList();

      // Check if the list is not empty
      if (todoTaskList.isNotEmpty) {
        // Sort the list based on the date, handle null dates by placing them at the end
        todoTaskList.sort((a, b) {
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

        // Emit the sorted list
        emit(state.copyWith(
            addTodoTask: todoTaskList,
            successMessage: "Todo task list fetched and sorted",
            isTaskLoading: false));
      } else {
        // Emit failure message if list is empty
        emit(state.copyWith(
            successMessage: "Failed to get todo task list",
            isTaskLoading: false));
      }
    } catch (e) {
      // Emit failure message in case of error
      emit(state.copyWith(
          isTaskLoading: false,
          successMessage: "Failed to get todo task list $e"));
    }
  }

  Future<void> getAllCategory(
      GetCategoryForFilterEvent event, Emitter<AllListState> emit) async {
    try {
      var data = await _getTodoTaskUseCase.getCategory();
      data.add(TaskCategory(categoryName: "All List", categoryId: 000));
      emit(state.copyWith(category: data, successMessage: "Category Fetched"));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: "Failed to retrieve data: $e",
        successMessage: '',
      ));
    }
  }

  Future<void> quickTaskTextEmpty(
      QuickTextChange event, Emitter<AllListState> emit) async {
    emit(state.copyWith(isQuickTextEmpty: event.isEmpty));
  }

  Future<void> addQuickTask(
      AddQuickTaskEvent event, Emitter<AllListState> emit) async {}

  Future<void> selectCategoryForFilter(
      SelectedCategoryForFilterEvent event, Emitter<AllListState> emit) async {
    try {
      emit(state.copyWith(isTaskLoading: true));
      final todoTaskList = await _getTodoTaskUseCase.getTodoList();
      final filteredTasks = todoTaskList.where((task) {
        return task.category.categoryId == event.selectedCategory?.categoryId;
      }).toList();

      // Sort the filtered tasks by date
      filteredTasks.sort((a, b) {
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
      print(filteredTasks);
      if (filteredTasks.isNotEmpty) {
        emit(state.copyWith(
            addTodoTask: filteredTasks,
            successMessage: "Filtered todo task list fetched",
            isTaskLoading: false,
            selectedCategory: event.selectedCategory));
      } else {
        emit(state.copyWith(
            addTodoTask: [],
            successMessage:
                "Do todo for ${event.selectedCategory!.categoryName}",
            isTaskLoading: false,
            selectedCategory: event.selectedCategory));
      }
    } catch (e) {
      emit(state.copyWith(
          isTaskLoading: false,
          successMessage: "Failed to get todo task list $e"));
    }
  }
}
