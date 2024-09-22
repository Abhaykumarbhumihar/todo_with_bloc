import 'package:flutter/foundation.dart';

import '../entities/category.dart';
import '../repositery/add_task_repositery.dart';

class AddTaskUseCase {
  AddTaskRepositery _addTaskRepositery;

  AddTaskUseCase(this._addTaskRepositery);

  Future<void> addCategory(TaskCategory category) async {
   return _addTaskRepositery.addCategory(category);
  }

  Future<dynamic>getCategory()async{
    return _addTaskRepositery.getCategory();
  }
}