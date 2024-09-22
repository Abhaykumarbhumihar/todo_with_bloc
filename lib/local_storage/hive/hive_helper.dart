import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/pages/addTask/domain/entities/add_task_model.dart';
import 'package:todoapp/pages/addTask/domain/entities/category.dart';

class HiveHelper {
  static final HiveHelper _instance = HiveHelper._internal();

  factory HiveHelper() {
    return _instance;
  }

  HiveHelper._internal();

  /// Initialize Hive
  Future<void> init() async {
    await Hive.initFlutter(); // Initializes Hive for Flutter
    Hive.registerAdapter(TaskCategoryAdapter());
    Hive.registerAdapter(AddTaskModelAdapter());
  }

  /// Open a box
  /// Returns a Box of the specified type
  Future<Box<T>> openBox<T>(String boxName) async {
    try {
      if (Hive.isBoxOpen(boxName)) {
        return Hive.box<T>(boxName);
      } else {
        return await Hive.openBox<T>(boxName);
      }
    } catch (e) {
      throw Exception("Failed to open box: $boxName, error: $e");
    }
  }

  /// Add data to a box
  Future<void> addData<T>(String boxName, T data) async {
    try {
      final box = await openBox<T>(boxName);
      await box.add(data);
    } catch (e) {
      throw Exception("Failed to add data: $e");
    }
  }

  /// Add data with a specific key
  Future<void> addDataWithKey<T>(String boxName, dynamic key, T data) async {
    try {
      final box = await openBox<T>(boxName);
      await box.put(key, data);
    } catch (e) {
      throw Exception("Failed to add data with key: $e");
    }
  }

  /// Get all data from a box
  Future<List<T>> getAllData<T>(String boxName) async {
    try {
      final box = await openBox<T>(boxName);
      return box.values.toList().cast<T>();
    } catch (e) {
      throw Exception("Failed to retrieve data: $e");
    }
  }

  /// Get data by a specific key
  Future<T?> getDataByKey<T>(String boxName, dynamic key) async {
    try {
      final box = await openBox<T>(boxName);
      return box.get(key);
    } catch (e) {
      throw Exception("Failed to get data by key: $e");
    }
  }

  /// Update data by a specific key
  Future<void> updateData<T>(String boxName, dynamic key, T data) async {
    try {
      final box = await openBox<T>(boxName);
      await box.put(key, data);
    } catch (e) {
      throw Exception("Failed to update data: $e");
    }
  }

  /// Delete data by a specific key
  Future<void> deleteDataByKey<T>(String boxName, dynamic key) async {
    try {
      final box = await openBox<T>(boxName);
      await box.delete(key);
    } catch (e) {
      throw Exception("Failed to delete data by key: $e");
    }
  }

  /// Clear all data from a box
  Future<void> clearBox(String boxName) async {
    try {
      final box = await openBox(boxName);
      await box.clear();
    } catch (e) {
      throw Exception("Failed to clear box: $e");
    }
  }

  /// Close a box when it's no longer needed
  Future<void> closeBox(String boxName) async {
    try {
      final box = await openBox(boxName);
      await box.close();
    } catch (e) {
      throw Exception("Failed to close box: $e");
    }
  }

  /// Check if a box contains a certain key
  Future<bool> containsKey(String boxName, dynamic key) async {
    try {
      final box = await openBox(boxName);
      return box.containsKey(key);
    } catch (e) {
      throw Exception("Failed to check key in box: $e");
    }
  }

  /// Delete entire box
  Future<void> deleteBox(String boxName) async {
    try {
      if (Hive.isBoxOpen(boxName)) {
        await Hive.box(boxName).deleteFromDisk();
      }
    } catch (e) {
      throw Exception("Failed to delete box: $e");
    }
  }
}
