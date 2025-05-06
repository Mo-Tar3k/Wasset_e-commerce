import 'dart:convert';
import 'package:e_commerce/features/auth/data/domain/entites/user_entity.dart';
import 'package:e_commerce/features/auth/data/model/user_model.dart';
import 'package:e_commerce/core/services/shared_preferences_singleton.dart'; // تأكد إن عندك Prefs هنا
import 'package:e_commerce/constants.dart'; // فيه kUserData

class UserLocalService {
  /// Save the user data locally
  static Future<void> saveUser(UserEntity user) async {
    final userModel = UserModel.fromEntity(user);
    final jsonString = jsonEncode(userModel.toMap());
    await Prefs.setString(kUserData, jsonString);
  }

  /// Load the user data locally
  static Future<UserEntity?> loadUser() async {
    final jsonString = Prefs.getString(kUserData);
    if (jsonString.isEmpty) {
      return null;
    }
    final Map<String, dynamic> userMap = jsonDecode(jsonString);
    return UserModel.fromJson(userMap);
  }

  /// Update specific fields of the user locally
  static Future<void> updateUserFields({
    String? name,
    String? phoneNumber,
    String? profileImage,
    String? profession,
    String? bio,
  }) async {
    final currentUser = await loadUser();
    if (currentUser == null) return;

    final updatedUser = UserEntity(
      uId: currentUser.uId,
      email: currentUser.email,
      name: name ?? currentUser.name,
      role: currentUser.role,
      phoneNumber: phoneNumber ?? currentUser.phoneNumber,
      profileImage: profileImage ?? currentUser.profileImage,
      profession: profession ?? currentUser.profession,
      bio: bio ?? currentUser.bio,
    );

    await saveUser(updatedUser);
  }

  /// Clear user data (e.g., when logging out)
  static Future<void> clearUser() async {
    await Prefs.remove(kUserData);
  }

  static Future<void> updateUser({
    required String displayName,
    required String profileImage,
    String? bio,
  }) async {
    final currentUser = await loadUser();
    if (currentUser != null) {
      final updatedUser = currentUser.copyWith(
        name: displayName,
        profileImage: profileImage,
        bio: bio ?? '',
      );
      await saveUser(updatedUser);
    }
  }
}
