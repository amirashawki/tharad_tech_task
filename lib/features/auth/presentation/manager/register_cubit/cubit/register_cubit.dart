import 'dart:io' show File;

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tharad_tech_task/features/auth/data/repo/auth_repo_impl.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;
  File? selectedImage;

  void setImage(File image) {
    selectedImage = image;
    emit(RegisterImagePicked());
  }

  Future<void> registerUser() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    isLoading = true;
    emit(Registerloading());

    try {
      if (selectedImage == null || !selectedImage!.existsSync()) {
        emit(Registerfailure(errMassage: "من فضلك اختر صورة قبل التسجيل"));
        isLoading = false;
        return;
      }

      final registerResult = await AuthRepoImpl().register(
        userName: userNameController.text.trim(),
        email: emailController.text.trim(),
        confirmPassword: confirmPasswordController.text.trim(),
        passWord: passwordController.text.trim(),
        image: selectedImage,
      );

      registerResult.fold(
        (failure) {
          isLoading = false;
          print('❌ Register Error: ${failure.errMessge}');
          emit(Registerfailure(errMassage: failure.errMessge));
        },
        (data) {
          isLoading = false;
          if (data.otp != null) {
            print('✅ Register successful, OTP is: ${data.otp}');
            preferences.setInt('otp', data.otp!);
            preferences.setString('email', emailController.text.trim());
          }
          emit(Registersuccess());
        },
      );
    } catch (e) {
      isLoading = false;
      print('⚠️ Unexpected Error: $e');
      emit(Registerfailure(errMassage: e.toString()));
    }
  }

  void validateRegister() {
    if (formKey.currentState?.validate() ?? false) {
      registerUser();
    }
  }

  Future<void> close() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
