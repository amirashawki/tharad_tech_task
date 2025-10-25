part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class Registerloading extends RegisterState {}

final class Registersuccess extends RegisterState {}

final class Registerfailure extends RegisterState {
  final String errMassage;

  Registerfailure({required this.errMassage});
}
class RegisterImagePicked extends RegisterState {}