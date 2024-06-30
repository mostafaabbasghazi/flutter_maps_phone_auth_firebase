
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map/bussnis_logic/auth/cubit/authphone_cubit.dart';
import 'package:map/const/rout_name.dart';


import 'package:map/persention/screens/login.dart';
import 'package:map/persention/screens/otp_screen.dart';


import 'persention/screens/infoData.dart';

class AppRout {
 
 
  PhoneAuthCubit authphoneCubit=PhoneAuthCubit();

  Route<dynamic>?  onGenerateRoute(RouteSettings settings){
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_)=> BlocProvider<PhoneAuthCubit>.value(
          
          value: authphoneCubit ,
          child: LoginScreen(),
        ));

      case otpScrren:
      final phone=settings.arguments;
        return MaterialPageRoute(builder: (_)=>BlocProvider<PhoneAuthCubit>.value(
          value:authphoneCubit,
          child: OtpScreen(phoneNumber: phone,),
        ));
      case personalInformations:
        return MaterialPageRoute(builder: (_)=>BlocProvider<PhoneAuthCubit>.value(
          value: authphoneCubit,
          child:InfoData(),
          ))  ;
      

    }
  }
}