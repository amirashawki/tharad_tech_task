

import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const klogoView = '/logoView';
  static const kTestView = '/TestView';
  static const kAssessmentView = '/assessmentView';
  static const kTestResultView = '/TestResultView';
  static const kloginView = '/loginView';
  static const kPasswordResetView = '/PasswordResetView';
  

  static final router = GoRouter(
    routes: [
     
    ],
  );
}
