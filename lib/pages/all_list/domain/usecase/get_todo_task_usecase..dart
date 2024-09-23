import '../../../addTask/domain/entities/add_task_model.dart';
import '../repositery/get_task_repo.dart';

class GetTodoTaskUseCase {
  GetTodoTaskRepositery _getTodoTaskRepositery;

  GetTodoTaskUseCase(this._getTodoTaskRepositery);

  Future<List<AddTaskModel>> getCategory() async {
    return _getTodoTaskRepositery.getTodoTaskList();
  }
}
