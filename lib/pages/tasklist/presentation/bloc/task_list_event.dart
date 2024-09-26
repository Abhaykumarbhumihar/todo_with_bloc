part of 'task_list_bloc.dart';

abstract class TaskListEvent extends Equatable {
  const TaskListEvent();
}


class GetAllTaskListEvent extends TaskListEvent {
  @override
  List<Object?> get props => [];
}


class DeleteTaskEvent extends TaskListEvent{
  String taskId;
  DeleteTaskEvent(this.taskId);
  @override
  List<Object?> get props => [taskId];
}