import 'package:flutter/src/foundation/annotations.dart';
import 'package:todoapp/local_storage/hive/hive_helper.dart';
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
  Future getCategory() {
    try {
      final category = _hiveHelper.getAllData<Category>("category");
      return category;
    } catch (e) {

      throw Exception("Failed to get category: $e");
    }
  }
}
