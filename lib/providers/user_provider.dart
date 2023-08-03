import 'package:amazon_clone/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    token: '',
    type: '',
    cart: [],
  );

  User get user => _user;

  void setUser(String newUser) {
    _user = User.fromJson(newUser);
    notifyListeners();
  }

  void setUserWithModel(User user) {
    _user = user;
    notifyListeners();
  }
}
