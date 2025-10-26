import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tharad_tech_task/core/utils/app_router.dart';
import 'package:tharad_tech_task/core/utils/app_style.dart';
import 'package:tharad_tech_task/core/utils/constant.dart';
import 'package:tharad_tech_task/core/widgets/custom_button.dart';
import 'package:tharad_tech_task/core/widgets/showSnackBar.dart'
    show showSnackBar;
import 'package:tharad_tech_task/features/auth/presentation/manager/Verify_cubit/cubit/verify_pass_cubit.dart';
import 'package:tharad_tech_task/features/auth/presentation/views/widgets/text_field_code.dart';

class VerityPassword extends StatefulWidget {
  const VerityPassword({super.key});

  @override
  State<VerityPassword> createState() => _VerityPasswordState();
}

class _VerityPasswordState extends State<VerityPassword> {
  final List<TextEditingController> controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  int fillBox = 0;
  String? email;

  void onChange(String value, int index) {
    if (value.length == 1) {
      setState(() {
        fillBox++;
      });
      if (index < controllers.length - 1) {
        FocusScope.of(context).nextFocus();
      }
    } else if (value.isEmpty) {
      setState(() {
        fillBox--;
      });
      if (index > 0) {
        FocusScope.of(context).previousFocus();
      }
    }
  }

  void initState() {
    super.initState();
    loadEmailandOtp();
  }

  Future<void> loadEmailandOtp() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
    });
  }

  Widget build(BuildContext context) {
    return BlocConsumer<VerifyPassCubit, VerifyPassState>(
      listener: (context, state) {
        if (state is VerifyPassSucess) {
          print('✅ OTP Confirm Message: ${state.message}');
          print(state.message);
          showSnackBar(context, text: state.message);
          GoRouter.of(context).push(AppRouter.kloginView);
        } else if (state is VerifyPassFailure) {
          showSnackBar(context, text: state.errMessage);
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: List.generate(4, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: TextFieldCode(
                    controllers: controllers[index],
                    onChanged: (value) {
                      onChange(value, index);
                    },
                  ),
                );
              }),
            ),
            SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'إعادة إرسال الرمز',
                        style: TextStyle(
                          color: AppColors.kPrimaryColor,
                          fontSize: getResponsiveFontSize(
                            context,
                            fontSize: 12,
                          ),
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      Text(
                        ' لم يصلك  ؟',
                        style: TextStyle(
                          color: AppColors.kbackColor,
                          fontSize: getResponsiveFontSize(
                            context,
                            fontSize: 12,
                          ),

                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '00:59 Sec',
                    style: TextStyle(
                      color: Color(0xff998C8C),
                      fontSize: getResponsiveFontSize(context, fontSize: 10),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),

            state is VerifyPassLoading
                ? Center(child: CircularProgressIndicator())
                : CustomButton(
                    borderRadius: 25,
                    title: 'المتابعة',
                    onTap: () {
                      final otp = controllers.map((c) => c.text).join();
                      BlocProvider.of<VerifyPassCubit>(
                        context,
                      ).verifyPassWord(otp: otp, email: email);
                    },
                  ),
          ],
        );
      },
    );
  }
}
