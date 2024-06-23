
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map/const/rout_name.dart';
import 'package:map/persention/screens/login.dart';
import 'package:map/persention/screens/otp_screen.dart';

class AppRout {

  Route<dynamic>?  onGenerateRoute(RouteSettings settings){
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_)=> BlocProvider(
          create: (context) => ,
          child: LoginPage(),
        ));

      case otpScrren:
        return MaterialPageRoute(builder: (_)=>BlocProvider(
          create: (context)=>,
          child: OtpScreen(),
        ));
    }
  }
}