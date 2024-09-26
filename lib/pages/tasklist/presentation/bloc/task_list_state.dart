part of 'task_list_bloc.dart';

class TaskListState extends Equatable {
  final List<AddTaskModel>? addTodoTask;

  TaskListState({this.addTodoTask});

  factory TaskListState.initial() {
    return TaskListState(addTodoTask: []);
  }

  TaskListState copyWith({List<AddTaskModel>? addTodoTask}) {
    return TaskListState(
      addTodoTask: addTodoTask ?? this.addTodoTask,
    );
  }

  @override
  List<Object?> get props => [addTodoTask];
}
