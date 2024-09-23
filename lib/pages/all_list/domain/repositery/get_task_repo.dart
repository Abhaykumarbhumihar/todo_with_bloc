import 'package:todoapp/pages/addTask/domain/entities/add_task_model.dart';

abstract class GetTodoTaskRepositery{

  Future<List<AddTaskModel>>getTodoTaskList();
}