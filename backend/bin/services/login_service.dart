import 'dart:developer';

import 'package:password_dart/password_dart.dart';

import '../to/user_to.dart';
import 'user_service.dart';

class LoginService {
  final UserService _service;
  LoginService(this._service);

  Future<int> auth(UserTO to) async {
    try {
      final user = await _service.findByEmail(to.email);
      if (user == null) {
        return -1;
      }
      print(user.senha);
      if (Password.verify(to.senha, user.senha!)) {
        return user.id!;
      } else {
        return -1;
      }
    } catch (e) {
      log('Erro ao autenticar usuário pelo ${to.email}');
    }
    return -1;
  }
}
