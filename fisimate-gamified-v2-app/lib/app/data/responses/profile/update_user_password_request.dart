class UpdateUserPasswordRequest {
  final String oldPassword;
  final String newPassword;
  final String passwordConfirmation;

  UpdateUserPasswordRequest({
    required this.oldPassword,
    required this.newPassword,
    required this.passwordConfirmation,
  });

  Map<String, dynamic> toJson() {
    return {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
      'passwordConfirmation': passwordConfirmation,
    };
  }
}
