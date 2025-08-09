import 'package:hive/hive.dart';
import 'user_modal.dart';

class UserService {
  static const String _boxName = 'users';

  // Save user (for registration or update)
  static Future<void> saveUser(UserModal user) async {
    var box = await Hive.openBox<UserModal>(_boxName);
    await box.put(user.id, user);
  }

  // Get user by email and password (for login)
  static Future<UserModal?> getUserByCredentials(String email, String password) async {
    var box = await Hive.openBox<UserModal>(_boxName);
    try {
      return box.values.firstWhere(
        (user) => user.email == email && user.password == password,
        orElse: () => null,
      );
    } catch (e) {
      return null;
    }
  }

  // Get user by id
  static Future<UserModal?> getUserById(int id) async {
    var box = await Hive.openBox<UserModal>(_boxName);
    return box.get(id);
  }
}
