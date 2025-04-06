import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger_observer.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger_settings.dart';



import 'core/export.dart';
import 'view/UI/intro/splash_view.dart';

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
 //
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
      onGenerateTitle: (context) => 'Resume Builder',
      navigatorObservers: [
         CustomNavigatorObserver(),
        // FirebaseAnalyticsObserver(analytics: analytics),
        // FirebaseCrashlyticsObserver(crashlytics: crashlytics),
        // FirebasePerformanceObserver(performance: performance),
        // FirebaseRemoteConfigObserver(remoteConfig: remoteConfig),
        // FirebaseMessagingObserver(messaging: messaging),
        // FirebaseDynamicLinksObserver(dynamicLinks: dynamicLinks),
        // FirebaseInAppMessagingObserver(inAppMessaging: inAppMessaging),
        // FirebaseAppCheckObserver(appCheck: appCheck),
        // FirebaseMLKitObserver(mlKit: mlKit),
        // FirebaseStorageObserver(storage: storage),
        // FirebaseFirestoreObserver(firestore: firestore),
        // FirebaseAuthObserver(auth: auth),
      ],
      home: SplashView(),
      onGenerateRoute: RouterApp().generateRoute,
      initialRoute: RouterApp.splash,
    );
  }
}


class CustomNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    print('Navigated to ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    print('Popped ${route.settings.name}');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    print('Replaced ${oldRoute?.settings.name} with ${newRoute?.settings.name}');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    print('Removed ${route.settings.name}');
  }
}
