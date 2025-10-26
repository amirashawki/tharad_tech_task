import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tharad_tech_task/features/auth/data/repo/auth_repo_impl.dart'
    show AuthRepoImpl;

part 'update_data_progile_state.dart';

class UpdateDataProgileCubit extends Cubit<UpdateDataProgileState> {
  UpdateDataProgileCubit() : super(UpdateDataProgileInitial());

  Future<void> updateProfile({
    required String email,
    required String oldPassword,
    required String userName,
    required String newPassword,
    required String confirmPassword,
    File? image,
  }) async {
    emit(UpdateDataProgileLoading());

    final result = await AuthRepoImpl().updateProfileData(
      email: email,
      oldpassWord: oldPassword,
      userName: userName,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
      image: image,
    );

    result.fold(
      (failure) {
        emit(UpdateDataProgileFailure(failure.errMessge));
      },
      (authModel) async {
        emit(UpdateDataProgileSuccess());
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
          'cached_profile',
          jsonEncode({
            'username': authModel.username,
            'email': authModel.email,
            'image': authModel.image,
          }),
        );
        
      },
    );
  }
}
