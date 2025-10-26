

import 'package:dartz/dartz.dart';
import 'package:tharad_tech_task/core/errors/failures.dart';
import 'package:tharad_tech_task/features/auth/data/model/auth_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, AuthModel>> login({email, passWord});
  Future<Either<Failure, AuthModel>> register({
    email,
    passWord,
    userName,
    confirmPassword,
    image,
  });
 
  Future<Either<Failure, String>> verifyPassWord({otp, email});
  
}
