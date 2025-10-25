part of 'verify_pass_cubit.dart';

@immutable
sealed class VerifyPassState {}

final class VerifyPassInitial extends VerifyPassState {}

final class VerifyPassLoading extends VerifyPassState {}

final class VerifyPassSucess extends VerifyPassState {
  final message;

  VerifyPassSucess(this.message);
}

final class VerifyPassFailure extends VerifyPassState {
  final String errMessage;

  VerifyPassFailure({required this.errMessage});
}
