part of 'get_profile_details_cubit.dart';

@immutable
abstract class GetProfileDetailsState {}

class GetProfileDetailsInitial extends GetProfileDetailsState {}

class GetProfileDetailsLoading extends GetProfileDetailsState {}

class GetProfileDetailsSuccess extends GetProfileDetailsState {
  final AuthModel profile;
  GetProfileDetailsSuccess(this.profile);
}

class GetProfileDetailsFailure extends GetProfileDetailsState {
  final String errMessage;
  GetProfileDetailsFailure({required this.errMessage});
}
