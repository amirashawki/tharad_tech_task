import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tharad_tech_task/core/errors/failures.dart';
import 'package:tharad_tech_task/core/utils/api_services.dart' show ApiServices;
import 'package:tharad_tech_task/features/auth/data/model/auth_model.dart'
    show AuthModel, fromJson;
import 'package:tharad_tech_task/features/auth/data/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  @override
  Future<Either<Failure, AuthModel>> login({email, passWord}) async {
    try {
      var response = await ApiServices().post(
        endPoint: 'auth/login',
        data: {'email': email, 'password': passWord},
      );

      if (response['data'] != null) {
        final authModel = AuthModel.fromJson({
          ...response['data'],
          'message': response['message'],
          'status': response['status'],
        });
        return right(authModel);
      } else {
        return left(
          ServerFailure('Invalid response format: missing data field.'),
        );
      }
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }

      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> verifyPassWord({otp, email}) async {
    try {
      final data = await ApiServices().get(
        endPoint: 'otp?email=$email&otp=$otp',
      );

      print('📩 RESPONSE: $data');

      if (data['status'] == 'success') {
        return right(data['message']);
      } else {
        return left(
          ServerFailure(data['message'] ?? 'OTP verification failed'),
        );
      }
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
        return left(
          ServerFailure('Invalid response format: missing data field.'),
        );
      }
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure('Unexpected error: $e'));
    }
  }

  // @override
  // Future<Either<Failure, AuthModel>> getProfileData() async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final response = await ApiServices().get(
  //       endPoint: 'auth/profile-details',
  //     );

  //     print("📥 Profile response: $response");

  //     if (response['status'] == 'success' && response['data'] != null) {
  //       final data = response['data'];

  //       await prefs.setString('user_name', data['name'] ?? '');
  //       await prefs.setString('user_email', data['email'] ?? '');
  //       await prefs.setString('user_image', data['image'] ?? '');

  //       final authModel = AuthModel.fromJson({
  //         ...data,
  //         'message': response['message'],
  //         'status': response['status'],
  //       });
  //       await prefs.setString('cached_profile', jsonEncode(data));

  //       return right(authModel);
  //     } else {
  //       return left(
  //         ServerFailure(response['message'] ?? 'فشل في تحميل البيانات'),
  //       );
  //     }
  //   } on DioException catch (e) {
  //     return left(ServerFailure.fromDioException(e));
  //   } catch (e) {
  //     return left(ServerFailure(e.toString()));
  //   }
  // }

  @override
  Future<Either<Failure, AuthModel>> updateProfileData({
    email,
    oldpassWord,
    userName,
    newPassword,
    image,
    confirmPassword,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final response = await ApiServices().put(
        endPoint: 'Update-Profile',
        data: {
          '_method': 'PUT',
          'email': email,
          'old_password': oldpassWord,
          'username': userName,
          'new_password': newPassword,
          'confirm_password': confirmPassword,
          if (image != null)
            'image': await MultipartFile.fromFile(
              image.path,
              filename: image.path.split('/').last,
            ),
        },
        isFormData: true,
      );

      if (response['data'] != null) {
        final data = response['data'];
        final authModel = AuthModel.fromJson({
          ...data,
          'message': response['message'],
          'status': response['status'],
        });

        await prefs.setString('cached_profile', jsonEncode(data));

        return right(authModel);
      } else {
        return left(
          ServerFailure('Invalid response format: missing data field.'),
        );
      }
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure('Unexpected error: $e'));
    }
  }

  Future<Either<Failure, String>> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final response = await ApiServices().delete(endPoint: 'auth/logout');

      print("📤 LOGOUT RESPONSE: $response");

      if (response['status'] == 'success') {
        await prefs.clear();
        return right(response['message'] ?? 'تم تسجيل الخروج بنجاح ');
      } else {
        return left(ServerFailure(response['message'] ?? 'فشل تسجيل الخروج '));
      }
    } on DioException catch (e) {
      print(" DioException: ${e.response?.data}");
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      print(" Unexpected error: $e");
      return left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, AuthModel>> getprofileData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final response = await ApiServices().get(endPoint: 'profile-details');

      print("📥 Profile response: $response");

      if (response['status'] == 'success' && response['data'] != null) {
        final data = response['data'];

        await prefs.setString('user_name', data['name'] ?? '');
        await prefs.setString('user_email', data['email'] ?? '');
        await prefs.setString('user_image', data['image'] ?? '');

        final authModel = AuthModel.fromJson({
          ...data,
          'message': response['message'],
          'status': response['status'],
        });

        await prefs.setString('cached_profile', jsonEncode(data));

        return right(authModel);
      } else {
        return left(
          ServerFailure(response['message'] ?? 'فشل في تحميل البيانات'),
        );
      }
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
