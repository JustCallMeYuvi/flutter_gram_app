import 'package:hive/hive.dart';
import '../core/utils/password_helper.dart';

class AuthService {
  final Box usersBox = Hive.box('users');

  Future<bool> registerUser({
    required String mobile,
    required String password,
  }) async {
    if (usersBox.containsKey(mobile)) {
      return false;
    }

    await usersBox.put(
      mobile,
      {
        'mobile': mobile,
        'password': PasswordHelper.hashPassword(password),
      },
    );

    return true;
  }
}
