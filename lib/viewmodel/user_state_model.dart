import 'package:firebase_auth/firebase_auth.dart';

class UserState {
  static User user;

  void setUser(User currentUser) {
    user = currentUser;
  }
}
