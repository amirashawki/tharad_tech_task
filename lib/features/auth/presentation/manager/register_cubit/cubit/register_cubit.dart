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
    isLoading = true;
    emit(Registerloading());

    try {
      if (selectedImage == null || !selectedImage!.existsSync()) {
        emit(Registerfailure(errMassage: "من فضلك اختر صورة قبل التسجيل"));
        isLoading = false;
        return;
      }

      final result = await AuthRepoImpl().register(
        userName: userNameController.text.trim(),
        email: emailController.text.trim(),
        passWord: passwordController.text.trim(),
        confirmPassword: confirmPasswordController.text.trim(),
        image: selectedImage,
      );

      result.fold(
        (failure) {
          isLoading = false;
          print('❌ Register Error: ${failure.errMessge}');
          emit(Registerfailure(errMassage: failure.errMessge));
        },
        (authModel) async {
          isLoading = false;

          final prefs = await SharedPreferences.getInstance();
          prefs.setString('email', authModel.email ?? '');

          print('✅ Register Success');
          print('📧 Email: ${authModel.email}');
          print('🔢 OTP: ${authModel.otp}');
          print('📩 Message: ${authModel.message}');

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

  @override
  Future<void> close() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
