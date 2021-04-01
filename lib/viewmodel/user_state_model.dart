import 'package:firebase_auth/firebase_auth.dart';

class UserState {
  static User user =
      FirebaseAuth.instance.setPersistence(Persistence.NONE) as User;

  void setUser(User currentUser) {
    user = currentUser;
  }
}
