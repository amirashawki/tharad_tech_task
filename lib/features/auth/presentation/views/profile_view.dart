import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tharad_tech_task/core/utils/app_style.dart';
import 'package:tharad_tech_task/core/utils/constant.dart';
import 'package:tharad_tech_task/core/widgets/custom_button.dart';
import 'package:tharad_tech_task/core/widgets/custom_text_field.dart';
import 'package:tharad_tech_task/core/widgets/showSnackBar.dart'
    show showSnackBar;
import 'package:tharad_tech_task/features/auth/presentation/manager/cubit/get_profile_details_cubit.dart';
import 'package:tharad_tech_task/features/auth/presentation/views/widgets/logout.dart';
import 'package:tharad_tech_task/features/auth/presentation/views/widgets/profile_header.dart';
import 'package:tharad_tech_task/features/auth/presentation/views/widgets/upload_profile_image.dart';

import '../manager/cubit/update_data_progile_cubit.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool obscureTextOld = true;
  bool obscureTextNew = true;
  bool obscureTextConfirm = true;

  @override
  void initState() {
    super.initState();
    context.read<GetProfileDetailsCubit>().getProfileDetails();
  }

  @override
  Widget build(BuildContext context) {
    var c = context.watch<GetProfileDetailsCubit>();
    var updateCubit = context.watch<UpdateDataProgileCubit>();

    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: BlocConsumer<UpdateDataProgileCubit, UpdateDataProgileState>(
        listener: (context, state) {
          if (state is UpdateDataProgileSuccess) {
            showSnackBar(context, text: 'تم تحديث البيانات بنجاح ✅');
            context.read<GetProfileDetailsCubit>().getProfileDetails();
          } else if (state is UpdateDataProgileFailure) {
            showSnackBar(context, text: state.errorMessage);
          }
        },
        builder: (context, state) {
          return BlocBuilder<GetProfileDetailsCubit, GetProfileDetailsState>(
            builder: (context, profileState) {
              if (profileState is GetProfileDetailsLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              final imageUrl = profileState is GetProfileDetailsSuccess
                  ? profileState.profile.image
                  : null;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const ProfileHeader(),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            'اسم المستخدم',
                            style: AppStyle.medium10(context),
                          ),
                          const SizedBox(height: 6),
                          CustomTextFormField(
                            controller: c.userNameController,
                            hintText: 'ادخل اسم المستخدم',
                          ),
                          const SizedBox(height: 12),

                          Text(
                            'البريد الإلكتروني',
                            style: AppStyle.medium10(context),
                          ),
                          const SizedBox(height: 6),
                          CustomTextFormField(
                            controller: c.emailController,
                            hintText: 'ادخل البريد الإلكتروني',
                            validate: (value) {
                              if (!value!.contains('@')) {
                                return 'البريد الإلكتروني يجب أن يحتوي على @';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 24),
                          Text(
                            'الصورة الشخصية',
                            style: AppStyle.medium10(context),
                          ),
                          UploadProfileImage(
                            initialImageUrl: imageUrl ?? '',
                            onImageSelected: (image) {
                              c.setImage(image);
                            },
                          ),

                          const SizedBox(height: 24),

                          Text(
                            'كلمة المرور القديمة',
                            style: AppStyle.medium10(context),
                          ),
                          const SizedBox(height: 6),
                          CustomTextFormField(
                            controller: c.oldPasswordController,
                            hintText: 'ادخل كلمة المرور القديمة',
                            obscureText: obscureTextOld,
                            prefixIcon: IconButton(
                              icon: Icon(
                                obscureTextOld
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: const Color(0xff265355),
                              ),
                              onPressed: () {
                                setState(() {
                                  obscureTextOld = !obscureTextOld;
                                });
                              },
                            ),
                          ),

                          const SizedBox(height: 12),
                          Text(
                            'كلمة المرور الجديدة',
                            style: AppStyle.medium10(context),
                          ),
                          const SizedBox(height: 6),
                          CustomTextFormField(
                            controller: c.newPasswordController,
                            hintText: 'ادخل كلمة المرور الجديدة',
                            obscureText: obscureTextNew,
                            prefixIcon: IconButton(
                              icon: Icon(
                                obscureTextNew
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: const Color(0xff265355),
                              ),
                              onPressed: () {
                                setState(() {
                                  obscureTextNew = !obscureTextNew;
                                });
                              },
                            ),
                          ),

                          const SizedBox(height: 12),
                          Text(
                            'تأكيد كلمة المرور',
                            style: AppStyle.medium10(context),
                          ),
                          const SizedBox(height: 6),
                          CustomTextFormField(
                            controller: c.confirmPasswordController,
                            hintText: 'أعد إدخال كلمة المرور الجديدة',
                            obscureText: obscureTextConfirm,
                            prefixIcon: IconButton(
                              icon: Icon(
                                obscureTextConfirm
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: const Color(0xff265355),
                              ),
                              onPressed: () {
                                setState(() {
                                  obscureTextConfirm = !obscureTextConfirm;
                                });
                              },
                            ),
                            validate: (value) {
                              if (value != c.newPasswordController.text) {
                                return 'كلمتا المرور غير متطابقتين';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 35),

                          state is UpdateDataProgileLoading
                              ? const Center(child: CircularProgressIndicator())
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 50,
                                  ),
                                  child: CustomButton(
                                    title: 'حفظ التغييرات',
                                    borderRadius: 15,
                                    onTap: () {
                                      updateCubit.updateProfile(
                                        userName: c.userNameController.text,
                                        email: c.emailController.text,
                                        oldPassword:
                                            c.oldPasswordController.text,
                                        newPassword:
                                            c.newPasswordController.text,
                                        image: c.selectedImage,
                                        confirmPassword:
                                            c.confirmPasswordController.text,
                                      );
                                    },
                                  ),
                                ),
                          const SizedBox(height: 20),
                          logout(),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

