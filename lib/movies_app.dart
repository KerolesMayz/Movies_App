import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/config/theme_manager/theme_manager.dart';
import 'package:movies/core/routes_manager/routes_manager.dart';
import 'package:movies/providers/main_provider.dart';
import 'package:provider/provider.dart';

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    var mainProvider = Provider.of<MainProvider>(context);
    return ScreenUtilInit(
      designSize: Size(430, 930),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RoutesManager.router,
          darkTheme: ThemeManager.dark,
          themeMode: ThemeMode.dark,
          initialRoute: mainProvider.initialScreen,
        );
      },
    );
  }
}
