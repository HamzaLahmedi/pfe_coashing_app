import '../models/user.dart';

class GlobalController {
  static String? token;
  static User? currentUser;

  static void clearSession() {
    token = null;
    currentUser = null;
  }

  static bool get isAuthenticated => token != null;
}
