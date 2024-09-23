part of 'all_list_bloc.dart';

abstract class AllListEvent extends Equatable {
  const AllListEvent();
}

class GetTodoTaskLoading extends AllListEvent {
  @override
  List<Object?> get props => [];
}

class GetTodoTaskList extends AllListEvent {
  @override
  List<Object?> get props => [];
}
