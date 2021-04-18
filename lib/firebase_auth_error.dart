class FirebaseAuthError {
  // FirebaseAuth errorcode
  static const String EMAIL_ALREADY_USE = 'email-already-in-use';
  static const String INVALID_EMAIL = 'invalid-email';
  static const String WRONG_PASSWORD = 'wrong-password';
  static const String USER_NOT_FOUND = 'user-not-found';
  static const String USER_DISABLED = 'user-disabled';
  static const String TOO_MANY_REQUESTS = 'too-many-requests';
  static const String OPERATION_NOT_ALLOWED = 'operation-not-allowed';

  static convErrorMessage(String? errorCode) {
    switch (errorCode) {
      case EMAIL_ALREADY_USE:
        return 'このメールアドレスは既に登録されています。';

      case INVALID_EMAIL:
        return 'メールアドレスが間違っています。';

      case WRONG_PASSWORD:
        return 'パスワードが間違っています。';

      case USER_NOT_FOUND:
        return 'このアカウントは存在しません。';

      case USER_DISABLED:
        return 'このメールアドレスは無効になっています。';

      case TOO_MANY_REQUESTS:
        return 'ネットワークが混雑しています。\nもう一度試してみてください。';

      case OPERATION_NOT_ALLOWED:
        return 'メールアドレスとパスワードでのログインは\n有効になっていません。';

      default:
        return '予期せぬエラーが発生しました。';
    }
  }
}
