import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tharad_tech_task/core/utils/app_style.dart';
import 'package:tharad_tech_task/core/utils/constant.dart';
import 'package:tharad_tech_task/core/widgets/custom_button.dart';
import 'package:tharad_tech_task/core/widgets/custom_text_field.dart';
import 'package:tharad_tech_task/core/widgets/showSnackBar.dart';
import 'package:tharad_tech_task/features/auth/presentation/manager/login_cubit/cubit/login_cubit.dart';
import 'package:tharad_tech_task/features/auth/presentation/manager/register_cubit/cubit/register_cubit.dart';
import 'package:tharad_tech_task/features/auth/presentation/views/widgets/custom_raw.dart'
    show CustomRow;
import 'package:tharad_tech_task/features/auth/presentation/views/widgets/upload_profile_image.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  void initState() {
    super.initState();
  }

  File? selectedImage;
  bool obscureTextpassword = true;
  bool obscureTextconfirmPassword = true;
  @override
  Widget build(BuildContext context) {
    var c = context.read<RegisterCubit>();
    return Scaffold(
      body: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is Registerloading) {
            const Center(child: CircularProgressIndicator());
          } else if (state is Registersuccess) {
            showSnackBar(context, text: 'register success');
          } else if (state is Registerfailure) {
            showSnackBar(context, text: state.errMassage);
            log('errorrrrr is ${state.errMassage}');
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
                    SizedBox(height: 70),
                    // SvgPicture.asset('assets/images/logo.svg'),
                    Center(child: Image.asset('assets/images/logo1.png')),
                    SizedBox(height: 30),
                    Center(
                      child: Text(
                        'انشاء حساب جديد',
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
                      "الصورة الشخصية",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,

                        color: AppColors.kbackColor,
                      ),
                    ),
                    SizedBox(height: 10),
                    UploadProfileImage(
                      onImageSelected: (image) {
                        c.setImage(image);
                      },
                    ),
                    const SizedBox(height: 11),

                    Text('اسم المستخدم', style: AppStyle.medium10(context)),
                    const SizedBox(height: 6),
                    CustomTextFormField(
                      controller: c.userNameController,
                      hintText: 'ادخل اسم المستخدم',
                    ),
                    const SizedBox(height: 12),
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
                    const SizedBox(height: 12),

                    Text(
                      'تأكيد كلمة المرور',
                      style: AppStyle.medium10(context),
                    ),
                    const SizedBox(height: 6),
                    CustomTextFormField(
                      obscureText: obscureTextconfirmPassword,
                      prefixIcon: obscureTextconfirmPassword
                          ? IconButton(
                              icon: Icon(
                                Icons.visibility_off,
                                color: Color(0xff265355),
                              ),
                              onPressed: () {
                                setState(() {
                                  obscureTextconfirmPassword = false;
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
                                  obscureTextconfirmPassword = true;
                                });
                              },
                            ),
                      validate: (value) {
                        if (value!.length < 8) {
                          return 'يجب ان تكون كلمة المرور 8 احرف على الاقل';
                        }
                        return null;
                      },
                      controller: c.confirmPasswordController,
                      hintText: 'ادخل كلمة المرور',
                    ),

                    SizedBox(height: 40),

                    state is Loginloading
                        ? const CircularProgressIndicator()
                        : CustomButton(
                            title: 'انشاء حساب جديد',
                            borderRadius: 15,
                            onTap: () {
                              c.registerUser();
                            },
                          ),
                    SizedBox(height: 12),

                    CustomRow(
                      text1: '؟ تسجيل الدخول',
                      text2: 'لديك حساب بالفعل ',
                      onTap: () async {
                        // GoRouter.of(context).push(AppRouter.kloginView);
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
