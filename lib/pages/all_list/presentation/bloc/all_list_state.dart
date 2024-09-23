part of 'all_list_bloc.dart';

class AllListState extends Equatable {
  final List<AddTaskModel>? addTodoTask;
  final bool? isTaskLoading;
  final String? errorMessage;
  final String? successMessage;

  AllListState({
     this.addTodoTask,
     this.isTaskLoading,
     this.errorMessage,
     this.successMessage,
  });

  factory AllListState.initial() {
    return AllListState(isTaskLoading: false,);
  }

  AllListState copyWith({
    List<AddTaskModel>? addTodoTask,
    bool? isTaskLoading,
    String? errorMessage,
    String? successMessage,
  }) {
    return AllListState(
      addTodoTask: addTodoTask ?? this.addTodoTask,
      isTaskLoading: isTaskLoading ?? this.isTaskLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  @override
  List<Object?> get props => [
    addTodoTask,
    isTaskLoading,
    errorMessage,
    successMessage,
  ];
}
