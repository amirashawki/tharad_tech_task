import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svg_flutter/svg.dart' show SvgPicture;
import 'package:tharad_tech_task/core/utils/app_style.dart';
import 'package:tharad_tech_task/core/widgets/custom_button.dart';
import 'package:tharad_tech_task/core/widgets/custom_text_field.dart';
import 'package:tharad_tech_task/core/widgets/showSnackBar.dart' show showSnackBar;
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

  @override
  Widget build(BuildContext context) {
    var c = context.read<LoginCubit>();
    return Scaffold(
      body:
           BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is Loginloading) {
                const Center(child: CircularProgressIndicator());
              } else if (state is Loginsuccess) {
                showSnackBar(context, text: 'login success');
            
              } else if (state is Loginfailure) {
                showSnackBar(context, text: state.errMassage);
              }
            },
            builder: (context, state) {
              return
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: 120),
                  // SvgPicture.asset('assets/images/logo.svg'),
                    Center(child: Image.asset('assets/images/logo1.png')),
                  Text(
                  'تسجيل الدخول',
                    style: AppStyle.styleBold20(context).copyWith(
                      fontSize: getResponsiveFontSize(context, fontSize: 24),
                    ),
                  ),
               SizedBox(height: 100),
                  
                  RememberandForgotPassword(),
                              
                  state is Loginloading
                      ? const CircularProgressIndicator()
                      :
                  CustomButton(
                    title: 'انشاء حساب جديد',
                    borderRadius: 15,
                    onTap: () {
                      // c.validateUser();
                    },
                  ),
                  SizedBox(height: 20),
                              
                  CustomRow(
                    text1: ' لديك حساب ',
                    text2: 'تسجيل الدخول',
                    onTap: () async {
                      // GoRouter.of(
                      //   context,
                      // ).push(AppRouter.kSignUpView);
                    },
                  ),
                ],
              ),

           ), );
            } ),
      
    );
  }
}
