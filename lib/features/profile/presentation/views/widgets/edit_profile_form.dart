import 'dart:io';
import 'dart:async';
import 'package:e_commerce/core/helper_funcations/show_error_bar.dart';
import 'package:e_commerce/core/services/api_profile_service.dart';
import 'package:e_commerce/core/widgets/custom_button.dart';
import 'package:e_commerce/features/auth/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'profile_text_field.dart';

class EditProfileForm extends StatefulWidget {
  final UserModel user;
  const EditProfileForm({super.key, required this.user});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final nameCtrl = TextEditingController();
  final bioCtrl = TextEditingController();
  File? selectedImage;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    nameCtrl.text = widget.user.name;
    bioCtrl.text = widget.user.bio ?? '';
  }

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null && mounted) {
      setState(() => selectedImage = File(image.path));
    }
  }

  Future<bool> _updateUserProfileInBackground(
    Map<String, dynamic> params,
  ) async {
    return await ProfileService.updateUserProfile(
      displayName: params['displayName'],
      bio: params['bio'],
      profileImage: params['profileImage'],
    );
  }

  Future<void> updateProfile() async {
    if (!mounted) return; // Ensure widget is still mounted
    setState(() => isLoading = true);

    final success = await _updateUserProfileInBackground({
      'displayName': nameCtrl.text.trim(),
      'bio': bioCtrl.text.trim(),
      'profileImage': selectedImage,
    });

    if (!mounted) return; // Ensure widget is still mounted
    setState(() => isLoading = false);

    showMassgeBar(context, success ? '✅ Profile updated' : '❌ Failed');

    if (success) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 30,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 55,
                backgroundImage:
                    selectedImage != null
                        ? FileImage(selectedImage!)
                        : (widget.user.profileImage != null
                                ? NetworkImage(widget.user.profileImage!)
                                : const AssetImage(
                                  'assets/images/default_avatar.png',
                                ))
                            as ImageProvider,
              ),
              Positioned(
                bottom: 0,
                right: 4,
                child: GestureDetector(
                  onTap: pickImage,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.deepOrange,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ProfileTextField(controller: nameCtrl, label: 'Name'),
          const SizedBox(height: 16),
          ProfileTextField(controller: bioCtrl, label: 'Bio', maxLines: 3),
          const SizedBox(height: 32),
          isLoading
              ? const CircularProgressIndicator()
              : SizedBox(
                width: double.infinity,
                child: CustomButton(onPressed: updateProfile, text: 'Save'),
              ),
        ],
      ),
    );
  }
}
