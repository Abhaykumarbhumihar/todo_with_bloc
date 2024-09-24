part of 'all_list_bloc.dart';

class AllListState extends Equatable {
  final List<AddTaskModel>? addTodoTask;
  List<TaskCategory>? category;
  final bool? isTaskLoading;
  final String? errorMessage;
  final String? successMessage;
  TaskCategory? selectedCategory;

  AllListState(
      {this.addTodoTask,
      this.isTaskLoading,
      this.errorMessage,
      this.successMessage,
      this.category,
      this.selectedCategory});

  factory AllListState.initial() {
    return AllListState(isTaskLoading: false, addTodoTask: [], category: []);
  }

  AllListState copyWith(
      {List<AddTaskModel>? addTodoTask,
      bool? isTaskLoading,
      String? errorMessage,
      String? successMessage,
      List<TaskCategory>? category,
      TaskCategory? selectedCategory}) {
    return AllListState(
        addTodoTask: addTodoTask ?? this.addTodoTask,
        isTaskLoading: isTaskLoading ?? this.isTaskLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        successMessage: successMessage ?? this.successMessage,
        category: category ?? this.category,
        selectedCategory: selectedCategory ?? this.selectedCategory);
  }

  @override
  List<Object?> get props => [
        addTodoTask,
        isTaskLoading,
        errorMessage,
        successMessage,
        selectedCategory
      ];
}
