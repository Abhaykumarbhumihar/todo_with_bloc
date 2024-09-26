import 'package:flutter/src/foundation/annotations.dart';
import 'package:todoapp/local_storage/hive/hive_helper.dart';
import 'package:todoapp/pages/addTask/domain/entities/add_task_model.dart';
import 'package:todoapp/pages/addTask/domain/repositery/add_task_repositery.dart';

import '../domain/entities/category.dart';

class AddTaskRepositeryImpl extends AddTaskRepositery {
  HiveHelper _hiveHelper;

  AddTaskRepositeryImpl(this._hiveHelper);

  @override
  Future<void> addCategory(TaskCategory category) async {
    try {
      await _hiveHelper.addData("category", category);
    } catch (e) {
      throw Exception("Failed to add category: $e");
    }
  }

  @override
  Future addTask(AddTaskModel addTaskModel) async {
    try {
      await _hiveHelper.addDataWithKey("task",  addTaskModel.id, addTaskModel);
    } catch (e) {
      throw Exception("Failed to add todo task: $e");
    }
  }

  @override
  Future getCategory() {
    try {
      final category = _hiveHelper.getAllData<Category>("category");
      return category;
    } catch (e) {
      throw Exception("Failed to get category: $e");
    }
  }

  @override
  Future<List<AddTaskModel>> getAllTask() async {
    try {
      final todoTaskList = _hiveHelper.getAllData<AddTaskModel>("task");
      return todoTaskList;
    } catch (e) {
      throw Exception("Failed to get todo task list: $e");
    }
  }

  @override
  Future<void> updateTask(AddTaskModel updatedTask) async {
    try {
      final taskId = updatedTask.id;
print("ID AT UPDATE TIME $taskId");
      // Optional: Check if the task exists before updating
      final existingTask = await _hiveHelper.getDataByKey<AddTaskModel>("task", taskId);
      if (existingTask == null) {
        print("Task with id $taskId does not exist.");
        throw Exception("Task with id $taskId does not exist.");
      }

      await _hiveHelper.updateData("task", taskId, updatedTask);
    } catch (e) {
      throw Exception("Failed to update todo task: $e");
    }
  }
}
