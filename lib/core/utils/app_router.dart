

abstract class AppRouter {
  static const klogoView = '/logoView';
  static const kTestView = '/TestView';
  static const kAssessmentView = '/assessmentView';
  static const kTestResultView = '/TestResultView';
  static const kloginView = '/loginView';
  static const kPasswordResetView = '/PasswordResetView';
  static const kSetNewPassword = '/SetNewPassword';
  static const kHomeView = '/homeview';
  static const kPremiumView = '/PremiumView';
  static const kSplashScreenOne = '/SplashScreenOne';
  static const kSignUpView = '/SignUpView';
  static const kForgetPassWordView = '/ForgetPassWordView';
  static const kVerifyPassWordView = '/VerifyPassWordView';
  static const kOnBordingView = '/OnBordingView';
  static const khomeView = '/homeView';
  static const kSearchView = '/searchview';
  static const kCreatePost = '/createPost';
  static const kCommunityPage = '/CommunityPage';
  static const kCommentsViewg = '/CommentsView';
  static const kChatbotPag = '/ChatbotPag';
  static const kCourseOverview = '/CourseOverview';
  static const kCustomBottomNavigationBar = '/CustomBottomNavigationBar';
  static const kRecommendedContentView = '/RecommendedContentView';
  static const kInterviewView = '/InterviewView';
  static const kSearchResultView = '/SearchResultView';
  static const kFilterView = '/FilterView';
  static const kShowCourse = '/ShowCourse';
  static const kShowCourseText = '/ShowCourseText';
  static const kAllcourseOfSkillsView = '/AllcourseOfSkillsView';
  static const kPaymentMethod = '/PaymentMethod';
  static const kCardNumberPage = '/CardNumberPage';
  static const kQuizView = '/QuizView';
  static const kAiAssessmentEvolviSense = '/aiAssessmentEvolviSense';
  static const kPresentationTest = '/PresentationTest';
  static const kInterviewTest = '/InterviewTest';
  static const kChatbotPageWithCubit = '/ChatbotPageWithCubit';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: kCourseOverview,
        builder: (context, state) {
          final id = state.extra as int;
          return BlocProvider(
            create:
                (context) => ModulesOfCourseCubit()..getModulesOfCourse(id: id),
            child: CourseOverview(),
          );
        },
      ),
      GoRoute(
        path: kShowCourseText,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final moduleId = extra['moduleId'];
          final courseId = extra['courseId'];

          return BlocProvider(
            create:
                (context) =>
                    ModulesCubit()
                      ..getAllModules(courseId: courseId, moduleId: moduleId),
            child: ShowCourseText(),
          );
        },
      ),
      GoRoute(path: kChatbotPag, builder: (context, state) => ChatbotPage()),
      GoRoute(
        path: kCardNumberPage,
        builder: (context, state) => CardNumberPage(),
      ),
      GoRoute(
        path: kQuizView,
        builder:
            (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => QuizQuesCubit()..getQuestions(quizId: 1),
                ),
                BlocProvider(create: (context) => QuizAnswersCubit()),
                BlocProvider(create: (context) => QuizAttemptsCubit()),
                BlocProvider(create: (context) => ScoreCubit()),
              ],
              child: QuizView(),
            ),
      ),

      GoRoute(
        path: kPaymentMethod,
        builder: (context, state) => PaymentMethod(),
      ),
      GoRoute(
        path: kAllcourseOfSkillsView,
        builder: (context, state) {
          final skillId = state.extra as int;
          return BlocProvider(
            create:
                (context) =>
                    AllCoursesOfSkillCubit()
                      ..getAllCoursesOfSkill(skillId: skillId),
            child: AllcourseOfSkillsView(),
          );
        },
      ),
      GoRoute(
        path: kShowCourse,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final moduleId = extra['moduleId'];
          final courseId = extra['courseId'];

          return BlocProvider(
            create:
                (context) =>
                    ModulesCubit()
                      ..getAllModules(courseId: courseId, moduleId: moduleId),
            child: ShowCourseVideo(),
          );
        },
      ),
      GoRoute(
        path: kSearchView,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => SearchCubit(),
            child: SearchView(),
          );
        },
      ),
      GoRoute(
        path: kSearchResultView,
        builder: (context, state) {
          final keyword = state.extra as String;
          return BlocProvider(
            create: (context) => SearchCubit(),
            child: SearchResultView(searchquery: keyword),
          );
        },
      ),

      // GoRoute(
      //   path: kFilterView,
      //   builder: (context, state) {
      //     return BlocProvider.value(
      //       value: BlocProvider.of<SearchCubit>(context),
      //       child: FilterView(),
      //     );
      //   },
      // ),
      GoRoute(
        path: kInterviewView,
        builder: (context, state) => InterviewView(),
      ),
      GoRoute(
        path: kPremiumView,
        builder:
            (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => PaymentPlansCubit()..getPaymentPlans(),
                ),
                BlocProvider(create: (context) => PaymentSubscriptionCubit()),
              ],
              child: PremiumView(),
            ),
      ),

      GoRoute(
        path: kRecommendedContentView,
        builder:
            (context, state) => BlocProvider(
              create:
                  (context) => RecommendCoursesCubit()..getRecommendCourses(),
              child: RecommendedContentView(),
            ),
      ),

      GoRoute(
        path: kCustomBottomNavigationBar,
        builder:
            (context, state) => BlocProvider(
              create: (context) => CoursesCubit()..getgetMostWatchingSkill(),
              child: CurvedNavWithImage(),
            ),
      ),
      GoRoute(
        path: kCommunityPage,
        builder:
            (context, state) =>
                CreatePostProviders.buildWithProviders(CommunityPage()),
      ),
      GoRoute(
        path: '/',
        builder:
            (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => LoginCubit()),
                BlocProvider(
                  create:
                      (context) =>
                          AiAssessmentCubit(AiAssessmentRepositoryImpl()),
                ),
              ],
              child: AiAssessmentEvolviSense(
                prompts: [
                  "Tell us about yourself",
                  "Describe a challenge you overcame",
                  "What motivates you?",
                ],
              ),
            ),
      ),
      GoRoute(
        path: kSignUpView,
        builder:
            (context, state) => BlocProvider(
              create: (context) => RegisterCubit(),
              child: SignUpView(),
            ),
      ),
      GoRoute(
        path: kloginView,
        builder:
            (context, state) => BlocProvider(
              create: (context) => LoginCubit(),
              child: LoginView(),
            ),
      ),
      GoRoute(
        path: kForgetPassWordView,
        builder:
            (context, state) => BlocProvider(
              create: (context) => ForgetPassCubit(),
              child: ForgetPasswordView(),
            ),
      ),
      GoRoute(
        path: kVerifyPassWordView,
        builder:
            (context, state) => BlocProvider(
              create: (context) => VerifyPassCubit(),
              child: VerifyPasswordView(),
            ),
      ),
      GoRoute(
        path: kPasswordResetView,
        builder: (context, state) => PasswordResetView(),
      ),

      GoRoute(
        path: kSplashScreenOne,
        builder: (context, state) => SplashScreenOne(),
      ),
      GoRoute(
        path: kSetNewPassword,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final String code = extra['code'];
          final String email = extra['email'];

          return BlocProvider(
            create: (context) => ResetCubit(code, email),
            child: const SetNewPassword(),
          );
        },
      ),
      GoRoute(
        path: kCommentsViewg,
        builder: (context, state) {
          final postModel = state.extra as PostModel;
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => CommentCubit()),
              BlocProvider(
                create:
                    (context) =>
                        FetchAllcommentsCubit()..fetchAllComments(postModel.id),
              ),
            ],
            child: CommentsView(postModel: postModel),
          );
        },
      ),

      GoRoute(
        path: kAssessmentView,
        builder: (context, state) => AssessmentView(),
      ),
      GoRoute(
        path: kTestView,
        builder:
            (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => QuestionCubit()),
                BlocProvider(create: (context) => SubmitQuesCubit()),
              ],
              child: TestView(),
            ),
      ),
      GoRoute(
        path: kTestResultView,
        builder: (context, state) {
          final extra = state.extra;
          if (extra is List<SkillResult>) {
            return TestResultView(skillResult: extra);
          } else {
            return Scaffold(body: Center(child: Text('No results found')));
          }
        },
      ),

      GoRoute(path: '/', builder: (context, state) => LogoView()),
      GoRoute(
        path: kOnBordingView,
        builder: (context, state) => OnBoardingPageview(),
      ),

      GoRoute(path: khomeView, builder: (context, state) => HomeView()),
      GoRoute(
        path: kCreatePost,
        builder:
            (context, state) =>
                CreatePostProviders.buildWithProviders(CreatePostPage()),
      ),
      GoRoute(
        path: kAiAssessmentEvolviSense,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final testType = extra?['testType'] ?? 'Interview Assessment';
          final prompts =
              extra?['prompts'] ??
              [
                'Tell us about yourself.',
                'Describe a challenge you overcame.',
                'What motivates you?',
              ];
          final durationPerPrompt = extra?['durationPerPrompt'] ?? 30;

          return BlocProvider.value(
            value: BlocProvider.of<AiAssessmentCubit>(context),
            child: AiAssessmentEvolviSense(
              testType: testType,
              prompts: prompts,
              durationPerPrompt: durationPerPrompt,
            ),
          );
        },
      ),
    ],
  );
}
