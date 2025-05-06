import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/errors/failures.dart';
import 'package:e_commerce/features/auth/data/domain/entites/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
    String role,
    String phoneNumber,
  );
  Future<Either<Failure, UserEntity>> signinWithEmailAndPassword(
    String email,
    String password,
    String role,
  );

  Future saveUSerData({required UserEntity users});

  Future<Either<Failure, UserEntity>> signinWithGoogle();
  Future<Either<Failure, UserEntity>> signinWithFacebook();
  Future<void> logout();
}
