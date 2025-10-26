import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tharad_tech_task/features/auth/data/repo/auth_repo_impl.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());

  Future<void> logout() async {
    emit(LogoutLoading());
    final result = await AuthRepoImpl().logout();

    result.fold(
      (failure) => emit(LogoutFailure(failure.errMessge)),
      (message) => emit(LogoutSuccess(message)),
    );
  }
}
