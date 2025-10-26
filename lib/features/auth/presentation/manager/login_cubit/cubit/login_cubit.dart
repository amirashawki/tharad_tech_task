import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tharad_tech_task/features/auth/data/repo/auth_repo_impl.dart'
    show AuthRepoImpl;

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  LoginCubit() : super(LoginInitial());
  Future login() async {
    final prefs = await SharedPreferences.getInstance();
    var result = await AuthRepoImpl().login(
      email: emailController.text,
      passWord: passwordController.text,
    );
    result.fold(
      (failure) {
        emit(Loginfailure(errMassage: failure.errMessge));
      },
      (data) async{
     
        
      await prefs.setString('token', data.token ?? '');
      await prefs.setString('email', data.email ?? '');
      await prefs.setString('name', data.username ?? '');
      await prefs.setString('image', data.image ?? '');
        emit(Loginsuccess());
      },
    );
  }

  void validateUser() {
    if (formKey.currentState?.validate() ?? false) {
      login();
    }
  }
}
