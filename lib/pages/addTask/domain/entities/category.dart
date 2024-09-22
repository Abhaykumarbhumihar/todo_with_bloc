import 'package:hive_flutter/hive_flutter.dart';

part 'category.g.dart';

@HiveType(typeId: 1)
class TaskCategory extends HiveObject {
  @HiveField(0)
  String categoryName;

  @HiveField(2)
  int categoryId;

  TaskCategory({required this.categoryName, required this.categoryId});
}
