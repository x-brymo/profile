import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger_observer.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger_settings.dart';

import 'app.dart';


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

