import 'package:todoapp/pages/addTask/domain/entities/add_task_model.dart';

import '../repositery/task_list_repositery.dart';

class TaskListUseCase {
  final TaskListRepositery _taskListRepositery;
  TaskListUseCase(this._taskListRepositery);

  Future<List<AddTaskModel>> getAllTaskList() {
    return _taskListRepositery.getAllTaskList();
  }

  Future<dynamic>deleteTask(String taskId){
    return _taskListRepositery.deleteTask(taskId);
  }
}
