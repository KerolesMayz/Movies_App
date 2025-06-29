import 'package:flutter/material.dart';
import 'package:movies/movies_app.dart';
import 'package:movies/providers/main_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MainProvider mainProvider = MainProvider();
  await mainProvider.getInitialScreen();
  runApp(
    ChangeNotifierProvider<MainProvider>.value(
      value: mainProvider,
      child: MoviesApp(),
    ),
  );
}
