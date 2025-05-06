import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/errors/failures.dart';
import 'package:e_commerce/core/services/data_service.dart';
import 'package:e_commerce/core/services/api_auth_service.dart';
import 'package:e_commerce/core/services/shared_preferences_singleton.dart';
import 'package:e_commerce/core/services/user_local_service.dart';
import 'package:e_commerce/features/auth/data/domain/entites/user_entity.dart';
import 'package:e_commerce/features/auth/data/domain/repos/auth_repo.dart';
import 'package:e_commerce/features/auth/data/model/user_model.dart';

class AuthRepoImpl extends AuthRepo {
  final ApiAuthService apiAuthService;
  final DatabaseService databaseService;

  AuthRepoImpl({required this.apiAuthService, required this.databaseService});

  @override
  Future<Either<Failure, UserEntity>> signinWithEmailAndPassword(
    String email,
    String password,
    String role,
  ) async {
    try {
      final data = await apiAuthService.loginUser(
        email: email,
        password: password,
      );

      final userMap = data['user'] as Map<String, dynamic>;

      await Prefs.setString('token', userMap['token']);

      final userEntity = UserEntity(
        uId: userMap['token'], // ✅ استخدام token بدلاً من id
        email: userMap['email'] ?? '',
        name: userMap['displayName'] ?? '',
        role: userMap['role'] ?? '',
        phoneNumber: userMap['phoneNumber'] ?? '',
        profileImage: userMap['profileImage'],
        profession: userMap['profession'],
        bio: userMap['bio'],
      );

      await saveUSerData(users: userEntity);
      return Right(userEntity);
    } catch (e) {
      log("Error in signinWithEmailAndPassword: $e");
      return Left(ServerFailure('Invalid email or password'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
    String role,
    String phoneNumber,
  ) async {
    try {
      final data = await apiAuthService.registerUser(
        displayName: name,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
        role: role,
      );

      final userMap = data['user'] as Map<String, dynamic>;

      final userEntity = UserEntity(
        uId: userMap['token'], // ✅ استخدام التوكن كـ uId
        email: userMap['email'] ?? '',
        name: userMap['displayName'] ?? '',
        role: userMap['role'] ?? '',
        phoneNumber: phoneNumber, // القيمة الأصلية المرسلة
        profileImage: userMap['profileImage'], // ممكن تكون null
        profession: userMap['profession'], // ممكن تكون null
        bio: userMap['bio'], // ممكن تكون null
      );

      await saveUSerData(users: userEntity);

      return Right(userEntity);
    } catch (e) {
      log("Error in createUserWithEmailAndPassword: $e");
      return Left(ServerFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  @override
  Future saveUSerData({required UserEntity users}) async {
    final jsonData = jsonEncode(UserModel.fromEntity(users).toMap());
    await Prefs.setString(kUserData, jsonData);
  }

  // حاليًا لا تستخدم Google/Facebook لأنهم يحتاجون Firebase
  @override
  Future<Either<Failure, UserEntity>> signinWithGoogle() async {
    return Left(ServerFailure('Google login not implemented in API version'));
  }

  @override
  Future<Either<Failure, UserEntity>> signinWithFacebook() async {
    return Left(ServerFailure('Facebook login not implemented in API version'));
  }

  Future<void> logout() async {
    await apiAuthService.logoutUser();
    await UserLocalService.clearUser();
  }
}
