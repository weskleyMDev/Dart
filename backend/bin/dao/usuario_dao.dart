import '../infra/database/db_config.dart';
import '../models/user_model.dart';
import 'dao.dart';

class UsuarioDAO implements DAO<UserModel> {
  final DBConfig _dbConfig;
  UsuarioDAO(this._dbConfig);

  @override
  Future<bool> create(UserModel value) async {
    final res = await _dbConfig.execQuery(
        "INSERT INTO dart.usuarios (nome, email, password) VALUES ('${value.nome}', '${value.email}', '${value.senha}');");
    return res.affectedRows != 0;
  }

  @override
  Future<bool> delete(int id) async {
    final res = await _dbConfig.execQuery("DELETE FROM dart.usuarios WHERE id = $id;");
    return res.affectedRows != 0;
  }

  @override
  Future<List<UserModel>> findAll() async {
    final res = await _dbConfig.execQuery("SELECT * FROM dart.usuarios;");
    return res
        .map((e) => UserModel.fromMap(e.fields))
        .toList()
        .cast<UserModel>();
  }

  @override
  Future<UserModel?> findOne(int id) async {
    final res = await _dbConfig.execQuery("SELECT * FROM dart.usuarios WHERE id = $id;");
    final usuario = UserModel.fromMap(res.first.fields);
    return (res.affectedRows == 0) ? null : usuario;
  }

  Future<UserModel?> findByEmail(String email) async {
    final res =
        await _dbConfig.execQuery("SELECT * FROM dart.usuarios WHERE email = '$email';");
    final user = UserModel.fromMap(res.first.fields);
    return (res.affectedRows == 0) ? null : user;
  }

  @override
  Future<bool> update(UserModel value) async {
    final res = await _dbConfig.execQuery(
        "UPDATE dart.usuarios SET nome = '${value.nome}', email = '${value.email}', password = '${value.senha}' WHERE id = ${value.id};");
    return res.affectedRows != 0;
  }

}
