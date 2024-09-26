import 'package:flutter/foundation.dart';
import 'package:todoapp/pages/addTask/domain/entities/add_task_model.dart';

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

  Future<dynamic>addTask(AddTaskModel addTaskModel)async{
    return _addTaskRepositery.addTask(addTaskModel);
  }

  Future<List<AddTaskModel>>getTodoTaskList()async{
    return _addTaskRepositery.getAllTask();
  }

  Future<dynamic> upDateTask(AddTaskModel addtaskModel) {
    return _addTaskRepositery.updateTask(addtaskModel);
  }
}