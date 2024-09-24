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

  AddTaskBloc(this._addTaskUseCase) : super(AddTaskState.initial()) {
    _initialize();
    on<AddCategoryEvent>(addCategory);
    on<GetCategoryEvent>(getCategory);
    on<SelectCategoryEvent>(selectCategory);
    on<AddTodoTaskEvent>(addTaskEvent);
  }

  Future<void> _initialize() async {
    _categoryBox = await HiveHelper().openBox<TaskCategory>('category');
    await addDefaultCategories();
    add(GetCategoryEvent());

    Future.delayed(Duration(milliseconds: 500));
  }

  Future<void> addDefaultCategories() async {
    List<TaskCategory> defaultCategories = [
      TaskCategory(categoryId: 1, categoryName: "Work"),
      TaskCategory(categoryId: 2, categoryName: "Default"),
      TaskCategory(categoryId: 3, categoryName: "Study"),
      TaskCategory(categoryId: 4, categoryName: "Exercise"),
    ];

    for (TaskCategory categoryName in defaultCategories) {
      // Check if the category already exists
      print("CODE IS RUNNING HEREREE");
      bool exists = _categoryBox?.values
              .any((category) => category.categoryId == categoryName.categoryId) ??
          false;
      if (!exists) {
        var taskCategory = TaskCategory(
          categoryName: categoryName.categoryName,
          categoryId: categoryName.categoryId,
        );
        await _addTaskUseCase.addCategory(taskCategory);
      }
    }
  }

  Future<void> addCategory(
      AddCategoryEvent event, Emitter<AddTaskState> emit) async {
    if (event.categoryName.isEmpty) {
      emit(state.copyWith(
          categoryErrorMessage: "Category name is required",
          categorySuccessMessage: ''));
      return;
    }

    var taskCategory = TaskCategory(
        categoryName: event.categoryName,
        categoryId: DateTime.now().generateUniqueId());
    await _addTaskUseCase.addCategory(taskCategory);
    emit(state.copyWith(
      categorySuccessMessage: "Category Added",
    ));
  }

  Future<void> selectCategory(
      SelectCategoryEvent event, Emitter<AddTaskState> emit) async {
    emit(state.copyWith(selectedCategory: event.selectedCategory));
  }

  Future<void> getCategory(
      GetCategoryEvent event, Emitter<AddTaskState> emit) async {
    try {
      var data = await _categoryBox?.values.toList().cast<TaskCategory>();
      emit(state.copyWith(
          category: data, categorySuccessMessage: "Category Fetched"));
    } catch (e) {
      emit(state.copyWith(
          categoryErrorMessage: "Failed to retrieve data: $e",
          categorySuccessMessage: ''));
    }
  }

  Future<void> addTaskEvent(
      AddTodoTaskEvent event, Emitter<AddTaskState> emit) async {
    try {
      print(event.addTaskModel.category.categoryName);
      await _addTaskUseCase.addTask(event.addTaskModel);
      emit(state.copyWith(categorySuccessMessage: "Task added"));
    } catch (e) {
      emit(state.copyWith(
        categoryErrorMessage: "Failed to retrieve data: $e",
      ));
    }
  }
}
