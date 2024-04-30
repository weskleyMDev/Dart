import 'package:mysql1/mysql1.dart';

import '../infra/database/db_config.dart';
import '../infra/dependency_injector/injections/injections.dart';
import '../models/user_model.dart';
import 'dao.dart';

class UsuarioDAO implements DAO {
  // final DBConfig _dbConfig;
  // UsuarioDAO(this._dbConfig);

  final di = Injections.initializer();

  @override
  Future create(value) {
    throw UnimplementedError();
  }

  @override
  Future delete(int id) {
    throw UnimplementedError();
  }

  @override
  Future<List<UserModel>> findAll() async {
    final connect = await di.get<DBConfig>().connection;
    final res = await connect.query("SELECT * FROM dart.usuarios;");
    final List<UserModel> usuarios = [];
    for (ResultRow e in res) {
      usuarios.add(UserModel.fromMap(e.fields));
    }
    return usuarios;
  }

  @override
  Future findOne(int id) async {
    final connect = await di.get<DBConfig>().connection;
    final res =
        await connect.query("SELECT * FROM dart.usuarios WHERE id = $id;");
    if (res.length <= 0) {
      throw Exception('[ERROR/DB] -> Usuário id: $id não encontrado/existe');
    }
    final usuario = UserModel.fromMap(res.first.fields);
    return usuario;
  }

  @override
  Future update(value) {
    throw UnimplementedError();
  }
}
