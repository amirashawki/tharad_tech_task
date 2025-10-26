import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tharad_tech_task/features/auth/data/repo/auth_repo_impl.dart';

part 'verify_pass_state.dart';

class VerifyPassCubit extends Cubit<VerifyPassState> {
  VerifyPassCubit() : super(VerifyPassInitial());
  Future<void> verifyPassWord({required otp, required email}) async {
    
    emit(VerifyPassLoading());
    var result = await AuthRepoImpl().verifyPassWord(otp: otp, email: email);
    result.fold(
      (failure) {
        emit(VerifyPassFailure(errMessage: failure.errMessge));
      },
      (message) {
        print(otp);
        emit(VerifyPassSucess(message));
      },
    );
  }
}
