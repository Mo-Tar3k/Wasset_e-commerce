import 'package:dio/dio.dart';
import 'dart:developer';

import 'package:e_commerce/core/services/shared_preferences_singleton.dart';
import 'package:e_commerce/core/services/user_local_service.dart';

class ApiAuthService {
  static const String baseUrl = 'http://waseet.runasp.net/api/';
  final Dio _dio;

  ApiAuthService() : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<Map<String, dynamic>> registerUser({
    required String displayName,
    required String email,
    required String phoneNumber,
    required String password,
    required String role,
  }) async {
    final requestData = {
      "displayName": displayName,
      "email": email,
      "phoneNumber": phoneNumber,
      "password": password,
      "role": role,
    };

    log('🔼 Sending registration data: $requestData');

    final response = await _dio.post(
      'auth/register',
      data: requestData,
      options: Options(
        headers: {'Content-Type': 'application/json'},
        validateStatus: (_) => true,
      ),
    );

    log('🔽 Status Code: ${response.statusCode}');
    log('🔽 Response Body: ${response.data}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    } else {
      // هنا نقرأ الحقل errors من الرد
      final body = response.data;
      if (body is Map<String, dynamic> && body['errors'] is List) {
        final List errors = body['errors'];
        final message = errors.cast<String>().join('\n');
        throw Exception(message);
      }
      // لو ما عندناش الحقل errors، نرمي الرسالة العامة
      throw Exception('Registration failed: ${response.data}');
    }
  }

  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        'auth/login',
        data: {"email": email, "password": password},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to login user: ${response.data}');
      }
      return response.data;
    } catch (e) {
      throw Exception('Error logging in user: $e');
    }
  }

  Future<void> logoutUser() async {
    try {
      final response = await _dio.post('auth/Logout');
      if (response.statusCode != 200) {
        throw Exception('Failed to logout user: ${response.data}');
      }

      // 🧹 امسح بيانات المستخدم والتوكن بعد تسجيل الخروج
      await Prefs.remove('token');
      await UserLocalService.clearUser();
    } catch (e) {
      throw Exception('Error logging out user: $e');
    }
  }

  Future<bool> isTokenValid() async {
    final token = Prefs.getString('token');
    if (token.isEmpty) return false;

    try {
      final response = await _dio.get(
        'auth/validate-token', // ⚠️ Endpoint لازم يكون موجود في API
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (_) => true,
        ),
      );
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      final response = await _dio.post(
        'auth/forgot-password',
        data: {"email": email},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to send reset code: ${response.data}');
      }
    } catch (e) {
      throw Exception('Error in forgotPassword: $e');
    }
  }

  Future<Map<String, dynamic>> verifyResetCode({
    required String email,
    required String code,
  }) async {
    try {
      final response = await _dio.post(
        'auth/verify-reset-code',
        data: {"email": email, "code": code},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to verify reset code: ${response.data}');
      }
      return response.data;
    } catch (e) {
      throw Exception('Error in verifyResetCode: $e');
    }
  }

  Future<void> resetPassword({
    required String email,
    required String token,
    required String newPassword,
  }) async {
    try {
      final response = await _dio.post(
        'auth/reset-password',
        data: {"email": email, "Token": token, "newpassword": newPassword},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to reset password: ${response.data}');
      }
    } catch (e) {
      throw Exception('Error in resetPassword: $e');
    }
  }
}
