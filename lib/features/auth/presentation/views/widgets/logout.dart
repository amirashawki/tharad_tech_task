import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tharad_tech_task/core/widgets/showSnackBar.dart';
import 'package:tharad_tech_task/features/auth/presentation/manager/cubit/logout_cubit.dart';


class logout extends StatelessWidget {
  const logout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    
    return    BlocListener<LogoutCubit, LogoutState>(
  listener: (context, state) {
    if (state is LogoutLoading) {
      showSnackBar(context, text: 'جارٍ تسجيل الخروج...');
    } else if (state is LogoutSuccess) {
      showSnackBar(context, text: 'تم تسجيل الخروج بنجاح ✅');
      Navigator.pushReplacementNamed(context, '/login');
    } else if (state is LogoutFailure) {
      showSnackBar(context, text: state.error);
    }
  },
  child: GestureDetector(
    onTap: () {
      context.read<LogoutCubit>().logout();
    },
    child: Center(
      child: Text(
        'تسجيل الخروج',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: const Color(0xffFF0000),
        ),
      ),
    ),
      
      
      
  ),
    );
  }
}
