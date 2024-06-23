
import 'package:flutter/material.dart';
import 'package:map/const/rout_name.dart';
import 'package:map/persention/screens/login.dart';

class AppRout {

  Route<dynamic>?  onGenerateRoute(RouteSettings settings){
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_)=>const LoginPage());
        
      default:
    }
  }
}