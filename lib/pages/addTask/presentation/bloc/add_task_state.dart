part of 'add_task_bloc.dart';

final class AddTaskState extends Equatable {
  List<TaskCategory>? category;
  bool categoryLoading;
  bool addTaskLoading;
  String? categoryErrorMessage;
  String? categorySuccessMessage;
  final TaskCategory? selectedCategory;
  AddTaskModel? addTaskModel;
  bool isDateSelected;
  bool isTimeSelected;
  bool isTimeShow;

  AddTaskState(
      {this.category,
      this.categoryErrorMessage,
      required this.categoryLoading,
      required this.addTaskLoading,
      this.categorySuccessMessage,
      this.selectedCategory,
      this.addTaskModel,
      this.isDateSelected = false,
      this.isTimeSelected = false,
      this.isTimeShow = false});

  factory AddTaskState.initial() {
    return AddTaskState(
        categoryLoading: false,
        addTaskLoading: false,
        isDateSelected: false,
        isTimeSelected: false,
        isTimeShow: false);
  }

  AddTaskState copyWith(
      {dynamic? category,
      bool? categoryLoading,
      bool? addTaskLoading,
      String? categoryErrorMessage,
      String? categorySuccessMessage,
      TaskCategory? selectedCategory,
      AddTaskModel? addTaskModel,
      bool? isDateSelected,
      bool? isTimeSelected,
      bool? isTimeShow}) {
    return AddTaskState(
      addTaskLoading: addTaskLoading ?? this.addTaskLoading,
      categoryLoading: categoryLoading ?? this.categoryLoading,
      isDateSelected: isDateSelected ?? this.isDateSelected,
      isTimeShow: isTimeShow ?? this.isTimeShow,
      isTimeSelected: isTimeSelected ?? this.isTimeSelected,
      category: category ?? this.category,
      categoryErrorMessage: categoryErrorMessage ?? this.categoryErrorMessage,
      categorySuccessMessage:
          categorySuccessMessage ?? this.categorySuccessMessage,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      addTaskModel: addTaskModel ?? this.addTaskModel,
    );
  }

  @override
  List<Object> get props => [
        categoryLoading,
        category ?? [],
        categoryErrorMessage ?? '',
        categorySuccessMessage ?? '',
        selectedCategory ?? '',
        addTaskModel ?? '',
        isTimeSelected,
        isDateSelected,
        isTimeShow
      ];
}
