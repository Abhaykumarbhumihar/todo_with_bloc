import '../../../addTask/domain/entities/add_task_model.dart';
import '../repositery/get_task_repo.dart';

class GetTodoTaskUseCase {
  GetTodoTaskRepositery _getTodoTaskRepositery;

  GetTodoTaskUseCase(this._getTodoTaskRepositery);

  Future<List<AddTaskModel>> getTodoList() async {
    return _getTodoTaskRepositery.getTodoTaskList();
  }
  Future<dynamic>getCategory()async{
    return _getTodoTaskRepositery.getCategory();
  }

}
