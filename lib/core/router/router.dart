import 'package:flutter/material.dart';
import 'package:profile/view/UI/splash_view.dart';

import '../../view/UI/code/editor_code.dart';
import '../../view/UI/intro_view.dart';
import '../../view/UI/projects_view.dart';
import '../../view/UI/profile.dart';

class RouterApp{
  static const String home = '/home';
  static const String intro = '/intro';
  static const String projects = '/projects';
  static const String aboute = '/aboute';
  static const String splash = '/splash';
  static const String editor = '/editor';
  
  RouterApp._();
  RouterApp._init();
  
  static final RouterApp _instance = RouterApp._init();
  factory RouterApp() => _instance;
  Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case home:
        return MaterialPageRoute(builder: (_) => PortfolioScreen());
      case intro:
        return MaterialPageRoute(builder: (_) => IntroView());
      case projects:
        return MaterialPageRoute(builder: (_) => ProjectsView());
      case splash:
        return MaterialPageRoute(builder: (_) => SplashView());
      case editor:
        return MaterialPageRoute(builder: (_) => CodeEditorScreen());
      default:
        return MaterialPageRoute(builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ));
    }
  }
}