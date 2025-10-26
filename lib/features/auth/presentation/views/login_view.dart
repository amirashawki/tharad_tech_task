import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tharad_tech_task/core/utils/app_router.dart';
import 'package:tharad_tech_task/core/utils/app_style.dart';
import 'package:tharad_tech_task/core/widgets/custom_button.dart';
import 'package:tharad_tech_task/core/widgets/custom_text_field.dart';
import 'package:tharad_tech_task/core/widgets/showSnackBar.dart'
    show showSnackBar;
import 'package:tharad_tech_task/features/auth/presentation/manager/login_cubit/cubit/login_cubit.dart'
    show LoginCubit, LoginState, Loginloading, Loginsuccess, Loginfailure;
import 'package:tharad_tech_task/features/auth/presentation/views/widgets/Remember_and_Forgot_Password.dart';
import 'package:tharad_tech_task/features/auth/presentation/views/widgets/custom_raw.dart'
    show CustomRow;

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  void initState() {
    super.initState();
  }

  bool obscureTextpassword = true;
  bool obscureTextconfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    var c = context.read<LoginCubit>();
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is Loginsuccess) {
            showSnackBar(context, text: 'login success');
            GoRouter.of(context).go(AppRouter.kProfileView);
          } else if (state is Loginfailure) {
            showSnackBar(context, text: state.errMassage);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: c.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 120),
                    // SvgPicture.asset('assets/images/logo.svg'),
                    Center(child: Image.asset('assets/images/logo1.png')),
                    SizedBox(height: 100),
                    Center(
                      child: Text(
                        'تسجيل الدخول',
                        style: AppStyle.styleBold20(context).copyWith(
                          fontSize: getResponsiveFontSize(
                            context,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'البريد الالكتروني',
                      style: AppStyle.medium10(context),
                    ),
                    const SizedBox(height: 6),
                    CustomTextFormField(
                      controller: c.emailController,
                      hintText: 'ادخل البريد الالكتروني',

                      validate: (value) {
                        if (!value!.contains('@')) {
                          return 'Email should contains @';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    Text('كلمة المرور', style: AppStyle.medium10(context)),
                    const SizedBox(height: 6),
                    CustomTextFormField(
                      obscureText: obscureTextpassword,
                      prefixIcon: obscureTextpassword
                          ? IconButton(
                              icon: Icon(
                                Icons.visibility_off,
                                color: Color(0xff265355),
                              ),
                              onPressed: () {
                                setState(() {
                                  obscureTextpassword = false;
                                });
                              },
                            )
                          : IconButton(
                              icon: Icon(
                                Icons.visibility,
                                color: Color(0xff265355),
                              ),
                              onPressed: () {
                                setState(() {
                                  obscureTextpassword = true;
                                });
                              },
                            ),
                      validate: (value) {
                        if (value!.length < 8) {
                          return 'يجب ان تكون كلمة المرور 8 احرف على الاقل';
                        }
                        return null;
                      },
                      controller: c.passwordController,
                      hintText: 'ادخل كلمة المرور',
                    ),
                    SizedBox(height: 8),
                    RememberandForgotPassword(),
                    SizedBox(height: 40),

                    state is Loginloading
                        ? Center(child: const CircularProgressIndicator())
                        : CustomButton(
                            title: 'تسجيل الدخول',
                            borderRadius: 15,
                            onTap: () {
                              c.validateUser();
                            },
                          ),
                    SizedBox(height: 12),

                    CustomRow(
                      text1: 'انشاء حساب جديد',
                      text2: ' ليس لديك حساب؟ ',
                      onTap: () async {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
