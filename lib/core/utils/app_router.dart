import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tharad_tech_task/features/auth/presentation/manager/register_cubit/cubit/register_cubit.dart';
import 'package:tharad_tech_task/features/auth/presentation/views/login_view.dart';
import 'package:tharad_tech_task/features/auth/presentation/views/register_view.dart';

abstract class AppRouter {
  static const klogoView = '/logoView';
  static const kTestView = '/TestView';
  static const kAssessmentView = '/assessmentView';
  static const kTestResultView = '/TestResultView';
  static const kloginView = '/loginView';
  static const kPasswordResetView = '/PasswordResetView';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => BlocProvider(
          create: (context) => RegisterCubit(),
          child: const SignUpView(),
        ),
      ),
      GoRoute(path: kloginView, builder: (context, state) => const LoginView()),
    ],
  );
}
