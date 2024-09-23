import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/common/extension/common_extension.dart';
import 'package:todoapp/pages/addTask/domain/entities/category.dart';

import '../../../../local_storage/hive/hive_helper.dart';
import '../../domain/entities/add_task_model.dart';
import '../../domain/usecase/add_task_usecase.dart';

part 'add_task_event.dart';

part 'add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  AddTaskUseCase _addTaskUseCase;
  Box<TaskCategory>? _categoryBox;
  Box<AddTaskModel>? _taskBox;

  AddTaskBloc(this._addTaskUseCase) : super(AddTaskState.initial()) {
    _initialize();
    on<AddCategoryEvent>(addCategory);
    on<GetCategoryEvent>(getCategory);
    on<SelectCategoryEvent>(selectCategory);
    on<AddTodoTaskEvent>(addTaskEvent);
    on<GetTodoTaskListEvent>(getAllTodoTask);
  }

  Future<void> _initialize() async {
    _categoryBox = await HiveHelper().openBox<TaskCategory>('category');
    // _taskBox = await HiveHelper().openBox<AddTaskModel>('task');
    add(GetCategoryEvent());
    Future.delayed(Duration(milliseconds: 500));
    add(GetTodoTaskListEvent());
  }

  Future<void> addCategory(
      AddCategoryEvent event, Emitter<AddTaskState> emit) async {
    if (event.categoryName.isEmpty) {
      emit(state.copyWith(categoryErrorMessage: "Category name is required"));
      return;
    }

    var taskCategory = TaskCategory(
        categoryName: event.categoryName,
        categoryId: DateTime.now().generateUniqueId());
    await _addTaskUseCase.addCategory(taskCategory);
    emit(state.copyWith(categorySuccessMessage: "Category Added"));
  }

  Future<void> selectCategory(
      SelectCategoryEvent event, Emitter<AddTaskState> emit) async {
    emit(state.copyWith(selectedCategory: event.selectedCategory));
  }

  Future<void> getCategory(
      GetCategoryEvent event, Emitter<AddTaskState> emit) async {
    try {
      var data = _categoryBox?.values.toList().cast<TaskCategory>();
      print(data);
      emit(state.copyWith(
          category: data, categorySuccessMessage: "Category Fetched"));
    } catch (e) {
      emit(state.copyWith(categoryErrorMessage: "Failed to retrieve data: $e"));
    }
  }

  Future<void> getAllTodoTask(
      GetTodoTaskListEvent event, Emitter<AddTaskState> emit) async {
    emit(state.copyWith(addTaskLoading: true));

    try {
      var todotaskList = await _addTaskUseCase.getTodoTaskList();
      todotaskList.forEach((element) {
        print(element.title);
      });
      emit(state.copyWith(addTaskLoading: false));
    } catch (e) {
      emit(state.copyWith(
          categoryErrorMessage: "Failed to retrieve todo task: $e",
          addTaskLoading: false));
    }
  }

  Future<void> addTaskEvent(
      AddTodoTaskEvent event, Emitter<AddTaskState> emit) async {
    try {
      print(event.addTaskModel.category.categoryName);

      var data = _addTaskUseCase.addTask(event.addTaskModel);
      print(data);
      emit(state.copyWith(categorySuccessMessage: "Task added ${data}"));
      add(GetTodoTaskListEvent());
    } catch (e) {
      emit(state.copyWith(
        categoryErrorMessage: "Failed to retrieve data: $e",
      ));
    }
  }
}
