part of 'task_list_bloc.dart';

sealed class TaskListState extends Equatable {
  const TaskListState();
}

final class TaskListInitial extends TaskListState {
  @override
  List<Object> get props => [];
}
