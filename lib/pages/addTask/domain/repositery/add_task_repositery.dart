
import 'package:todoapp/pages/addTask/domain/entities/add_task_model.dart';

import '../entities/category.dart';

abstract class AddTaskRepositery{
Future<void>addCategory(TaskCategory category);
Future<dynamic>getCategory();
Future<dynamic>addTask(AddTaskModel addTaskModel);
Future<List<AddTaskModel>>getAllTask();
}