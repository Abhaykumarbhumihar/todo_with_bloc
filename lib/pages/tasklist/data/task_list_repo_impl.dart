import 'package:todoapp/local_storage/hive/hive_helper.dart';
import 'package:todoapp/pages/addTask/domain/entities/add_task_model.dart';

import '../domain/repositery/task_list_repositery.dart';

class TaskListRepositeryImple extends TaskListRepositery {
  HiveHelper _hiveHelper;
  TaskListRepositeryImple(this._hiveHelper);

  @override
  Future deleteTask() async {
    try {} catch (e) {
      throw Exception("Failed to delete task  $e");
    }
  }

  @override
  Future<List<AddTaskModel>> getAllTaskList() async {
    try {
      return await _hiveHelper.getAllData<AddTaskModel>("task");
    } catch (e) {
      throw Exception("Failed to get todo task list $e");
    }
  }
}
