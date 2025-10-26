import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tharad_tech_task/core/errors/failures.dart';
import 'package:tharad_tech_task/core/utils/api_services.dart' show ApiServices;
import 'package:tharad_tech_task/features/auth/data/model/auth_model.dart'
    show AuthModel, fromJson;
import 'package:tharad_tech_task/features/auth/data/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  @override
  Future<Either<Failure, AuthModel>> login({email, passWord}) async {
    try {
      var data = await ApiServices().post(
        endPoint: 'auth/login',
        data: {'email': email, 'passWord': passWord},
      );

      final token = data['data']['token'];

      return right(AuthModel.fromJson(data['data']));
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }

      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthModel>> verifyPassWord({code, email}) async {
    try {
      var data = await ApiServices().post(
        endPoint: 'Accounts/ResetPassword',
        data: {'code': code, 'email': email},
      );
      print('📩 MESSAGE: ${data['message']}');

      return Right(AuthModel.fromJson(data));
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }

      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthModel>> register({
  email,
  passWord,
  userName,
  confirmPassword,
  image,
}) async {
  try {
    var response = await ApiServices().post(
      endPoint: 'auth/register',
      data: {
        'email': email,
        'username': userName,
        'password': passWord,
        'password_confirmation': confirmPassword,
        if (image != null)
          'image': await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
          ),
      },
      isFormData: true,
    );

    if (response['data'] != null) {
      final authModel = AuthModel.fromJson({
        ...response['data'],
        'message': response['message'],
        'status': response['status'],
      });
      return right(authModel);
    } else {
      return left(ServerFailure('Invalid response format: missing data field.'));
    }
  } on DioException catch (e) {
    return left(ServerFailure.fromDioException(e));
  } catch (e) {
    return left(ServerFailure('Unexpected error: $e'));
  }
}

}
