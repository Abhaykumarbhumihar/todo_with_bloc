import 'package:todoapp/local_storage/hive/hive_helper.dart';
import 'package:todoapp/pages/addTask/domain/entities/add_task_model.dart';

import '../../domain/repositery/get_task_repo.dart';

class GetTodoTaskRepositeryImpl extends GetTodoTaskRepositery {
  HiveHelper _hiveHelper;

  GetTodoTaskRepositeryImpl(this._hiveHelper);

  @override
  Future<List<AddTaskModel>> getTodoTaskList() async {
    try {
      return await _hiveHelper.getAllData<AddTaskModel>("task");
    } catch (e) {
      throw Exception("Failed to get todo task list $e");
    }
  }
}
