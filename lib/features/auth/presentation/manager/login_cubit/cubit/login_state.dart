part of 'login_cubit.dart';
@immutable

sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class Loginloading extends LoginState {}

final class Loginsuccess extends LoginState {}

final class Loginfailure extends LoginState {
  final String errMassage;

  Loginfailure({required this.errMassage});
}
