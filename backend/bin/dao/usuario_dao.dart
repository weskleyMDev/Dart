import 'package:mysql1/mysql1.dart';

import '../infra/database/db_config.dart';
import '../infra/dependency_injector/injections/injections.dart';
import '../models/user_model.dart';
import 'dao.dart';

class UsuarioDAO implements DAO<UserModel> {
  // final DBConfig _dbConfig;
  // UsuarioDAO(this._dbConfig);
  final di = Injections.initializer();

  @override
  Future<bool> create(UserModel value) async {
    final res = await _execQuery(
        "INSERT INTO dart.usuarios (nome, email, password) VALUES ('${value.nome}', '${value.email}', '${value.senha}');");
    return res.affectedRows != 0;
  }

  @override
  Future<bool> delete(int id) async {
    final res = await _execQuery("DELETE FROM dart.usuarios WHERE id = $id;");
    return res.affectedRows != 0;
  }

  @override
  Future<List<UserModel>> findAll() async {
    final res = await _execQuery("SELECT * FROM dart.usuarios;");
    return res
        .map((e) => UserModel.fromMap(e.fields))
        .toList()
        .cast<UserModel>();
  }

  @override
  Future<UserModel?> findOne(int id) async {
    final res = await _execQuery("SELECT * FROM dart.usuarios WHERE id = $id;");
    final usuario = UserModel.fromMap(res.first.fields);
    return (res.affectedRows == 0) ? null : usuario;
  }

  @override
  Future<bool> update(UserModel value) async {
    final res = await _execQuery(
        "UPDATE dart.usuarios SET nome = '${value.nome}', email = '${value.email}', password = '${value.senha}' WHERE id = ${value.id};");
    return res.affectedRows != 0;
  }

  Future<Results> _execQuery(String sql) async {
    final connect = await di.get<DBConfig>().connection;
    return await connect.query(sql);
  }
}
