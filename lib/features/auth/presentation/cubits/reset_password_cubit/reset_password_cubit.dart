import 'package:bloc/bloc.dart';
import 'package:e_commerce/core/services/api_auth_service.dart';
import 'package:equatable/equatable.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ApiAuthService apiAuthService;
  String? email; // ✨ Add this line

  ResetPasswordCubit(this.apiAuthService) : super(ResetPasswordInitial());

  Future<void> forgotPassword(String userEmail) async {
    emit(ResetPasswordLoading());
    try {
      email = userEmail; // ✨ Save it internally
      await apiAuthService.forgotPassword(email: userEmail);
      emit(ResetPasswordEmailSent());
    } catch (e) {
      emit(ResetPasswordFailure(e.toString()));
    }
  }

  Future<void> verifyResetCode(String code) async {
    emit(ResetPasswordLoading());
    try {
      final data = await apiAuthService.verifyResetCode(
        email: email!, // ✨ Use the stored email
        code: code,
      );
      emit(ResetPasswordCodeVerified(data['resetToken'], data['userId']));
    } catch (e) {
      emit(ResetPasswordFailure(e.toString()));
    }
  }

  Future<void> resetPassword(String token, String newPassword) async {
    emit(ResetPasswordLoading());
    try {
      await apiAuthService.resetPassword(
        email: email!, // ✨ Use the stored email
        token: token,
        newPassword: newPassword,
      );
      emit(ResetPasswordSuccess());
    } catch (e) {
      emit(ResetPasswordFailure(e.toString()));
    }
  }
}
