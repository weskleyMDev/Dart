import 'package:password_dart/password_dart.dart';

import '../dao/usuario_dao.dart';
import '../models/user_model.dart';
import 'generic_service.dart';

class UserService implements GenericService<UserModel> {
  final UsuarioDAO _usuarioDAO;
  UserService(this._usuarioDAO);

  @override
  Future<bool> delete(int id) async {
    return _usuarioDAO.delete(id);
  }

  @override
  Future<List<UserModel>> findAll() async {
    return _usuarioDAO.findAll();
  }

  @override
  Future<UserModel?> findOne(int id) async {
    return _usuarioDAO.findOne(id);
  }

  @override
  Future<bool> save(UserModel value) async {
    if (value.id != null) {
      _hashPassword(value);
      return _usuarioDAO.update(value);
    } else {
      _hashPassword(value);
      return _usuarioDAO.create(value);
    }
  }

  Future<UserModel?> findByEmail(String email) async {
    return _usuarioDAO.findByEmail(email);
  }

  _hashPassword(UserModel value) {
    final hash = Password.hash(value.senha!, PBKDF2());
    value.senha = hash;
  }
}
