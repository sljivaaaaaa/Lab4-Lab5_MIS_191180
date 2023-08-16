import 'package:collection/collection.dart';
import '../data/user.dart';

class AuthService {
  bool isLoggedIn=true;
  List<User> users = [
    User(id: '1', username: 'admin', password: 'admin'),
    User(id: '2', username: 'user', password: 'user'),
    // Add more users as needed
  ];

  User? currentUser;

  bool login(String username, String password) {
    final user = users.firstWhereOrNull(
          (u) => u.username == username && u.password == password,
    );

    if (user != null) {
      currentUser = user;
      isLoggedIn = true;
      return true;
    }

    return false;
  }

  void logout() {
    currentUser = null;
    isLoggedIn = false;
  }
}

