import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger_observer.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger_settings.dart';

import 'app.dart';

import 'package:code_text_field/code_text_field.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:highlight/languages/dart.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_eval/flutter_eval.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp( ProviderScope(
    observers: [
      
      TalkerRiverpodObserver(
  settings: TalkerRiverpodLoggerSettings(
    enabled: true,
    printStateFullData: false,
    printProviderAdded: true,
    printProviderUpdated: true,
    printProviderDisposed: true,
    printProviderFailed: true,
    // If you want log only AuthProvider events
    providerFilter: (provider) => provider.runtimeType == 'AuthProvider<User>',
  ),
)],
    overrides: [],

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
