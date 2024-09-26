import 'package:todoapp/pages/addTask/domain/entities/add_task_model.dart';

abstract class TaskListRepositery{
  Future<List<AddTaskModel>>getAllTaskList();
  Future<dynamic>deleteTask();

}