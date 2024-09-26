part of 'add_task_bloc.dart';

abstract class AddTaskEvent extends Equatable {
  const AddTaskEvent();
}

class AddCategoryEvent extends AddTaskEvent {
  String categoryName;
  AddCategoryEvent(this.categoryName);

  @override
  List<Object?> get props => [categoryName];
}

class GetCategoryEvent extends AddTaskEvent {
  @override
  List<Object?> get props => [];
}

class SelectCategoryEvent extends AddTaskEvent {
  final TaskCategory? selectedCategory;

  SelectCategoryEvent(this.selectedCategory);

  @override
  List<Object?> get props => [selectedCategory];
}

class AddTodoTaskEvent extends AddTaskEvent {
  AddTaskModel addTaskModel;
  AddTodoTaskEvent(this.addTaskModel);

  @override
  List<Object?> get props => [addTaskModel];
}

class UpdateTodoTaskEvent extends AddTaskEvent {
  AddTaskModel addTaskModel;
  UpdateTodoTaskEvent(this.addTaskModel);

  @override
  List<Object?> get props => [addTaskModel];
}

class DateAddedEvent extends AddTaskEvent {
  bool isAdded;
  DateAddedEvent(this.isAdded);

  @override
  List<Object?> get props => [isAdded];
}

class TimeFielShowdEvent extends AddTaskEvent {
  bool isAdded;
  TimeFielShowdEvent(this.isAdded);

  @override
  List<Object?> get props => [isAdded];
}

class TimeAddedEvent extends AddTaskEvent {
  bool isAdded;
  TimeAddedEvent(this.isAdded);

  @override
  List<Object?> get props => [isAdded];
}
