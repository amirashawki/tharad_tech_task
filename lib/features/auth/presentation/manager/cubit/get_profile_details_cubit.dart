// 📁 get_profile_details_cubit.dart

import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tharad_tech_task/features/auth/data/model/auth_model.dart';
import 'package:tharad_tech_task/features/auth/data/repo/auth_repo_impl.dart';

part 'get_profile_details_state.dart';


class GetProfileDetailsCubit extends Cubit<GetProfileDetailsState> {
  GetProfileDetailsCubit() : super(GetProfileDetailsInitial());

  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  File? selectedImage;
  String? userImage;

  Future<void> getProfileDetails() async {
    emit(GetProfileDetailsLoading());
    final prefs = await SharedPreferences.getInstance();

    final cached = prefs.getString('cached_profile');
    if (cached != null) {
      final cachedData = jsonDecode(cached);
      userNameController.text = cachedData['name'] ?? '';
      emailController.text = cachedData['email'] ?? '';
      userImage = cachedData['image'];
      emit(GetProfileDetailsSuccess(AuthModel.fromJson(cachedData)));
    }

   
    final result = await AuthRepoImpl().getprofileData();

    result.fold(
      (failure) {
        if (cached == null) {
          emit(GetProfileDetailsFailure(errMessage: failure.errMessge));
        }
      },
      (data) async {
        
        await prefs.setString('user_name', data.username ?? '');
        await prefs.setString('user_email', data.email ?? '');
        await prefs.setString('user_image', data.image ?? '');

        await prefs.setString('cached_profile', jsonEncode({
          'name': data.username,
          'email': data.email,
          'image': data.image,
        }));

        userNameController.text = data.username ?? '';
        emailController.text = data.email ?? '';
        userImage = data.image;
        emit(GetProfileDetailsSuccess(data));
      },
    );
  }

  void setImage(File image) {
    selectedImage = image;
  }
}

