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

class GetCategoryForFilterEvent extends AllListEvent {
  @override
  List<Object?> get props => [];
}

class SelectedCategoryForFilterEvent extends AllListEvent {
  final TaskCategory? selectedCategory;
  SelectedCategoryForFilterEvent(this.selectedCategory);

  @override
  List<Object?> get props => [selectedCategory];
}

// New event to fetch tasks by category
class GetTodoTaskByCategoryEvent extends AllListEvent {
  final TaskCategory selectedCategory;

  const GetTodoTaskByCategoryEvent(this.selectedCategory);

  @override
  List<Object?> get props => [selectedCategory];
}

class QuickTextChange extends AllListEvent {
  bool isEmpty;
  QuickTextChange(this.isEmpty);
  @override
  List<Object?> get props => [isEmpty];
}


class AddQuickTaskEvent extends AllListEvent{
  AddTaskModel addTaskModel;
  AddQuickTaskEvent(this.addTaskModel);

  @override
  List<Object?> get props => [addTaskModel];
}