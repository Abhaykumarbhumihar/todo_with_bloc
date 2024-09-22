import 'package:get_it/get_it.dart';
import 'package:todoapp/local_storage/hive/hive_helper.dart';
import 'package:todoapp/pages/addTask/data/add_task_impl.dart';
import 'package:todoapp/pages/addTask/domain/repositery/add_task_repositery.dart';
import 'package:todoapp/pages/addTask/domain/usecase/add_task_usecase.dart';

import '../../pages/addTask/presentation/bloc/add_task_bloc.dart';

final GetIt getIt=GetIt.instance;

void serviewLocator(){
  getIt.registerLazySingleton<HiveHelper>(() => HiveHelper());
  getIt.registerLazySingleton<AddTaskRepositery>(() => AddTaskRepositeryImpl(getIt<HiveHelper>()));
  getIt.registerLazySingleton<AddTaskUseCase>(() => AddTaskUseCase(getIt<AddTaskRepositery>()));
  getIt.registerFactory<AddTaskBloc>(() => AddTaskBloc(getIt<AddTaskUseCase>()));

}