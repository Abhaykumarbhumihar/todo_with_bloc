import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todoapp/common/routes/pages.dart';
import 'package:todoapp/common/routes/routes.dart';
import 'package:todoapp/local_storage/hive/hive_helper.dart';
import 'common/servicelocator/serview_locator.dart';

void main()async {
  serviewLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await HiveHelper().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [...AppPages.allblocProviders(context)],
        child: MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', ''), // English
      const Locale('hi', ''), // Hindi
         ],
          locale: Locale(/*state.currentLanguage*/'en_US'),
          debugShowCheckedModeBanner: false,
          title: 'Todo App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
            onGenerateRoute: AppPages.GenerateRouteSettingss,
            initialRoute: AppRoutes.ALL_TASK_LIST,
        ));
  }
}

