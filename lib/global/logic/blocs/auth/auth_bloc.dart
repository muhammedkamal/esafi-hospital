import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/admin.dart';
import '../../../services/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  AuthBloc(this._authService) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is SignIn) {
        emit(AuthLoading());
        try {
          await _authService.loginUsingEmailAndPassword(
              event.email, event.password);
          final Admin? user = await _authService.currentUser;
          emit(Authenticated(user: user!));
        } catch (e) {
          emit(AuthError(message: e.toString()));
        }
      } else if (event is SignUp) {
        emit(AuthLoading());
        try {
          await _authService.registerUsingEmailAndPassword(event.userData);
          final Admin? user = await _authService.currentUser;
          emit(Authenticated(user: user!));
        } catch (e) {
          emit(AuthError(message: e.toString()));
        }
      } else if (event is SignOut) {
        emit(AuthLoading());
        try {
          await _authService.logOut();
          emit(Unauthenticated());
        } catch (e) {
          emit(AuthError(message: e.toString()));
        }
      } else if (event is CheckAuth) {
        emit(AuthChecking());
        try {
          final Admin? user = await _authService.currentUser;
          if (user != null) {
            emit(Authenticated(user: user));
          } else {
            emit(Unauthenticated());
          }
        } catch (e) {
          emit(AuthError(message: e.toString()));
        }
      } else if (event is ChangePassword) {
        emit(AuthLoading());
        try {
          // await _authService.changePassword(event.oldPassword, event.newPassword);
          // emit(Authenticated(user: await _authService.currentUser!));
        } catch (e) {
          emit(AuthError(message: e.toString()));
        }
      }
    });
  }
  
}
