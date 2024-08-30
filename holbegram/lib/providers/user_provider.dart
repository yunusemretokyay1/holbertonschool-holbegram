import 'package:flutter/foundation.dart';
import 'package:holbegram/methods/auth_methods.dart';
import 'package:holbegram/models/user.dart';

class UserProvider with ChangeNotifier {
  Users? _user;
  final AuthMethods _authMethods = AuthMethods();

  Users? get user => _user;

  Future<void> refreshUser() async {
    _user = await _authMethods.getUserDetails();
    notifyListeners();
  }
}
