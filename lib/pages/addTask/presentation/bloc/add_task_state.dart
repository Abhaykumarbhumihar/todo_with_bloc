part of 'add_task_bloc.dart';

final class AddTaskState extends Equatable {
  List<TaskCategory>? category;
  bool categoryLoading;
  bool addTaskLoading;
  String? categoryErrorMessage;
  String? categorySuccessMessage;
  final TaskCategory? selectedCategory;
  AddTaskModel? addTaskModel;

  AddTaskState(
      {this.category,
      this.categoryErrorMessage,
      required this.categoryLoading,
      required this.addTaskLoading,
      this.categorySuccessMessage,
      this.selectedCategory,
      this.addTaskModel});

  factory AddTaskState.initial() {
    return AddTaskState(categoryLoading: false, addTaskLoading: false);
  }

  factory AddTaskState.locading() {
    return AddTaskState(categoryLoading: true, addTaskLoading: false);
  }

  factory AddTaskState.loaded(
      List<TaskCategory>? categry, String successMessage) {
    return AddTaskState(
        categoryLoading: false,
        addTaskLoading: false,
        category: categry,
        categorySuccessMessage: successMessage);
  }

  factory AddTaskState.added(AddTaskModel addTaskModel, String successMessage) {
    return AddTaskState(
        categoryLoading: false,
        addTaskLoading: false,
        addTaskModel: addTaskModel,
        categorySuccessMessage: successMessage);
  }

  factory AddTaskState.error(String message) {
    return AddTaskState(
        categoryLoading: false,
        addTaskLoading: false,
        categoryErrorMessage: message);
  }

  AddTaskState copyWith(
      {dynamic? category,
      bool? categoryLoading,
      bool? addTaskLoading,

      String? categoryErrorMessage,
      String? categorySuccessMessage,

      TaskCategory? selectedCategory,
      AddTaskModel? addTaskModel}) {
    return AddTaskState(
        addTaskLoading: addTaskLoading ?? this.addTaskLoading,
        categoryLoading: categoryLoading ?? this.categoryLoading,
        category: category ?? this.category,
        categoryErrorMessage: categoryErrorMessage ?? this.categoryErrorMessage,
        categorySuccessMessage:
            categorySuccessMessage ?? this.categorySuccessMessage,
        selectedCategory: selectedCategory ?? this.selectedCategory,
        addTaskModel: addTaskModel ?? this.addTaskModel);
  }

  @override
  List<Object> get props => [
        categoryLoading,
        category ?? [],
        categoryErrorMessage ?? '',
        categorySuccessMessage ?? '',
        selectedCategory ?? '',
        addTaskModel ?? ''
      ];
}
