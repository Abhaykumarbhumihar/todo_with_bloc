
import '../entities/category.dart';

abstract class AddTaskRepositery{
Future<void>addCategory(TaskCategory category);
Future<dynamic>getCategory();
}