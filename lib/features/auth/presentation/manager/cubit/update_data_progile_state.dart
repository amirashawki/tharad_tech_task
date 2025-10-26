part of 'update_data_progile_cubit.dart';

@immutable
sealed class UpdateDataProgileState {}

final class UpdateDataProgileInitial extends UpdateDataProgileState {}
final class UpdateDataProgileLoading extends UpdateDataProgileState {}
final class UpdateDataProgileSuccess extends UpdateDataProgileState {}
final class UpdateDataProgileFailure extends UpdateDataProgileState {
  final String errorMessage;

  UpdateDataProgileFailure(this.errorMessage);
}
