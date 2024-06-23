import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'authphone_state.dart';

class AuthphoneCubit extends Cubit<AuthphoneState> {
  AuthphoneCubit() : super(AuthphoneInitial());
}
