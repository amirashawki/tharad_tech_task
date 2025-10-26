part of 'logout_cubit.dart';

@immutable
sealed class LogoutState {}

final class LogoutInitial extends LogoutState {}


class LogoutLoading extends LogoutState {}

class LogoutSuccess extends LogoutState {
  final String message;
  LogoutSuccess(this.message);
}

class LogoutFailure extends LogoutState {
  final String error;
  LogoutFailure(this.error);
}
