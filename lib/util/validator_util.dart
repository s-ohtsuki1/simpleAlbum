import '../constants.dart';

class ValidatorUtil {
  validEmailForm(String? value) {
    if (value!.isEmpty) {
      // メールアドレスは必須
      return kEmailNullError;
    } else if (value.isNotEmpty && !emailValidatorRegExp.hasMatch(value)) {
      // メールアドレスの形式が違う
      return kInvalidEmailError;
    } else {
      return null;
    }
  }

  validPasswordForm(String? value, String? matchValue) {
    if (value!.isEmpty) {
      // パスワードは必須
      return kPassNullError;
    } else if (value.isNotEmpty && value.length < 8) {
      // パスワードは8文字以上
      return kShortPassError;
    } else if (matchValue != null && value != matchValue!) {
      // パスワード（確認）と一致しない
      return kMatchPassError;
    } else {
      return null;
    }
  }
}
