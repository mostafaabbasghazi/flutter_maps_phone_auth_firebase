part of 'authphone_cubit.dart';


abstract class PhoneAuthState {}

class PhoneAuthInitial extends PhoneAuthState {}

class Loading extends PhoneAuthState {}

class ErrorOccurred extends PhoneAuthState {
  final String errorMsg;

  ErrorOccurred({required this.errorMsg});
}

class PhoneNumberSubmited extends PhoneAuthState{}

class PhoneOTPVerified extends PhoneAuthState{}

class SelectedImage extends PhoneAuthState{
  final File file;
  SelectedImage({required this.file});
}

class UserDataUploaded extends PhoneAuthState{}
class UserExist extends PhoneAuthState{}