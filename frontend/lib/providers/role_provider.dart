import 'package:flutter/material.dart';

enum UserRole {
  client,
  cleaner,
}

class RoleProvider extends ChangeNotifier {
  UserRole _role = UserRole.client;
  
  UserRole get role => _role;
  
  bool get isCleaner => _role == UserRole.cleaner;
  
  void setRole(UserRole role) {
    _role = role;
    notifyListeners();
  }
} 