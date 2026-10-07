import 'package:flutter/foundation.dart';

/// Estado de autenticação simples em memória, sem Firebase ainda.
/// Quando o Firebase Authentication for conectado, troque a implementação
/// interna por `FirebaseAuth.instance.authStateChanges()` e mantenha a
/// mesma interface pública (isLoggedIn / login / logout) para não ter que
/// mexer nas telas que já consomem esta classe.
class AuthState extends ChangeNotifier {
  AuthState._internal();
  static final AuthState instance = AuthState._internal();

  bool _isLoggedIn = false;
  String? _userEmail;

  bool get isLoggedIn => _isLoggedIn;
  String? get userEmail => _userEmail;

  void login(String email) {
    _isLoggedIn = true;
    _userEmail = email;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _userEmail = null;
    notifyListeners();
  }
}
