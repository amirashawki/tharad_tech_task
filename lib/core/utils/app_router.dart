import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tharad_tech_task/features/auth/presentation/manager/Verify_cubit/cubit/verify_pass_cubit.dart';
import 'package:tharad_tech_task/features/auth/presentation/manager/cubit/get_profile_details_cubit.dart';
import 'package:tharad_tech_task/features/auth/presentation/manager/cubit/logout_cubit.dart';
import 'package:tharad_tech_task/features/auth/presentation/manager/cubit/update_data_progile_cubit.dart';
import 'package:tharad_tech_task/features/auth/presentation/manager/register_cubit/cubit/register_cubit.dart'
    show RegisterCubit;
import 'package:tharad_tech_task/features/auth/presentation/views/login_view.dart';
import 'package:tharad_tech_task/features/auth/presentation/views/profile_view.dart';
import 'package:tharad_tech_task/features/auth/presentation/views/register_view.dart';
import 'package:tharad_tech_task/features/auth/presentation/views/verify_password_view.dart';

import '../../features/auth/presentation/manager/login_cubit/cubit/login_cubit.dart';

abstract class AppRouter {
  static const kverifyPasswordView = '/verifyPasswordView';
  static const kSignUpView = '/signUpView';

  static const kloginView = '/loginView';
  static const kProfileView = '/ProfileView';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => BlocProvider(
          create: (context) => RegisterCubit(),
          child: const SignUpView(),
        ),
      ),
      GoRoute(
        path: kProfileView,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => UpdateDataProgileCubit()),

            BlocProvider(
              create: (context) =>
                  GetProfileDetailsCubit()..getProfileDetails(),
            ),
            BlocProvider(create: (context) => LogoutCubit()),
          ],
          child: const ProfileView(),
        ),
      ),
      GoRoute(
        path: kloginView,
        builder: (context, state) => BlocProvider(
          create: (context) => LoginCubit(),
          child: const LoginView(),
        ),
      ),
      GoRoute(
        path: kverifyPasswordView,
        builder: (context, state) => BlocProvider(
          create: (context) => VerifyPassCubit(),
          child: const VerifyPasswordView(),
        ),
      ),
    ],
  );
}
