import 'package:flutter/material.dart';

import 'core/export.dart';
import 'view/UI/splash_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resume Builder',
      theme: AppStyle(themeIndex: 0).currentTheme,
      themeAnimationCurve: Curves.easeInOut,
      themeAnimationDuration: const Duration(milliseconds: 500),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      home: SplashView(),
      onGenerateRoute: RouterApp().generateRoute,
      initialRoute: RouterApp.splash,
    );
  }
}