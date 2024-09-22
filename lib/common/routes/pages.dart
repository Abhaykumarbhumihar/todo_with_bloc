import 'package:flutter/material.dart';
import 'package:todoapp/common/routes/routes.dart';
import 'package:todoapp/common/servicelocator/serview_locator.dart';
import 'package:todoapp/pages/addTask/presentation/bloc/add_task_bloc.dart';
import 'package:todoapp/pages/all_list/presentation/ui/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/pages/tasklist/presentation/ui/task_list.dart';
import '../../pages/addTask/domain/usecase/add_task_usecase.dart';
import '../../pages/addTask/presentation/ui/add_todo.dart';

class AppPages {
  static List<PageEntity> routes() {
    return [
      PageEntity(
        page: HomePage(),
        route: AppRoutes.ALL_TASK_LIST,
      ),
      PageEntity(
          page: AddTodo(),
          route: AppRoutes.ADD_TASK_LIST,
          bloc: BlocProvider(
            create: (_) {
              final bloc = AddTaskBloc(getIt<AddTaskUseCase>());
              bloc.add(GetCategoryEvent()); // Dispatch the event after creation
              return bloc;
            },
          )),
      PageEntity(
        page: TaskList(),
        route: AppRoutes.TASK_LIST,
      )
    ];
  }

  static List<dynamic> allblocProviders(BuildContext context) {
    List<dynamic> blocProvider = <dynamic>[];
    for (var blocEntity in routes()) {
      if (blocEntity.bloc != null) {
        blocProvider.add(blocEntity.bloc);
      }
    }
    return blocProvider;
  }

  static MaterialPageRoute GenerateRouteSettingss(RouteSettings settings) {
    if (settings.name != null) {
      var result = routes().where((element) => element.route == settings.name);
      if (result.isNotEmpty) {
        return MaterialPageRoute(
            builder: (_) => result.first.page, settings: settings);
      }
    }
    print("In valid route name ${settings.name}");
    return MaterialPageRoute(builder: (_) => HomePage());
  }
}

class PageEntity {
  String route;
  Widget page;
  dynamic bloc;

  PageEntity({required this.page, this.bloc, required this.route});
}
