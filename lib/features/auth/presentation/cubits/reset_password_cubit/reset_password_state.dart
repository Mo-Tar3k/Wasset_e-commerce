part of 'reset_password_cubit.dart';

abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object?> get props => [];
}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordLoading extends ResetPasswordState {}

class ResetPasswordEmailSent extends ResetPasswordState {}

class ResetPasswordCodeVerified extends ResetPasswordState {
  final String resetToken;
  final String userId;

  const ResetPasswordCodeVerified(this.resetToken, this.userId);

  @override
  List<Object?> get props => [resetToken, userId];
}

class ResetPasswordSuccess extends ResetPasswordState {}

class ResetPasswordFailure extends ResetPasswordState {
  final String message;

  const ResetPasswordFailure(this.message);

  @override
  List<Object?> get props => [message];
}
