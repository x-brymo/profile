import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:profile/core/theme/style/a_style.dart';
import 'package:profile/view/UI/splash_view.dart';

import 'core/router/router.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp( ProviderScope(
    child: MyApp(),
  ));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resume Builder',
      theme: AppStyle(themeIndex: 1).currentTheme,
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
