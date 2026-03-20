import 'package:flutter/material.dart';

class NavigationService {
  late GlobalKey<NavigatorState> navigatorKey;
  NavigationService(){
    navigatorKey = GlobalKey<NavigatorState>();
  }

  void navigate(Widget widget){
    navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => widget,));
  }
}