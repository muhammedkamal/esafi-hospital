part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignIn extends AuthEvent {
  final String email;
  final String password;

  const SignIn({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignUp extends AuthEvent {
  final Map<String, dynamic> userData;

  const SignUp({required this.userData});

  @override
  List<Object> get props => [userData];
}

class SignOut extends AuthEvent {}

class CheckAuth extends AuthEvent {}

class ChangePassword extends AuthEvent {
  final String oldPassword;
  final String newPassword;
  const ChangePassword({required this.oldPassword, required this.newPassword});

  @override
  List<Object> get props => [oldPassword, newPassword];
}

class ResetPassword extends AuthEvent {
  final String email;
  const ResetPassword({required this.email});

  @override
  List<Object> get props => [email];
}
