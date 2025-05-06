import 'dart:io';
import 'package:dio/dio.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/services/shared_preferences_singleton.dart';
import 'package:e_commerce/core/services/user_local_service.dart';
import 'package:e_commerce/features/auth/data/model/user_model.dart';

class ProfileService {
  static Future<bool> updateUserProfile({
    File? profileImage,
    required String displayName,
    required String bio,
  }) async {
    try {
      final token = Prefs.getString('token');
      final dio = Dio();

      final formData = FormData.fromMap({
        'DisplayName': displayName,
        'bio': bio,
        if (profileImage != null)
          'profileImage': await MultipartFile.fromFile(profileImage.path),
      });

      final response = await dio.put(
        '${kBaseUrl}auth/UploadProfilePhoto',
        data: formData,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final data = response.data;

        // جلب المستخدم الحالي من SharedPreferences
        final currentUser = await UserLocalService.loadUser();
        if (currentUser == null) throw Exception('No user found');

        final updatedUser = UserModel.fromEntity(currentUser).copyWith(
          name: data['displayName'],
          bio: data['bio'],
          profileImage: data['profileImage'],
        );

        // حفظ التحديث محليًا
        await UserLocalService.saveUser(updatedUser);

        print('\x1B[32m✅ Profile updated successfully!\x1B[0m');
        return true;
      }
      return false;
    } catch (e) {
      print('\x1B[31m❌ Failed to update profile: $e\x1B[0m');
      return false;
    }
  }
}
