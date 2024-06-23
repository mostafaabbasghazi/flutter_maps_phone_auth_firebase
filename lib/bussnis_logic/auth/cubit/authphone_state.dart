part of 'authphone_cubit.dart';

@immutable
sealed class AuthphoneState {}

final class AuthphoneInitial extends AuthphoneState {}

final class Loadding extends AuthphoneCubit{}

final class ErrorDecrued extends AuthphoneCubit{
  final String error;
  ErrorDecrued({required this.error});
}

final class PhoneNumberSubmited extends AuthphoneCubit{}

final class PhoneOtpVertified extends AuthphoneCubit{}